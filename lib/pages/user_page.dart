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
    if (user!.email != null) {
      FirebaseAuth.instance.sendPasswordResetEmail(email: user!.email!);
    }
  }

  void sendEmailVerification() async {
    if (user != null) {
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
                  IconButton(
                      onPressed: signUserOut, icon: const Icon(Icons.logout))
                ],
                title: Text(
                  "Logged in as: ${user.displayName ?? user.email}",
                  style: TextStyle(
                    fontWeight: FontWeight.w200,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white70
                        : Colors.black26,
                  ),
                ),
              ),
              body: SafeArea(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white10
                                    : Colors.black26,
                          ),
                        ),
                        padding: const EdgeInsets.all(25),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 25),
                        child: Column(
                          children: [
                            ListTile(
                              title: const Text('Username:'),
                              trailing: Text(
                                "${user.displayName ?? user.email}",
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            ListTile(
                              title: const Text('Is Email verified:'),
                              trailing: Text(
                                user.emailVerified
                                    ? 'Verified'
                                    : 'Not verified',
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            ListTile(
                              title: const Text('Phone number:'),
                              trailing: Text(
                                user.phoneNumber ?? 'Non given',
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(children: [
                        const SizedBox(height: 50),
                        Center(
                            child: CustomButton(
                                onTap: resetPassword, text: "Reset password")),
                        const SizedBox(height: 10),
                        Center(
                            child: CustomButton(
                                onTap: sendEmailVerification,
                                text: "Re-send Email Verification")),
                        const SizedBox(height: 25),
                      ]),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                title: const Text('No User Logged In'),
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
