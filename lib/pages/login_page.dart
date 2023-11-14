import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:step_counter/components/button.dart';
import 'package:step_counter/components/textfield.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  void signUserIn() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);

      if (e.code == 'user-not-found') {
        wrongEmailMessage();
      } else if (e.code == 'wrong-password') {
        wrongPasswordMessage();
      }
    }

  }

wrongEmailMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text(
              "Wrong Email",
              style: TextStyle(),
            ),
          );
        });
  }

wrongPasswordMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text(
              "Wrong Email",
              style: TextStyle(),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.lock_person_outlined,
                color: Colors.blue,
                size: 40.0,
                textDirection: TextDirection.ltr,
                semanticLabel: 'Icon', // Announced in accessibility modes (e.g TalkBack/VoiceOver). This label does not show in the UI.
              ),

              const SizedBox(
                height: 50,
              ),
              Text("Welcome back!",
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  )),
              const SizedBox(
                height: 50,
              ),
              CustomTextField(
                  controller: emailController,
                  obscure: false,
                  hintText: "Email:"),
              const SizedBox(
                height: 25,
              ),
              CustomTextField(
                  controller: passwordController,
                  obscure: true,
                  hintText: "password:"),
              const SizedBox(
                height: 25,
              ),
              CustomButton(onTap: signUserIn),
              const SizedBox(
                height: 50,
              ),
               const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
