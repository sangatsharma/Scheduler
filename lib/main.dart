import 'package:flutter/material.dart';
import 'package:scheduler/Screens/selector_actor.dart';
import 'package:scheduler/Screens/student_login.dart';
import 'package:scheduler/Screens/teacher_login.dart';
import 'package:scheduler/Screens/teacher_name_select.dart';

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
        TeacherLogin.screen: (context) => const TeacherLogin(),
        TeacherNameSelect.screen: (context) => const TeacherNameSelect(),
      },
    );
  }
}
//hello just a try
