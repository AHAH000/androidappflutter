//import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/constants/routes.dart';
import 'package:firstapp/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify email'),
      ),
      body: Column(
        children: [
          const Text(
              "We've sent you an email verification. Please open it to verify."),
          const Text("If you haven't received it yet, press here:"),
          TextButton(
              onPressed: () async {
                await AuthService.firebase().sendEmailVerification();
              },
              child: const Text('Send Email Verification')),
          TextButton(
            onPressed: () async {
              await AuthService.firebase().logOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                registerRoute,
                (route) => false,
              ); // assuming you want to navigate back
            },
            child: const Text('Restart'),
          ),
        ],
      ),
    );
  }
}
