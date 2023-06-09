import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:scheduler/Auth/auth_service.dart';
import 'package:scheduler/Screens/admin/admin_signup.dart';
import 'package:scheduler/Widgets/login_users.dart';
import '../../Widgets/appbar_func.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:scheduler/tmp/temp_file.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flash/flash.dart';

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

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  //Initially loading spinner is set to false
  bool showLoading = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //ModalProgressHud is used to display loading spinner
      home: ModalProgressHUD(
        //initially set to false
        inAsyncCall: showLoading,
        color: Colors.white38,
        dismissible: false,
        progressIndicator: const CircularProgressIndicator(
          strokeWidth: 4,
          backgroundColor: Colors.grey,
        ),
        blur: 0.8,
        child: Scaffold(
            appBar: buildAppBar(context, 'Admin'),
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
                            fontSize: 18,
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
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
                    const SizedBox(
                      height: 10,
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
                          constraints: const BoxConstraints(
                              maxHeight: 60, maxWidth: 300),
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

                        onPressed: () async{
                          // Validate input fields
                          bool validateSuccess = loginUser(_formKey);

                          // If successfully validated
                          if(validateSuccess) {

                            // Try to sign the user in
                            var user = await Authenticate.signInWithEmail(
                                email: _adminLogInEmail,
                                password: _adminLogInPassword,
                                context: context
                            );

                            // If sign-in was success, load corresponding page
                            // Also make sure the present context is mounted
                            if (user != null && context.mounted) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      TempWidget(user: user)));
                            }
                          }
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
                        onTap: () async {
                          setState(() {
                            //loading spinner starts to spin during Login
                            showLoading = true;
                          });
                          //Todo disallow user to tap multiple times
                          try {
                            //Login the user
                            var user = await Authenticate.signInWithGoogle(
                                context: context);
                            // Open the temp page
                            setState(() {
                              //loading spinner stops to spin after Login
                              showLoading = false;
                              if (user != null) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        TempWidget(user: user)));
                                //Show success message
                                context.showSuccessBar(
                                    content: const Text(
                                      'Logged in Successfully',
                                      style: TextStyle(color: Colors.green),
                                    ),
                                    position: FlashPosition.top);
                              } else {
                                //Show success message
                                context.showErrorBar(
                                    content: const Text(
                                      'Login failed !',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    position: FlashPosition.top);
                              }
                            });
                          } catch (e) {
                            print(e);
                          }
                        },
                        child: Container(
                          height: 55,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1.5, color: Colors.grey),
                            borderRadius: BorderRadius.circular(130),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Image(
                                height: 50,
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
                      height: 10,
                    ),
                  ],
                ),
              ),
            ))),
      ),
    );
  }
}
