import 'package:flutter/material.dart';
import 'package:scheduler/Screens/teacher/teacher_name_select.dart';
import 'package:scheduler/Widgets/next_button.dart';
import 'package:scheduler/Widgets/login_users.dart';

import '../../Widgets/appbar_func.dart';

class TeacherLogin extends StatefulWidget {
  const TeacherLogin({Key? key}) : super(key: key);
  static const String screen = 'TeacherLogin';

  @override
  State<TeacherLogin> createState() => _TeacherLoginState();
}

//Global variable to hold code
//variable is made global so teacher_name_select.dart can access it.
String teacherInstitutionCode = '';

class _TeacherLoginState extends State<TeacherLogin> {
  // A key helps uniquely identify a form and validate it.
  // It's like a state that remembers the forms state even when the
  // widget rebuilds itself
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: buildAppBar(context, 'Teacher'),
          body: Center(
              child: SingleChildScrollView(
            child: Form(
              // We then associate the key to this Form
              key: _formKey,
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.transparent,
                    child: Image(
                      image: AssetImage(
                        'Assets/images/logo.jpg',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Text(
                    'Ready to join ?',
                    style: TextStyle(
                        fontFamily: 'poppins',
                        fontSize: 35,
                        fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    height: 85,
                    child: TextFormField(
                      style: const TextStyle(
                        fontFamily: 'poppins',
                        fontSize: 18,
                      ),
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(fontFamily: 'poppins'),
                        labelText: 'Institution Code',
                        prefixIcon: Icon(Icons.key),
                        constraints:
                            BoxConstraints(maxHeight: 60, maxWidth: 300),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),

                      //****  VALIDATION LOGIC ****//
                      //Todo validation of institution code from database
                      validator: (value) {
                        // Make sure that input field is not Empty neither null
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Institution Code';
                        }
                        // If everything is good, return null
                        teacherInstitutionCode = value;
                        return null;
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // The TeacherNameSelect screen only loads if the validation
                      // was success
                      if (loginUser(_formKey)) {
                        // The TeacherLogin screen is popped before loading
                        // TeacherNameSelect screen
                        Navigator.of(context).pop();
                        Navigator.pushNamed(context, TeacherNameSelect.screen);
                      }
                    },
                    //hero is used for simple animation similar to morph in powerpoint
                    child: const Hero(
                      tag: 'Button',
                      child: NextButton(
                          //next btn is a custom widget from next_button.dart
                          btnIcon: Icon(
                        Icons.east,
                        size: 30,
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ))),
    );
  }
}
