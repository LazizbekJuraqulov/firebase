import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lesson_6/screen/account_screen.dart';
import 'package:lesson_6/screen/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Assosiy sahifa"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                if (user == null) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return LoginScreen();
                  }));
                } else {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AccountScreen();
                  }));
                }
              },
              icon: Icon(
                Icons.person,
                color: (user == null) ? Colors.white : Colors.yellow,
              ))
        ],
      ),
      body: SafeArea(
          child: Center(
        child:
            user == null ? Text("Ruyxatdan O'tilmagan") : Text("Ruyxatdan O'tilgan"),
      )),
    );
  }
}
