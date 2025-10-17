import 'package:chat_app/const/page_routes.dart';
import 'package:chat_app/data/models/message_model.dart';
import 'package:chat_app/presentation/screens/edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/presentation/screens/login_screen.dart';
import 'package:chat_app/presentation/screens/register_screen.dart';
import 'package:chat_app/presentation/screens/chat_screen.dart';

class AppRouter {
  static Route<dynamic>? getPageRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginScreen:
        return MaterialPageRoute(builder: (_) => LoginScreen());

      case registerScreen:
        return MaterialPageRoute(builder: (_) => RegisterScreen());

      case chatScreen:
        String email = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => ChatScreen(email: email));

      case editScreen:
        MessageModel message = settings.arguments as MessageModel;
        return MaterialPageRoute(builder: (_) => EditScreen(message: message));

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}
