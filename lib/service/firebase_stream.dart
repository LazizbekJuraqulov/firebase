import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lesson_6/screen/email_screen.dart';
import 'package:lesson_6/screen/home_screen.dart';

class FirebaseStream extends StatelessWidget {
  const FirebaseStream({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Scaffold(
              body: Center(
                child: Text("Xatolik"),
              ),
            );
          } else if (snapshot.hasData) {
            if (!snapshot.data!.emailVerified) {
              return EmailScreen();
            }
            return HomeScreen();
          } else {
            return HomeScreen();
          }
        });
  }
}
