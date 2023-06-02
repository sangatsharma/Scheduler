import 'package:flutter/material.dart';

class StudentLogin extends StatefulWidget {
  const StudentLogin({Key? key}) : super(key: key);
  static const String screen = 'StudentLogin';
  @override
  State<StudentLogin> createState() => _StudentLoginState();
}

class _StudentLoginState extends State<StudentLogin> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
              // validator: (value) {
              //   if (value == null) {
              //     return 'Please enter your username';
              //   }
              //   return null;
              // },
            ),
            const SizedBox(height: 20),
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
              // validator: (value) {
              //   if (value == null) {
              //     return 'Please enter your username';
              //   }
              //   return null;
              // },
            ),
            GestureDetector(
              onTap: () {},
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


//hajshaj
