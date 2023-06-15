import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scheduler/Screens/admin/admin_login.dart';
import 'package:scheduler/Screens/selector_actor.dart';
import 'package:scheduler/Screens/student/student_class_select.dart';
import 'package:scheduler/Screens/student/student_homepage.dart';
import 'package:scheduler/Screens/student/student_login.dart';
import 'package:scheduler/Screens/teacher/teacher_login.dart';
import 'package:scheduler/Screens/teacher/teacher_name_select.dart';
import 'package:scheduler/Screens/admin/admin_signup.dart';
import 'package:scheduler/firebase_options.dart';
import 'package:scheduler/tmp/temp_file.dart';
import 'package:scheduler/Widgets/shared_prefs.dart';

void main() async {
  // Initialize Firebase app
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //check if student was logged in
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

bool checkIsStudentLogin = false;

class _MyAppState extends State<MyApp> {
  void updateStatus() async {
    bool? checkIfLoggedIn = await checkStudentLogInStatus();
    setState(() {
      checkIsStudentLogin = checkIfLoggedIn ?? false;
    });
  }

  @override
  void initState() {
    updateStatus();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    // Check if the user is already logged in
    User? currentUser = FirebaseAuth.instance.currentUser;
    Widget defaultScreen;

    // If user is not logged in or has an unverified email, load SelectActor screen
    if (currentUser == null || !currentUser.emailVerified) {
      if (currentUser?.emailVerified == false) {
        FirebaseAuth.instance.signOut();
      }
      defaultScreen = const SelectActor();
    }
    // Else load TempWidget
    else {
      defaultScreen = TempWidget(user: currentUser);
    }
    if (checkIsStudentLogin) {
      defaultScreen = const StudentHomepage();
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: defaultScreen,
      routes: {
        SelectActor.screen: (context) => const SelectActor(),
        StudentLogin.screen: (context) => const StudentLogin(),
        StudentClassSelect.screen: (context) => const StudentClassSelect(),
        TeacherLogin.screen: (context) => const TeacherLogin(),
        TeacherNameSelect.screen: (context) => const TeacherNameSelect(),
        AdminLogin.screen: (context) => const AdminLogin(),
        AdminSignUp.screen: (context) => const AdminSignUp(),
        StudentHomepage.screen: (context) => const StudentHomepage(),
      },
    );
  }
}
