import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:step_counter/components/button.dart';
import 'package:step_counter/components/discrete_button.dart';
import 'package:step_counter/components/textfield.dart';
import 'package:step_counter/pages/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

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
      if (!context.mounted) return;

      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();

      if (e.code == 'invalid-login-credentials') {
        showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                title: Text(
                  "User not found",
                  style: TextStyle(),
                ),
              );
            });
      } else if (e.code == 'wrong-password') {
        showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                title: Text(
                  "Wrong password",
                  style: TextStyle(),
                ),
              );
            });
      } else if (e.code == 'invalid-email') {
        showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                title: Text(
                  "Invalid email",
                  style: TextStyle(),
                ),
              );
            });
      } else if (e.code == 'user-disabled') {
        showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                title: Text(
                  "User disabled",
                  style: TextStyle(),
                ),
              );
            });
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  "Error: ${e.code}!",
                  style: const TextStyle(),
                ),
              );
            });
      }
    }
  }

  void resetPassword() async{
    // await FirebaseAuth.instance.confirmPasswordReset(code: code, newPassword: newPassword)

    showDialog(
    context: context,
    builder: (context) {
      return const AlertDialog(
        title: Text(
          "Not implemented!",
          style: TextStyle(),
        ),
      );
    });
  }

  Future gotoSignup() async {
    return await Navigator.pushReplacementNamed(context, '/signup');
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
                semanticLabel:
                    'Icon', // Announced in accessibility modes (e.g TalkBack/VoiceOver). This label does not show in the UI.
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
              CustomButton(
                onTap: signUserIn,
                text: "Sign in",
              ),
              const SizedBox(
                height: 10,
              ),
              // forgot password?
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    DiscreteButton(onTap: resetPassword, text: "Forgot your password?")
                  ],
                ),
              ),
              const SizedBox(height: 50),

              const Divider(
                color: Colors.grey,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 2),
                  DiscreteButton(onTap: gotoSignup, text: "Not a member?")
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
