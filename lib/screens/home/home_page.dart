// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_paten/core/components/components.dart';
import 'package:riverpod_paten/core/theme/theme_provider.dart';
import 'package:riverpod_paten/provider/authProvider/authProvider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _milestoneIdController = TextEditingController();
  List<File> _selectedFiles = [];

  void _handleFileSelection() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.any,
    );

    if (result != null) {
      setState(() {
        _selectedFiles = result.paths.map((path) => File(path!)).toList();
      });
    } else {
      print('User canceled the picker');
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeProvider);
    final user = ref.watch(authProvider);

    final themeNotifier = ref.read(themeProvider.notifier);
    final authNotifier = ref.read(authProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text('title'.tr()),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              themeNotifier
                  .toggleTheme(themeMode == ThemeMode.dark ? false : true);
            },
          ),
          DropdownButton<Locale>(
            value: context.locale,
            icon: const Icon(Icons.language),
            onChanged: (Locale? newLocale) {
              if (newLocale != null) {
                context.setLocale(newLocale);
              }
            },
            items: const [
              DropdownMenuItem(
                value: Locale('en'),
                child: Text('English'),
              ),
              DropdownMenuItem(
                value: Locale('es'),
                child: Text('Español'),
              ),
              DropdownMenuItem(
                value: Locale('fr'),
                child: Text('Français'),
              ),
              DropdownMenuItem(
                value: Locale('de'),
                child: Text('Deutsch'),
              ),
              DropdownMenuItem(
                value: Locale('ta'),
                child: Text('தமிழ்'),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authNotifier.logout();
              context.go('/login');
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SwitchListTile(
                title: Text('Dark Mode'),
                value: themeMode == ThemeMode.dark,
                onChanged: (value) {
                  themeNotifier.toggleTheme(value);
                },
              ),
              Text('Welcome, ${user?.name}!'),
              Text('Username: ${user?.username}'),
              Text('Email: ${user?.email}'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                child: Text('elevated_button'.tr()),
              ),
              const SizedBox(height: 20),
              OutlinedButton(
                onPressed: () {},
                child: Text('outlined_button'.tr()),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {},
                child: Text('text_button'.tr()),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _commentController,
                  decoration: InputDecoration(labelText: 'Comments'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _milestoneIdController,
                  decoration: InputDecoration(labelText: 'Milestone ID'),
                ),
              ),
              ElevatedButton(
                onPressed: _handleFileSelection,
                child: Text('Select Files'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  print(_selectedFiles);
                },
                child: Text('Upload Files'),
              ),
              const SizedBox(height: 16),
              SingleFileUpload(onFilePicked: _handleSingleFilePicked),
              const SizedBox(height: 16),
              MultipleFileUpload(onFilesPicked: _handleMultipleFilesPicked),
              const SizedBox(height: 16),
              const UrlLauncherComponent(url: 'https://www.example.com'),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSingleFilePicked(FilePickerResult? result) {
    if (result != null) {
      print('Single file picked: ${result.files.single.name}');
    } else {
      print('User canceled the picker');
    }
  }

  void _handleMultipleFilesPicked(List<PlatformFile>? files) {
    if (files != null) {
      for (var file in files) {
        print('Multiple file picked: ${file.name}');
      }
    } else {
      print('User canceled the picker');
    }
  }
}
