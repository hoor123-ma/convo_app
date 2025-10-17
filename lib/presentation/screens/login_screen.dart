import 'package:chat_app/const/app_colors.dart';
import 'package:chat_app/const/page_routes.dart';
import 'package:chat_app/presentation/screens/register_screen.dart';
import 'package:chat_app/presentation/widgets/custom_button_widget.dart';
import 'package:chat_app/presentation/widgets/form_validation_widget.dart';
import 'package:chat_app/presentation/widgets/logo_widget.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});
  static const String id = '/loginScreen';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Builder(
        builder: (context) => Scaffold(
          backgroundColor: Color(0xffffffff),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(child: LogoWidget()),
                    FormValidationWidget(
                      title: "Login",
                      formKey: formKey,
                      emailController: emailController,
                      passswordController: passwordController,
                    ),
                    SizedBox(height: 15),
                    CustomButton(
                      title: "Login",
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });

                          try {
                            await loginUser();
                            Navigator.pushReplacementNamed(
                              context,
                              chatScreen,
                              arguments: emailController.text,
                            );
                          } on FirebaseAuthException catch (e) {
                            String errorMessage = '';

                            if (e.code == 'user-not-found' ||
                                e.code == 'invalid-email') {
                              errorMessage = 'No user found for that email.';
                            } else if (e.code == 'wrong-password' ||
                                e.code == 'invalid-credential') {
                              errorMessage =
                                  'Wrong password or Email provided for that user.';
                            } else {
                              errorMessage = 'Something went wrong. Try again.';
                            }

                            showSnackBar(
                              context,
                              message: errorMessage,
                              backgroundColor: Colors.red,
                            );
                          } catch (e) {
                            Future.delayed(Duration.zero, () {
                              showSnackBar(
                                context,
                                message: 'Try again later.',
                                backgroundColor: Colors.red,
                              );
                            });
                          } finally {
                            // stop loading AFTER snackBar shown
                            setState(() {
                              isLoading = false;
                            });
                          }
                        }
                      },
                    ),
                    SizedBox(height: 15),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Don't have an account? ",
                            style: TextStyle(color: AppColors.blue),
                          ),
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegisterScreen(),
                                  ),
                                );
                              },
                            text: "Register now",
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
      ),
    );
  }

  Future<void> loginUser() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
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
