// ignore_for_file: deprecated_member_use

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomSnackbar {
  static void show(BuildContext context, String message,
      {Color colors = Colors.black87}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        backgroundColor: colors,
        behavior: SnackBarBehavior.fixed,
      ),
    );
  }
}

class SingleFileUpload extends StatelessWidget {
  final Function(FilePickerResult?) onFilePicked;

  const SingleFileUpload({super.key, required this.onFilePicked});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        FilePickerResult? result = await FilePicker.platform.pickFiles();
        onFilePicked(result);
      },
      child: const Text('Upload Single File'),
    );
  }
}

class MultipleFileUpload extends StatelessWidget {
  final Function(List<PlatformFile>?) onFilesPicked;

  const MultipleFileUpload({super.key, required this.onFilesPicked});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        FilePickerResult? result =
            await FilePicker.platform.pickFiles(allowMultiple: true);
        onFilesPicked(result?.files);
      },
      child: const Text('Upload Multiple Files'),
    );
  }
}

class UrlLauncherComponent extends StatelessWidget {
  final String url;

  const UrlLauncherComponent({super.key, required this.url});

  void _launchURL() async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _launchURL,
      child: const Text('Open Link'),
    );
  }
}
