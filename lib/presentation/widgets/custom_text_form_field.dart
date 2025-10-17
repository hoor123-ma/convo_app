import 'package:chat_app/const/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField({
    super.key,
    this.Controller,
    this.labelText,
    this.obscureText,
    this.validator,
    this.focusNode,
    this.onSubmitted,
  });

  final TextEditingController? Controller;
  final String? labelText;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  void Function(String)? onSubmitted;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: widget.onSubmitted,
      focusNode: widget.focusNode,
      validator: widget.validator,
      controller: widget.Controller,
      obscureText: widget.obscureText != null ? _obscureText : false,

      decoration: InputDecoration(
        labelStyle: TextStyle(color: AppColors.blue),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.green1, width: 2),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.green1),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.green1),
        ),
        labelText: widget.labelText,
        suffixIcon: widget.obscureText != null
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.green1,
                  size: 18,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
      ),
    );
  }
}
