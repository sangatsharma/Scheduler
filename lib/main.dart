import 'package:flutter/material.dart';
import 'package:scheduler/Screens/selector_actor.dart';
import 'package:scheduler/Screens/student_login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SelectActor(),
      routes: {
        SelectActor.screen: (context) => const SelectActor(),
        StudentLogin.screen: (context) => const StudentLogin(),
      },
    );
  }
}
//hello just a try
