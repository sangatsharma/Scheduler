import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:scheduler/Auth/auth_service.dart';
import 'package:scheduler/Screens/admin/email_verify.dart';
// import 'package:scheduler/Screens/admin/admin_login.dart';
import 'package:scheduler/Widgets/login_users.dart';
import '../../Widgets/appbar_func.dart';
import '../../tmp/temp_file.dart';

class AdminSignUp extends StatefulWidget {
  const AdminSignUp({Key? key}) : super(key: key);
  static const String screen = 'AdminSignUp';
  @override
  State<AdminSignUp> createState() => _AdminSignUpState();
}

class _AdminSignUpState extends State<AdminSignUp> {
  bool hidePassword = true;

  //****Variables****//
  String _adminSignUpEmail = '';
  String _adminSignUpPassword = '';

  // A key helps uniquely identify a form and validate it.
  // It's like a state that remembers the forms state even when the
  // widget rebuilds itself
  final _formKey = GlobalKey<FormState>();

  bool showLoading = false;

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
                  CircleAvatar(
                    radius: MediaQuery.of(context).size.height * 0.1,
                    backgroundColor: Colors.transparent,
                    child: const Image(
                      image: AssetImage(
                        'Assets/images/logo.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 250,
                    child: Text(
                      'Sign Up to become an Admin',
                      style: TextStyle(
                          fontFamily: 'poppins',
                          fontSize: 18,
                          fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,
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
                  const SizedBox(
                    height: 8,
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
                      onPressed: () async {
                        // Validate input fields
                        bool validateSuccess = loginUser(_formKey);

                        if (validateSuccess) {
                          //Try to register new user
                          var user = await Authenticate.registerWithEmail(
                              email: _adminSignUpEmail,
                              password: _adminSignUpPassword,
                              context: context);
                          // TOdo (maybe): try logging out the user if different build context
                          // If login successful and same context is mounted, redirect to login page
                          if (user != null && context.mounted) {
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (context) => TempWidget(user: user)));
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const EmailVerify()));
                          }
                        }
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
                      onTap: () async {
                        //todo Route to signUp  with google account
                        var user = await Authenticate.signInWithGoogle(
                            context: context);
                        if (user != null) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => TempWidget(user: user)));
                        }
                      },
                      child: Container(
                        height: 55,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1.5, color: Colors.grey),
                          borderRadius: BorderRadius.circular(150),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(5.0),
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
                      // Navigator.pushNamed(context, AdminLogin.screen);

                      // This prevents multiple screens to exist
                      Navigator.of(context).pop();
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
