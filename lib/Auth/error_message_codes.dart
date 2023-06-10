import 'package:firebase_auth/firebase_auth.dart';

/* VARIOUS AUTH ERROR CODES AND CORRESPONDING ERROR MESSAGE TO DISPLAY */
class AuthenticateErrorMessageCodes{
  static String getErrorMessage(FirebaseAuthException e){
    final String errorMessage;

    switch (e.code) {
      case "ERROR_EMAIL_ALREADY_IN_USE":
      case "account-exists-with-different-credential":
      case "email-already-in-use":
        errorMessage = "User with this email already exists";
        break;
      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
        errorMessage = "Wrong email/password combination.";
        break;
      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
        errorMessage = "No user found with this email.";
        break;
      case "ERROR_USER_DISABLED":
      case "user-disabled":
        errorMessage = "User disabled.";
        break;
      case "ERROR_TOO_MANY_REQUESTS":
      case "operation-not-allowed":
        errorMessage = "Too many requests to log into this account.";
        break;
      case "ERROR_OPERATION_NOT_ALLOWED":
      case "operation-not-allowed":
        errorMessage = "Server error, please try again later.";
        break;
      case "ERROR_INVALID_EMAIL":
      case "invalid-email":
        errorMessage = "Email address is badly formatted.";
        break;
      case "weak-password":
        errorMessage = "Password must be atleast 6 characters";
      default:
        errorMessage = "Login failed. Please try again.";
        break;
    }

    return errorMessage;
  }
}