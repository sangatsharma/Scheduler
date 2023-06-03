import 'package:flutter/material.dart';
import 'package:scheduler/Screens/teacher_name_select.dart';

import 'package:scheduler/Widgets/login_users.dart';

String teacherInstitutionCode = '';

class TeacherLogin extends StatefulWidget {
  const TeacherLogin({Key? key}) : super(key: key);
  static const String screen = 'TeacherLogin';

  @override
  State<TeacherLogin> createState() => _TeacherLoginState();
}

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
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: Row(
              children: [
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(
                    Icons.west,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'Teacher',
                  style: TextStyle(
                      fontFamily: 'poppins', fontSize: 25, color: Colors.black),
                )
              ],
            ),
            leadingWidth: 160,
            elevation: 0,
          ),
          body: Center(
              child: SingleChildScrollView(
                child:Form(
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
                TextFormField(
                  style: const TextStyle(
                    fontFamily: 'poppins',
                    fontSize: 18,
                  ),
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(fontFamily: 'poppins'),
                    labelText: 'Institution Code',
                    prefixIcon: Icon(Icons.key),
                    constraints: BoxConstraints(maxHeight: 60, maxWidth: 300),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),

                  //****  VALIDATION LOGIC ****//
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
                GestureDetector(
                  onTap: () {
                    // The TeacherNameSelect screen only loads if the validation
                    // was success
                    if(loginUser(_formKey)){
                      // The TeacherLogin screen is popped before loading
                      // TeacherNameSelect screen
                      Navigator.of(context).pop();
                      Navigator.pushNamed(context, TeacherNameSelect.screen);
                    }
                  },
                  //hero is used for simple animation similar to morph in powerpoint
                  child: Hero(
                    tag: 'Button',
                    child: Container(
                      height: 45,
                      width: 70,
                      margin: const EdgeInsets.only(top: 30),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.elliptical(35, 35),
                        ),
                        border: Border.fromBorderSide(
                          BorderSide(width: 1),
                        ),
                      ),
                      child: const Icon(Icons.east, size: 30),
                    ),
                  ),
                ),
              ],
            ),
                ),
          ))),
    );
  }
}
