import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_paten/models/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/api_master.dart';

class AuthProvider extends StateNotifier<UserModel?> {
  AuthProvider() : super(null) {
    _loadUserFromPrefs();
  }

  bool get isLoggedIn => state != null;

  Future<void> _loadUserFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn) {
      state = UserModel(
        userId: prefs.getInt('userId')!,
        name: prefs.getString('name')!,
        email: prefs.getString('email')!,
        username: prefs.getString('username')!,
      );
    }
  }

  Future<void> _saveUserToPrefs(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', true);
    prefs.setInt('userId', user.userId);
    prefs.setString('name', user.name);
    prefs.setString('email', user.email);
    prefs.setString('username', user.username);
  }

  Future<void> login(String username, String password) async {
    final response = await ApiMaster().fire(
      path: '/authentication',
      method: HttpMethod.$post,
      body: {
        'username': username,
        'password': password,
      },
      contentType: ContentType.urlEncoded,
    );

    if (response != null && response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status_code'] == 202) {
        print(response);
        final user = UserModel.fromJson(data['userInfo']);
        state = user;
        await _saveUserToPrefs(user);
      } else {
        state = null;
      }
    } else {
      state = null;
    }
  }

  Future<void> logout() async {
    final response = await ApiMaster().fire(
      path: '/authentication/logout',
      method: HttpMethod.$get,
    );

    try {
      if (response.statusCode == 200) {
        print(response.body.toString());
        final prefs = await SharedPreferences.getInstance();
        await prefs.clear();
        state = null;
      }
    } catch (e) {
      print(e);
    }
  }
}

final authProvider =
    StateNotifierProvider<AuthProvider, UserModel?>((ref) => AuthProvider());
