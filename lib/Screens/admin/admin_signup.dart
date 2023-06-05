import 'package:flutter/material.dart';
import 'package:scheduler/Screens/admin/admin_login.dart';
import 'package:scheduler/Widgets/login_users.dart';
import '../../Widgets/appbar_func.dart';

class AdminSignUp extends StatefulWidget {
  const AdminSignUp({Key? key}) : super(key: key);
  static const String screen = 'AdminSignUp';
  @override
  State<AdminSignUp> createState() => _AdminSignUpState();
}

class _AdminSignUpState extends State<AdminSignUp> {
  bool hidePassword = true;

  //****Variables****//
  String _adminSignUpInstitutionName = '';
  String _adminSignUpEmail = '';
  String _adminSignUpPassword = '';

  // A key helps uniquely identify a form and validate it.
  // It's like a state that remembers the forms state even when the
  // widget rebuilds itself
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: buildAppBar(context, 'Sign Up'),
          body: Center(
              child: SingleChildScrollView(
            child: Form(
              // We then associate the key to this Form
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    width: 250,
                    child: Text(
                      'Sign Up to become an Admin',
                      style: TextStyle(
                          fontFamily: 'poppins',
                          fontSize: 20,
                          fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 80,
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          _adminSignUpInstitutionName = value;
                        });
                      },
                      style: const TextStyle(
                        fontFamily: 'poppins',
                        fontSize: 18,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Institution name',
                        labelStyle: TextStyle(fontFamily: 'poppins'),
                        prefixIcon: Icon(Icons.school),
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
                          return 'Please enter your Institution name';
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
                          _adminSignUpEmail = value;
                        });
                      },
                      style: const TextStyle(
                        fontFamily: 'poppins',
                        fontSize: 18,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(fontFamily: 'poppins'),
                        prefixIcon: Icon(
                          Icons.email,
                        ),
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
                          _adminSignUpPassword = value;
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
                  const SizedBox(
                    height: 5,
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
                              Colors.blueAccent)),
                      onPressed: () {
                        // Validate input fields
                        loginUser(_formKey);
                        //Route to LoginPage/adminHomePage
                      },
                      child: const Text(
                        'Sign Up',
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

                  //****SignUp with Google***//
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        //todo Route to signUp  with google account
                      },
                      child: Container(
                        height: 55,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1.5, color: Colors.grey),
                          borderRadius: BorderRadius.circular(150),
                        ),
                        child: const Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Image(
                              height: 30,
                              image: AssetImage('Assets/images/Google.png')),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  //****Sign Up****//
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AdminLogin.screen);
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already a user?',
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Text(
                            'Log In',
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
                    height: 20,
                  ),
                ],
              ),
            ),
          ))),
    );
  }
}
