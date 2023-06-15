import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:scheduler/Auth/error_message_codes.dart';

// firebase_core: for initializing Firebase
// firebase_auth: for implementing Firebase authentication
// google_sign_in: to use Google Sign-In

// GLOBAL AUTH OBJECT
FirebaseAuth _auth = FirebaseAuth.instance;

class Authenticate{
  // This must be done as the first step.
  static Future<FirebaseApp> initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    // TODO: Add auto login logic
    return firebaseApp;
  }


  /* REGISTER NEW USER WITH EMAIL AND PASSWORD */
  static Future<User?> registerWithEmail({required String email, required String password, required BuildContext context}) async {
    try{
      // Try to create a new user
      final UserCredential user = await(
          _auth.createUserWithEmailAndPassword(
              email: email,
              password: password,
          )
      );

      // Send email verification link
      // await sendEmailVerification();

      // If success, return a User object
      return user.user;

    }
    on FirebaseAuthException catch(e) {
      // Get error message
      String errorMessage = AuthenticateErrorMessageCodes.getErrorMessage(e);

      // Show an ErrorBar with error message
      context.showErrorBar(
        content: Text(
          errorMessage,
            style: const TextStyle(color: Colors.red),
          ),
          position: FlashPosition.top
      );

      return null;
    }
  }


  /* SIGN IN USER WITH EMAIL AND PASSWORD */
  static Future<User?> signInWithEmail({required String email, required String password, required BuildContext context}) async{
    try{
      // Try to sign in user
      final UserCredential userCredential = await (
        _auth.signInWithEmailAndPassword(
            email: email,
            password: password
        )
      );

      // If success, return users info
      return userCredential.user;
    }

    on FirebaseAuthException catch (e){
      String errorMessage = AuthenticateErrorMessageCodes.getErrorMessage(e);

      // On error, show error-bar
      context.showErrorBar(
          content: Text(
            errorMessage,
            style: const TextStyle(color: Colors.red),
          ),
          position: FlashPosition.top
      );
    }

    return null;
}


  /* SIGN IN USER WITH GOOGLE*/
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
    GoogleSignInAccount? googleSignInAccount;

    // Make a call to google
    try {
      googleSignInAccount =
      await googleSignIn.signIn();
    }

    // If no internet connection, print an error message
    on PlatformException catch(e){
      context.showErrorBar(
          content: const Text(
            'No Internet Access',
            style: TextStyle(color: Colors.red),
          ),
          position: FlashPosition.top
      );
      return null;
    }

    catch(e){
      print(e);
    }

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
        var errorMessage = AuthenticateErrorMessageCodes.getErrorMessage(e);

        if(context.mounted){
          context.showErrorBar(
            content: Text(
              errorMessage,
              style: const TextStyle(color: Colors.red),
            ),
            position: FlashPosition.top
          );
        }
      }
    }

    // If user aborts the sign in process
    if(user == null && context.mounted){
      context.showErrorBar(
        content: const Text(
          'Something went wrong, please try again',
            style: TextStyle(color: Colors.red),
          ),
          position: FlashPosition.top
        );
    }

    return user;
  }

  // Send email verification code to user
  static Future<void> sendEmailVerification() async{
    return await _auth.currentUser?.sendEmailVerification();
  }


  /* RESET PASSWORD */
  static Future<bool> forgotPassword({required String email, required BuildContext context}) async {

    // Try to send resend email to supplied email
    try {
      await _auth.sendPasswordResetEmail(email: email);

      // If success, return true
      if(context.mounted){
        context.showSuccessBar(
          content: const Text(
            "Password reset link send",
            style: TextStyle(color: Colors.green),
          ),
          position: FlashPosition.top
        );
      }
      return true;

    }

    // ON FirebaseAuthException, get the message and display; return false
    on FirebaseAuthException catch(e){
      var errorMessage = AuthenticateErrorMessageCodes.getErrorMessage(e);

      if(context.mounted){
        context.showErrorBar(
            content: Text(
              errorMessage,
              style: const TextStyle(color: Colors.red),
            ),
            position: FlashPosition.top
        );
      }
    }
    catch(e){
      print(e);
    }

    return false;
  }


  /* SIGN OUT USERS*/
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
