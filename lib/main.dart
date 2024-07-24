//import 'dart:ffi';

import 'package:firstapp/constants/routes.dart';
//import 'package:firstapp/firebase_options.dart';
import 'package:firstapp/services/auth/auth_service.dart';
import 'package:firstapp/views/login_view.dart';
import 'package:firstapp/views/notes_view.dart';
import 'package:firstapp/views/register_view.dart';
import 'package:firstapp/views/verify_email_views.dart';
import 'package:flutter/material.dart';
//import 'dart:developer' as devtools show log;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
      routes: {
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        notesroute: (context) => const NotesView(),
        verifyEmailroute: (context) => const VerifyEmailView(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;
            if (user != null) {
              if (user.isEmailVerified) {
                return const NotesView();
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const LoginView();
            }

          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
