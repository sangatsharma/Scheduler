import 'package:flutter/material.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({Key? key}) : super(key: key);
  static const String screen = 'AdminLogin';
  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
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
                  'Admin',
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
                const SizedBox(height: 10),
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

                  //Todo validation of Username if it is empty

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
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.key_sharp),
                    constraints: BoxConstraints(maxHeight: 60, maxWidth: 300),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),

                  //Todo validation of password

                  // validator: (value) {
                  //   if (value == null) {
                  //     return 'Please enter your username';
                  //   }
                  //   return null;
                  // },
                ),
                const SizedBox(
                  height: 10,
                ),
                //login button
                SizedBox(
                  height: 50,
                  width: 300,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            side: BorderSide.none,
                            borderRadius: BorderRadius.circular(10))),
                        backgroundColor:
                            const MaterialStatePropertyAll(Colors.pinkAccent)),
                    onPressed: () {},
                    child: const Text(
                      'Log In',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 300,
                  child: Divider(
                    height: 25,
                    thickness: 1,
                    color: Colors.grey,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    //todo make pw reset page and route to it
                  },
                  child: const Text(
                    'Forgot password?',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                GestureDetector(
                  onTap: () {
                    //todo :make admin registration page and route to it
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
                      Text(
                        'Sign up',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ))),
    );
  }
}
