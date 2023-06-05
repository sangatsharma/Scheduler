import 'package:flutter/material.dart';
import 'package:scheduler/Screens/admin/admin_signup.dart';
import 'package:scheduler/Widgets/login_users.dart';
import '../../Widgets/appbar_func.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({Key? key}) : super(key: key);
  static const String screen = 'AdminLogin';
  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  bool hidePassword = true;

  //****Variables****//
  String _adminLogInEmail = '';
  String _adminLogInPassword = '';

  // A key helps uniquely identify a form and validate it.
  // It's like a state that remembers the forms state even when the
  // widget rebuilds itself
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: buildAppBar(context, 'Admin'),
          body: Center(
              child: SingleChildScrollView(
            child: Form(
              // We then associate the key to this Form
              key: _formKey,
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.transparent,
                    child: Image(
                      image: AssetImage(
                        'Assets/images/logo.jpg',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 300,
                    child: Text(
                      'Log in to Organize Schedule',
                      style: TextStyle(
                          fontFamily: 'poppins',
                          fontSize: 25,
                          fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 85,
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          _adminLogInEmail = value;
                        });
                      },
                      style: const TextStyle(
                        fontFamily: 'poppins',
                        fontSize: 18,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(fontFamily: 'poppins'),
                        prefixIcon: Icon(Icons.email),
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
                        // Make sure that input field is not Empty neither null
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Email';
                        }
                        // If everything is good, return null
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 80,
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          _adminLogInPassword = value;
                        });
                      },
                      style: const TextStyle(
                        fontFamily: 'poppins',
                        fontSize: 18,
                      ),
                      obscureText: hidePassword,
                      decoration: InputDecoration(
                        labelStyle: const TextStyle(fontFamily: 'poppins'),
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.key_sharp),
                        suffixIcon: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                hidePassword = !hidePassword;
                              });
                            },
                            onLongPressEnd: (value) {
                              setState(() {
                                hidePassword = !hidePassword;
                              });
                            },
                            child: hidePassword
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility),
                          ),
                        ),
                        constraints:
                            const BoxConstraints(maxHeight: 60, maxWidth: 300),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),

                      //****  VALIDATION LOGIC ****//
                      validator: (value) {
                        // Make sure that input field is not Empty neither null
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Password';
                        }
                        // If everything is good, return null
                        return null;
                      },
                    ),
                  ),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Container(
                      alignment: Alignment.topRight,
                      height: 25,
                      width: 280,
                      child: GestureDetector(
                        onTap: () {
                          //todo make pw reset page and route to it
                        },
                        child: const Text(
                          'Forgot password?',
                          style: TextStyle(fontSize: 14, color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                  //login button
                  SizedBox(
                    height: 50,
                    width: 300,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  side: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10))),
                          backgroundColor: const MaterialStatePropertyAll(
                              Colors.pinkAccent)),
                      onPressed: () {
                        // Validate input fields
                        loginUser(_formKey);
                      },
                      child: const Text(
                        'Log In',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 130,
                          child: Divider(
                            height: 25,
                            thickness: 1,
                            color: Colors.grey,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('OR'),
                        ),
                        SizedBox(
                          width: 130,
                          child: Divider(
                            height: 25,
                            thickness: 1,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  //****Login with Google***//
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        //todo Route to log in with google account
                      },
                      child: Container(
                        height: 55,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1.5, color: Colors.grey),
                          borderRadius: BorderRadius.circular(130),
                        ),
                        child: const Image(
                            fit: BoxFit.contain,
                            height: 50,
                            image: AssetImage('Assets/images/Google.png')),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  //****Sign Up****//
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AdminSignUp.screen);
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account?',
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Text(
                            'Sign up',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ))),
    );
  }
}
