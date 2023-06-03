import 'package:flutter/material.dart';

class StudentLogin extends StatefulWidget {
  const StudentLogin({Key? key}) : super(key: key);
  static const String screen = 'StudentLogin';
  @override
  State<StudentLogin> createState() => _StudentLoginState();
}

class _StudentLoginState extends State<StudentLogin> {
  //initial error text is hidden from user until error occurs
  Color errorTextColor = Colors.transparent;
  String studentUserName = '';
  String studentInstitutionCode = '';
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
                  'Student',
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
                  onChanged: (value) {
                    setState(() {
                      studentUserName = value;
                    });
                  },
                  style: const TextStyle(
                    fontFamily: 'poppins',
                    fontSize: 18,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    labelStyle: TextStyle(fontFamily: 'poppins'),
                    prefixIcon: Icon(Icons.person),
                    constraints: BoxConstraints(maxHeight: 60, maxWidth: 300),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      studentInstitutionCode = value;
                      errorTextColor = Colors.transparent;
                    });
                  },
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
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '* Invalid code !',
                  style: TextStyle(
                    color: errorTextColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (studentInstitutionCode == '') {
                      setState(() {
                        errorTextColor = Colors.red;
                      });
                    } else if (studentUserName == '' ||
                        !RegExp('[a-zA-Z]').hasMatch(studentUserName)) {
                      setState(() {});
                    }
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
          ))),
    );
  }
}
