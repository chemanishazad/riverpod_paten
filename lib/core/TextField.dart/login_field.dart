import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:riverpod_paten/core/const/palette.dart';

class LoginField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final GlobalKey<FormState> formKey;
  final FocusNode focusNode;
  final Icon? icon;
  final Icon? sufIcon;

  const LoginField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.formKey,
    required this.focusNode,
    this.obscureText = false,
    this.icon,
    this.sufIcon,
  });

  @override
  _LoginFieldState createState() => _LoginFieldState();
}

class _LoginFieldState extends State<LoginField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: widget.controller,
            focusNode: widget.focusNode,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
              hintText: widget.hintText,
              prefixIcon: widget.icon,
              suffixIcon: widget.obscureText
                  ? IconButton(
                      icon: Icon(_obscureText
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                  : widget.sufIcon,
              hintStyle: const TextStyle(fontSize: 15),
            ),
            obscureText: _obscureText,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your ${widget.hintText}';
              }
              return null;
            },
            onChanged: (value) {
              if (widget.formKey.currentState != null) {
                widget.formKey.currentState!.validate();
              }
            },
          ),
        ],
      ),
    );
  }
}
