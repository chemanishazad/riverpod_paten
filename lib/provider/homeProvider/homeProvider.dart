// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../services/api_master.dart';

// class HomeProvider extends StateNotifier<Map<String, dynamic>> {
//   HomeProvider() : super({'message': null, 'isFileUploaded': false});

//   String? get message => state['message'];
//   bool get isFileUploaded => state['isFileUploaded'];

//   Future<void> uploadFile(
//       String comment, String milestoneId, List<File> files) async {
//     const path = '/rc-main/track/api/submit-attached-more-document';

//     try {
//       final response = await ApiMaster().fire(
//         path: path,
//         method: HttpMethod.$post,
//         contentType: ContentType.formData,
//         multipartFields: {
//           'milestone_add_more_comments': comment,
//           'milestone_id': milestoneId,
//         },
//         files: files,
//         multipartFileType: MultipartFileType.image, // Assuming files are images
//       );

//       if (response != null && response.statusCode == 200) {
//         final data = json.decode(response.body);
//         if (data['message'] == "file uploaded successfully") {
//           state = {'message': data['message'], 'isFileUploaded': true};
//         } else {
//           state = {'message': 'File upload failed', 'isFileUploaded': false};
//         }
//       } else {
//         state = {'message': 'File upload failed', 'isFileUploaded': false};
//       }
//     } catch (e) {
//       state = {'message': 'An error occurred: $e', 'isFileUploaded': false};
//     }
//   }

//   void clearMessage() {
//     state = {'message': null, 'isFileUploaded': false};
//   }
// }

// final homeProvider = StateNotifierProvider<HomeProvider, Map<String, dynamic>>(
//     (ref) => HomeProvider());
