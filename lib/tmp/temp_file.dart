import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:scheduler/Auth/auth_service.dart';
import 'package:scheduler/Screens/selector_actor.dart';

class TempWidget extends StatelessWidget{
  const TempWidget({super.key, required this.user});

  final User? user;
  @override
  Widget build(BuildContext context){
    var photoUrl = user?.photoURL ?? 'https://upload.wikimedia.org/wikipedia/commons/f/f7/Facebook_default_male_avatar.gif';
    var name = user?.displayName ?? 'Anonymous';
    var email = user?.email;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(photoUrl),
            const SizedBox(height: 30,),
            Text("Hello: $name"),
            Text("Email: $email"),
            TextButton(
              onPressed: () async{
                bool success = await Authenticate.signOut(context: context);
                if(success && context.mounted){
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(SelectActor.screen);
                }
              },
                child: const Text("Sign Out"),
            )
          ],
        ),
      ),
    );
  }
}