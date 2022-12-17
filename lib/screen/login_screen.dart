import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lesson_6/service/snack_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPassword = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void tongglePassword() {
    setState(() {
      isPassword = !isPassword;
    });
  }

  Future<void> login() async {
    final navigator = Navigator.of(context);
    final isValid = formkey.currentState!.validate();
    if (!isValid) return;
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == "user not fond" || e.code == "word-password") {
        SnackBarService.showSnackBar(
            context, "Boshqatdan kiriting Xatolik!!!", true);
      }
      return;
    }
    navigator.pushNamedAndRemoveUntil("/home", (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Kirish"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
            key: formkey,
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  controller: emailController,
                  validator: (email) =>
                      email != null && !EmailValidator.validate(email)
                          ? " to'g'ri email kiriting"
                          : null,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "email kiriting"),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  autocorrect: false,
                  controller: passwordController,
                  obscureText: isPassword,
                  validator: (value) => value != null && value.length < 6
                      ? "eng kamida 6 da belgi kiriting"
                      : null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "parol kiriting",
                    suffix: InkWell(
                      onTap: tongglePassword,
                      child: Icon(
                        isPassword ? Icons.visibility_off : Icons.visibility,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(onPressed: login, child: const Text("Kirish")),
                const SizedBox(
                  height: 30,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/signup");
                    },
                    child: Text(
                      "Ruyhatdan o'tish",
                      style: TextStyle(decoration: TextDecoration.underline),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed("/password");
                    },
                    child: const Text("Paroldi o'chirish")),
              ],
            )),
      ),
    );
  }
}
