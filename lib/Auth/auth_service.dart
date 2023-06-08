import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

// firebase_core: for initializing Firebase
// firebase_auth: for implementing Firebase authentication
// google_sign_in: to use Google Sign-In

class Authenticate{

  // This must be done as the first step.
  static Future<FirebaseApp> initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    // TODO: Add auto login logic

    return firebaseApp;
  }

  static Future<UserCredential> registerWithEmail({required String email, required String password}) async {
    await Firebase.initializeApp();

    FirebaseAuth auth = FirebaseAuth.instance;

    final UserCredential user = await(
      auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      )
    );

    return user;
  }

  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    // Call the initializer
    await Firebase.initializeApp();

    // FirebaseAuth is an entry point to Firebase Auth SDK. Create an instance of it
    FirebaseAuth auth = FirebaseAuth.instance;

    // New variable of type User or null
    User? user;

    // Entry point to SignInWithGoogle
    final GoogleSignIn googleSignIn = GoogleSignIn();

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
        await auth.signInWithCredential(credential);

        // The `user` instance holds users info (e.g email)
        user = userCredential.user;
      }

      // Todo Error handeling
      on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
        }
        else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      } catch (e) {
        // handle the error here
      }
    }
    return user;
  }

  // Sign out process
  static Future<void> signOut({required BuildContext context}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      // For web
      if (!kIsWeb) {
        await googleSignIn.signOut();
      }

      // Else
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      // Todo
    }
  }
}