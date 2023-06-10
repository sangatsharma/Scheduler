import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scheduler/Screens/admin/admin_login.dart';
import 'package:scheduler/Screens/selector_actor.dart';
import 'package:scheduler/Screens/student/student_login.dart';
import 'package:scheduler/Screens/teacher/teacher_login.dart';
import 'package:scheduler/Screens/teacher/teacher_name_select.dart';
import 'package:scheduler/Screens/admin/admin_signup.dart';
import 'package:scheduler/firebase_options.dart';
import 'package:scheduler/tmp/temp_file.dart';

void main() async{

  // Initialize Firebase app
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Check if the user is already logged in
    User? currentUser = FirebaseAuth.instance.currentUser;
    Widget defaultScreen;

    // If user is not logged in, load SelectActor screen
    if(currentUser == null) {
      defaultScreen = const SelectActor();
    }

    // Else load TempWidget
    else {
      defaultScreen = TempWidget(user: currentUser);
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: defaultScreen,
      routes: {
        SelectActor.screen: (context) => const SelectActor(),
        StudentLogin.screen: (context) => const StudentLogin(),
        TeacherLogin.screen: (context) => const TeacherLogin(),
        TeacherNameSelect.screen: (context) => const TeacherNameSelect(),
        AdminLogin.screen: (context) => const AdminLogin(),
        AdminSignUp.screen: (context) => const AdminSignUp(),
      },
    );
  }
}
