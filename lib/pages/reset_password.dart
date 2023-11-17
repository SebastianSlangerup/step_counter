import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:step_counter/components/button.dart';
import 'package:step_counter/components/discrete_button.dart';
import 'package:step_counter/components/textfield.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPassword> {
  final emailController = TextEditingController();


  void sendResetMail() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text
      );

      if (!context.mounted) return;

      Navigator.of(context).pop();

    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();

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

  Future gotoLogin() async {
    return await Navigator.pushReplacementNamed(context, '/login');
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
              Text("Reset password",
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
                  hintText: "Email"),
              const SizedBox(
                height: 25,
              ),

              CustomButton(
                onTap: sendResetMail,
                text: "Reset password",
              ),

              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 2),
                  DiscreteButton(onTap: gotoLogin, text: "Go back")
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
