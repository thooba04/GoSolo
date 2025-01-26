import 'package:flutter/material.dart';
import 'package:namer_app/pages/signIn.dart'; // Ensure this import is correct
import 'package:namer_app/pages/signUp.dart'; // Ensure this import is correct
import 'package:namer_app/pages/home.dart'; // Ensure this import is correct

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GoSolo',
      home: const MySignUp(), // Initial screen
      routes: {
        '/home': (context) => MyHome(), // Define the /home route
        '/signUp': (context) => MySignUp(), // Define the /signUp route
        '/signin': (context) => MySignIn(), // Define the /signin route
      },
    );
  }
}
