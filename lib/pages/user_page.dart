import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:step_counter/components/button.dart';

class UserPage extends StatelessWidget {
  UserPage({super.key});
  final user = FirebaseAuth.instance.currentUser;

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  void resetPassword() {
    if (user!.email != null){
      FirebaseAuth.instance.sendPasswordResetEmail(email: user!.email!);
    }
  }

  void sendEmailVerification() async {
     if (user != null){
      await user?.sendEmailVerification();
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data;

          if (user != null) {
            // User is signed in
            return Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(onPressed: signUserOut, icon: const Icon(Icons.logout))
                ],
                title: Text("Logged in as: ${user.displayName ?? user.email}"),
              ),
              body: SafeArea(
                child: Center(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                          children: [
                            Text(
                              "Username: ${user.displayName ?? user.email}"
                            ),
                            Text(
                              "Is Email verified: ${user.emailVerified}",
                            ),
                            Text(
                              "User number ${user.phoneNumber}",
                            )
                          ],
                        ),
                      ), 
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                            child: Column(
                              children: [
                                  const SizedBox(height: 50),

                                  Center(child: CustomButton(onTap: resetPassword, text: "Reset password")),

                                  const SizedBox(height: 10),

                                  Center(child: CustomButton(onTap: sendEmailVerification, text: "Re-send Email Verification")),

                                  const SizedBox(height: 25),
                                ]
                              ),
                          ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                title: Text('No User Logged In'),
              ),
              body: const Center(
                child: Text('Please log in to view this page'),
              ),
            );
          }
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Loading...'),
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

