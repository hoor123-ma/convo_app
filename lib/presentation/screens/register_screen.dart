import 'package:chat_app/const/app_colors.dart';
import 'package:chat_app/const/page_routes.dart';
import 'package:chat_app/presentation/screens/login_screen.dart';
import 'package:chat_app/presentation/widgets/custom_button_widget.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/presentation/widgets/form_validation_widget.dart';
import 'package:chat_app/presentation/widgets/logo_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});
  static const String id = '/registerScreen';
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isLoading = false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      progressIndicator: CircularProgressIndicator(color: AppColors.green1),
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: Color(0xffffffff),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: LogoWidget()),

                  FormValidationWidget(
                    title: "Register",
                    formKey: formKey,
                    emailController: emailController,
                    passswordController: passwordController,
                  ),
                  SizedBox(height: 15),
                  CustomButton(
                    title: "Register",
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        try {
                          await registerUser();
                          Navigator.pushReplacementNamed(
                            context,
                            chatScreen,
                            arguments: emailController.text,
                          );
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            showSnackBar(
                              context,
                              message: "weak password",
                              backgroundColor: Colors.red,
                            );
                          } else if (e.code == 'email-already-in-use') {
                            showSnackBar(
                              context,
                              message: "Email already exists",
                              backgroundColor: Colors.red,
                            );
                          }
                        } catch (e) {
                          showSnackBar(
                            context,
                            message: "Try again later",
                            backgroundColor: Colors.red,
                          );
                        }
                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
                  ),
                  SizedBox(height: 15),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Already have an account? ",
                          style: TextStyle(color: AppColors.blue),
                        ),
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            },
                          text: "Login",
                          style: TextStyle(color: AppColors.green1),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    final credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
