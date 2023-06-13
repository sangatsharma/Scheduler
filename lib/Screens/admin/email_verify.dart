import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scheduler/Auth/auth_service.dart';
import 'package:scheduler/tmp/temp_file.dart';

class EmailVerify extends StatelessWidget{
  const EmailVerify({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Padding(
        padding:const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              //LOGO
              Image.network("https://png.pngtree.com/element_our/png/20181205/valid-vector-icon-png_260889.jpg", height: 260, width: 260,),

              const SizedBox(height: 10,),

              const Text(
                "One last step",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),

              const SizedBox(height: 10,),

              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    const TextSpan(text: "Please verify your email address by clicking the link emailed to "),
                    TextSpan(text: " ${FirebaseAuth.instance.currentUser?.email}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      )
                    ),
                  ]
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20,),

              ElevatedButton(
                onPressed: (){
                  if(_checkForVerification() == true){
                    context.showErrorBar(
                      content: const Text(
                        'Email verified',
                         style: TextStyle(color: Colors.green),
                       ),
                      position: FlashPosition.top
                    );
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => TempWidget(user: FirebaseAuth.instance.currentUser)));
                  }
                  else{
                    context.showErrorBar(
                      content: const Text(
                        'Email not verified',
                        style: TextStyle(color: Colors.red),
                      ),
                      position: FlashPosition.top
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                ),
                child: const Text(
                  "Check for verification",
                  style: TextStyle(
                  ),
                ),
              ),


              OutlinedButton(
                onPressed: (){
                  Authenticate.signOut(context: context);
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Use a different email",
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}

bool? _checkForVerification() {
  FirebaseAuth.instance.currentUser?.reload();
  return FirebaseAuth.instance.currentUser!.emailVerified;
}