import 'package:chat_app/const/app_colors.dart';
import 'package:chat_app/presentation/widgets/custom_button_widget.dart';
import 'package:chat_app/presentation/widgets/custom_text_form_field.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class FormValidationWidget extends StatefulWidget {
  final String title;
  final GlobalKey<FormState> formKey;
  TextEditingController emailController;
  TextEditingController passswordController;

  FormValidationWidget({
    super.key,
    required this.title,
    required this.formKey,
    required this.emailController,
    required this.passswordController,
  });

  @override
  State<FormValidationWidget> createState() => _FormValidationWidgetState();
}

class _FormValidationWidgetState extends State<FormValidationWidget> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TextStyle(color: AppColors.green1, fontSize: 20),
          ),
          const SizedBox(height: 12),
          CustomTextField(
            Controller: widget.emailController,
            labelText: "Email",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Email cannot be empty';
              }
              // Simple email regex
              final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
              if (!emailRegex.hasMatch(value)) {
                return 'Enter a valid email';
              }
              return null; // valid
            },
          ),
          const SizedBox(height: 12),
          CustomTextField(
            Controller: widget.passswordController,
            labelText: "Password",
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Field is required";
              } else if (value.length < 6) {
                return "password must be at least 6 characters";
              } else {
                return null;
              }
            },
          ),
        ],
      ),
    );
  }
}
