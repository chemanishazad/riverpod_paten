import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:riverpod_paten/core/const/palette.dart';

class LoginField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final GlobalKey<FormState> formKey;
  final FocusNode focusNode;

  const LoginField({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.formKey,
    required this.focusNode,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: controller,
            focusNode: focusNode,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(27),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Palette.lightGreyColor,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Palette.themeColor,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Palette.themeColor,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: hintText,
            ),
            obscureText: obscureText,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your $hintText';
              }
              return null;
            },
            onChanged: (value) {
              if (formKey.currentState != null) {
                formKey.currentState!.validate();
              }
            },
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
