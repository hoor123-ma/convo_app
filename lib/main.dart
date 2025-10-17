import 'package:chat_app/app_router.dart';
import 'package:chat_app/const/page_routes.dart';
import 'package:chat_app/presentation/screens/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'chat App',
      // onGenerateRoute: AppRouter.getPageRoute,
      // initialRoute: loginScreen,
      home: ProductScreen(),
    );
  }
}
