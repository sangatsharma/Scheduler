import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

// firebase_core: for initializing Firebase
// firebase_auth: for implementing Firebase authentication
// google_sign_in: to use Google Sign-In

// GLOBAL AUTH OBJECT
FirebaseAuth _auth = FirebaseAuth.instance;

//TODO check if the user is connected to the internet
class Authenticate{
  // This must be done as the first step.
  static Future<FirebaseApp> initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    // TODO: Add auto login logic

    return firebaseApp;
  }

  static Future<User?> registerWithEmail({required String email, required String password}) async {
    try{
      // Try to create a new user
      final UserCredential user = await(
          _auth.createUserWithEmailAndPassword(
              email: email,
              password: password,
          )
      );

      // If success, return a User object
      return user.user;

    } catch(e) {
      //On error, get the hashcode of the error message and display snack-bar
        var hash = e.hashCode;

       // Todo display a snackBar with error message
       if(hash == 264247444){
         print("User with this email already exists");
       }
       else{
         print("Sorry. Something went wrong");
       }

       return null;
    }
  }

  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    // FirebaseAuth is an entry point to Firebase Auth SDK. Create an instance of it
    // FirebaseAuth auth = FirebaseAuth.instance;

    // New variable of type User or null
    User? user;

    // Entry point to SignInWithGoogle
    final GoogleSignIn googleSignIn = GoogleSignIn(
      // This is required to signup with google from web
      clientId: "229538634287-2enp9iuqb1hd50l0pfggerlavu30brsp.apps.googleusercontent.com"
    );

    // Opens Pop up to choose account
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      // The request goes to google
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      // Get auth credentials
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        // Sign in with Firebase Auth SDK
        final UserCredential userCredential =
        await _auth.signInWithCredential(credential);

        // The `user` instance holds users info (e.g email)
        user = userCredential.user;
      }

      // Todo Error handeling
      on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
        } else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      } catch (e) {
        // handle the error here
      }
    }
    return user;
  }

  // Sign out process
  static Future<bool> signOut({required BuildContext context}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final User? currentUser = _auth.currentUser;

    // If user is logged-in, logout
    // Once a global state is created, this logic can be moved removed
    if(currentUser != null) {
      try {
        // For web
        if (!kIsWeb) {
          await googleSignIn.signOut();
        }

        // Else
        await _auth.signOut();

        return true;

      } catch (e) {
        // Todo
        print(e);
      }
    }
    else {
      print("User not logged-in");
    }

    return false;
  }
}
