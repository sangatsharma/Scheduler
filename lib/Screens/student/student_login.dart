import 'package:flutter/material.dart';
import 'package:scheduler/Widgets/login_users.dart';
import 'package:scheduler/Widgets/appbar_func.dart';

class StudentLogin extends StatefulWidget {
  const StudentLogin({Key? key}) : super(key: key);
  static const String screen = 'StudentLogin';
  @override
  State<StudentLogin> createState() => _StudentLoginState();
}

class _StudentLoginState extends State<StudentLogin> {
  // A key helps uniquely identify a form and validate it.
  final _formKey = GlobalKey<FormState>();
  String _studentUserName = '';
  String _studentInstitutionCode = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: buildAppBar(context, 'Student'),
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
                      onChanged: (value) {
                        _studentUserName = value;
                      },
                      style: const TextStyle(
                        fontFamily: 'poppins',
                        fontSize: 18,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        labelStyle: TextStyle(fontFamily: 'poppins'),
                        prefixIcon: Icon(Icons.person),
                        constraints:
                            BoxConstraints(maxHeight: 25, maxWidth: 300),
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
                          return 'Please enter your Username';
                        }
                        // If everything is good, return null
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 85,
                    child: TextFormField(
                      onChanged: (value) {
                        _studentInstitutionCode = value;
                      },
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Institution Code';
                        }
                        return null;
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      loginUser(_formKey);
                    },
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
                ],
              ),
            ),
          ))),
    );
  }
}
