import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lesson_6/screen/account_screen.dart';
import 'package:lesson_6/screen/email_screen.dart';
import 'package:lesson_6/screen/home_screen.dart';
import 'package:lesson_6/screen/login_screen.dart';
import 'package:lesson_6/screen/password_screen.dart';
import 'package:lesson_6/screen/signup_screen.dart';
import 'package:lesson_6/service/firebase_stream.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(pageTransitionsTheme: const PageTransitionsTheme(builders:{
        TargetPlatform.android:CupertinoPageTransitionsBuilder(),
      } )),
      debugShowCheckedModeBanner: false,
      routes:  {
        '/':(context)=>const FirebaseStream(),
        '/home':(context) =>const HomeScreen(),
        '/account':(context) =>const AccountScreen(),
        '/login':(context) => const LoginScreen(),
        '/signup':(context) => const SignUpScreen(),
        '/password':(context) => const PasswordScreen(),
        '/email':(context) => const EmailScreen(),

      },
      initialRoute: "/",
    );
  }
}
