import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:riverpod_paten/core/TextField.dart/login_field.dart';
import 'package:riverpod_paten/provider/authProvider/authProvider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _usernameFocusNode.addListener(() {
      if (!_usernameFocusNode.hasFocus) {
        _formKey.currentState?.validate();
      }
    });
    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) {
        _formKey.currentState?.validate();
      }
    });
  }

  @override
  void dispose() {
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authNotifier = ref.read(authProvider.notifier);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/image/logo.png',
                  height: 40.h,
                ),
                SizedBox(height: 3.h),
                LoginField(
                  controller: _usernameController,
                  hintText: 'Username',
                  formKey: _formKey,
                  focusNode: _usernameFocusNode,
                ),
                SizedBox(height: 3.h),
                LoginField(
                  controller: _passwordController,
                  hintText: 'Password',
                  obscureText: true,
                  formKey: _formKey,
                  focusNode: _passwordFocusNode,
                ),
                SizedBox(height: 3.h),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      final username = _usernameController.text;
                      final password = _passwordController.text;

                      await authNotifier.login(username, password);

                      // Check if login is successful
                      if (authNotifier.isLoggedIn) {
                        context.go('/home');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Invalid username or password'),
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please fill in all fields'),
                        ),
                      );
                    }
                  },
                  child: const Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
