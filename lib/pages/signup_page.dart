import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:step_counter/components/button.dart';
import 'package:step_counter/components/discrete_button.dart';
import 'package:step_counter/components/textfield.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final name = TextEditingController();


  void signin() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      UserCredential result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text
      );

      await result.user?.updateDisplayName(name.text);


      if (! context.mounted) return;

      Navigator.of(context).pop();
      
      gotoLogin();

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
  Future gotoLogin() async{
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
                Icons.person,
                color: Colors.blue,
                size: 40.0,
                textDirection: TextDirection.ltr,
                semanticLabel: 'Icon', // Announced in accessibility modes (e.g TalkBack/VoiceOver). This label does not show in the UI.
              ),

              const SizedBox(
                height: 50,
              ),
              Text("Welcome to stepcounter!",
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  )),
              const SizedBox(
                height: 50,
              ),
              CustomTextField(
                  controller: name,
                  obscure: false,
                  hintText: "Fullname:"),

              const SizedBox(
                height: 25,
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
              CustomButton(onTap: signin, text: "Sign Up",),
              const SizedBox(
                height: 50,
              ),

              const Divider(
                color: Colors.grey,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 2),
                  DiscreteButton(onTap: gotoLogin, text: "Not a member?")
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}