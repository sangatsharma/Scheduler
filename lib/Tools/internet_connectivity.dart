import 'dart:io';

/* CHECK TO SEE IF THE USER HAS INTERNET ACCESS */
class InternetConnectivity {
  static Future<bool> isOnline() async {
    try {

      // Try accessing google.com
      final result = await InternetAddress.lookup('google.com');

      // If we get a result back, there is internet access
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;

    } on SocketException catch (_) {

      // If we get SocketException, there is no internet access
      return false;
    }
  }
}
