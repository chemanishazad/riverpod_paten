import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../core/utils/config.dart';

enum HttpMethod {
  $get,
  $post,
  $delete,
  $patch,
  $put,
}

enum MultipartFileType { image, audio, video, text }

enum ContentType { json, formData, urlEncoded }

class ApiMaster {
  ApiMaster._();

  static final ApiMaster _instance = ApiMaster._();

  factory ApiMaster() {
    return _instance;
  }

  Future<dynamic> fire({
    required String path,
    Map<String, dynamic>? queryParameters,
    bool headerOverride = false,
    Map<String, String>? headers,
    bool? auth = true,
    HttpMethod method = HttpMethod.$get,
    Object? body,
    ContentType contentType = ContentType.json,
    MultipartFileType? multipartFileType,
    Map<String, String>? multipartFields,
    List<File>? files,
  }) async {
    try {
      if (kDebugMode) {
        print("Request : $method > $path ~ $body");
      }

      final Map<String, String> headersInit = {
        'Content-Type': _getContentType(contentType),
      };
      dynamic response;
      Map<String, String>? finalHeaders = !headerOverride
          ? headers
          : {
              ...headersInit,
              ...headers!,
            };
      if (auth!) {
        final SharedPreferences sharedPref =
            await SharedPreferences.getInstance();

        final String cookies =
            '${sharedPref.getString('PHPSESSID')}; ${sharedPref.getString('user')}';

        if (cookies.isNotEmpty) {
          finalHeaders = {...?finalHeaders, "Cookie": cookies};
          print(finalHeaders);
          await sharedPref.setString('cookie', cookies);
        } else {
          throw Exception("Access token is null");
        }
      }

      final config = Config();
      final Uri apiEndpoint =
          config.apiUri(path, queryParameters: queryParameters);
      if (kDebugMode) {
        print("Request : $method > $path ~ $apiEndpoint");
      }

      switch (method) {
        case HttpMethod.$get:
          response = await http.get(
            apiEndpoint,
            headers: finalHeaders,
          );
          break;

        case HttpMethod.$post:
          response = await _handlePostRequest(
            apiEndpoint,
            finalHeaders,
            body,
            contentType,
            multipartFileType,
            multipartFields,
            files,
          );
          break;

        case HttpMethod.$delete:
          response = await _handleDeleteRequest(
            apiEndpoint,
            finalHeaders,
            body,
          );
          break;

        case HttpMethod.$patch:
          response = await _handlePatchRequest(
            apiEndpoint,
            finalHeaders,
            body,
          );
          break;

        case HttpMethod.$put:
          response = await _handlePutRequest(
            apiEndpoint,
            finalHeaders,
            body,
          );
          break;
      }

      if (kDebugMode) {
        print(response);
      }
      if (response != null) {
        try {
          var response1 = response as http.Response;
          if (response1.statusCode == 440) {
            throw Exception("jwt expired");
          }
        } catch (e) {}
      }
      return response;
    } on SocketException catch (e) {
      throw Exception("error > $e");
    } catch (e) {
      throw Exception("error > $e");
    } finally {}
  }

  String _getContentType(ContentType contentType) {
    switch (contentType) {
      case ContentType.json:
        return 'application/json';
      case ContentType.formData:
        return 'multipart/form-data';
      case ContentType.urlEncoded:
        return 'application/x-www-form-urlencoded';
      default:
        return 'application/json';
    }
  }

  Future<http.Response> _handlePostRequest(
    Uri apiEndpoint,
    Map<String, String>? finalHeaders,
    Object? body,
    ContentType contentType,
    MultipartFileType? multipartFileType,
    Map<String, String>? multipartFields,
    List<File>? files,
  ) async {
    if (contentType == ContentType.formData &&
        multipartFileType != null &&
        files != null &&
        files.isNotEmpty) {
      var request = http.MultipartRequest('POST', apiEndpoint);
      request.headers.addAll(finalHeaders!);

      if (multipartFields != null) {
        multipartFields.forEach((key, value) {
          request.fields[key] = value;
        });
      }

      for (var file in files) {
        var multipartFile = await http.MultipartFile.fromPath(
          multipartFileType.toString().split('.').last,
          file.path,
        );
        request.files.add(multipartFile);
      }

      var streamedResponse = await request.send();
      return await http.Response.fromStream(streamedResponse);
    } else {
      return await http.post(
        apiEndpoint,
        headers: finalHeaders,
        body: contentType == ContentType.json ? jsonEncode(body) : body,
      );
    }
  }

  Future<http.Response> _handleDeleteRequest(
    Uri apiEndpoint,
    Map<String, String>? finalHeaders,
    Object? body,
  ) async {
    var request = http.Request("DELETE", apiEndpoint);
    request.headers.addAll(finalHeaders!);

    if (body != null) {
      request.body = jsonEncode(body);
    }

    var streamedResponse = await http.Client().send(request);
    return await http.Response.fromStream(streamedResponse);
  }

  Future<http.Response> _handlePatchRequest(
    Uri apiEndpoint,
    Map<String, String>? finalHeaders,
    Object? body,
  ) async {
    return await http.patch(
      apiEndpoint,
      headers: finalHeaders,
      body: body,
    );
  }

  Future<http.Response> _handlePutRequest(
    Uri apiEndpoint,
    Map<String, String>? finalHeaders,
    Object? body,
  ) async {
    return await http.put(
      apiEndpoint,
      headers: finalHeaders,
      body: body,
    );
  }
}
