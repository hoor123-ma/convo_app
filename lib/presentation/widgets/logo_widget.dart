import 'package:chat_app/const/app_colors.dart';
import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 90,
          width: 300,
          child: Image.asset("assets/images/undraw_quick-chat_3gj8.png"),
        ),
        Text(
          "Convo",
          style: TextStyle(
            color: AppColors.green1,
            fontSize: 30,
            fontFamily: 'Pacifico',
          ),
        ),
        SizedBox(height: 30),
      ],
    );
  }
}
