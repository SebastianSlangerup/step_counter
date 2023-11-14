import 'package:flutter/material.dart';
import 'package:step_counter/components/button.dart';
import 'package:step_counter/components/textfield.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [


              const SizedBox(height: 50,),
  
  
              Text(
                "Welcome!",
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                )
              ),
              const SizedBox(height: 50,),

              CustomTextField(
                controller: usernameController,
                obscure: false,
                hintText: "Username:"
              ),

              const SizedBox(height: 25,),
  
              CustomTextField(
                controller: passwordController,
                obscure: true,
                hintText: "password:"
              ),

              const SizedBox(height: 25,),

              CustomButton(onTap: signUserIn),

              const SizedBox(height: 50,),

              
  
            ],
          ),
        ),
      ),
    );
  }
}