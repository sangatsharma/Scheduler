import 'package:flutter/material.dart';

class TeacherLogin extends StatefulWidget {
  const TeacherLogin({Key? key}) : super(key: key);
  static const String screen = 'TeacherLogin';
  @override
  State<TeacherLogin> createState() => _TeacherLoginState();
}

class _TeacherLoginState extends State<TeacherLogin> {
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

                  //Todo validation of institution code
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
