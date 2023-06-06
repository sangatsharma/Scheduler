import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TempWidget extends StatelessWidget{
  const TempWidget({super.key, required this.user});

  final User? user;
  @override
  Widget build(BuildContext context){
    var photoUrl = user?.photoURL ?? 'Error Image link';
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(photoUrl),
            const SizedBox(height: 30,),
            Text("Hello: ${user?.displayName}"),
            Text("Email: ${user?.email}"),
          ],
        ),
      ),
    );
  }
}