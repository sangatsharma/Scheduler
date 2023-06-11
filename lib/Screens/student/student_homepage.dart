import 'package:flutter/material.dart';

class StudentHomepage extends StatefulWidget {
  const StudentHomepage({Key? key}) : super(key: key);
  static const String screen = 'studentHomepage';
  @override
  State<StudentHomepage> createState() => _StudentHomepageState();
}

class _StudentHomepageState extends State<StudentHomepage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('Hey hey'),
    );
  }
}
