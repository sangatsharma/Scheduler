import 'dart:async';

import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scheduler/Screens/admin/getAdmin_institution.dart';

import '../../Auth/auth_service.dart';

class EmailVerify extends StatelessWidget {
  const EmailVerify({super.key});

  @override
  Widget build(BuildContext context) {
    //Authenticate.sendEmailVerification();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //LOGO
              Image.asset(
                'Assets/images/verify.png',
                height: 260,
                width: 260,
              ),

              const SizedBox(
                height: 10,
              ),

              const Text(
                "One last step",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              RichText(
                text: TextSpan(
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      const TextSpan(
                          text:
                              "Please verify your email address by clicking the link emailed to "),
                      TextSpan(
                          text: " ${FirebaseAuth.instance.currentUser?.email}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          )),
                    ]),
                textAlign: TextAlign.center,
              ),

              const SizedBox(
                height: 20,
              ),

              ElevatedButton(
                onPressed: () {
                  if (_checkForVerification() == true) {
                    context.showSuccessBar(
                        content: const Text(
                          'Email verified',
                          style: TextStyle(color: Colors.green),
                        ),
                        position: FlashPosition.top);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => GetInstitutionDetails(
                            user: FirebaseAuth.instance.currentUser)));
                  } else {
                    context.showErrorBar(
                        content: const Text(
                          'Email not verified',
                          style: TextStyle(color: Colors.red),
                        ),
                        position: FlashPosition.top);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                ),
                child: const Text(
                  "Check for verification",
                  style: TextStyle(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const ResendEmailButton(),
            ],
          ),
        ),
      ),
    );
  }
}

/// * BUTTON TO RESEND EMAIL VERIFICATION CODE **
class ResendEmailButton extends StatefulWidget {
  const ResendEmailButton({super.key});

  @override
  State<ResendEmailButton> createState() => _ResendButtonEmailState();
}

class _ResendButtonEmailState extends State<ResendEmailButton> {
  late bool _resendEmailEnabled;

  // Resend email countdown timer
  late int _secondsRemain;
  late Timer countdownTimer;

  @override
  // Runs while the widget is being built (constructor)
  void initState() {
    super.initState();
    startUpLogic();
  }

  @override
  // If user goes back, stop the timer to prevent memory leak
  void dispose() {
    super.dispose();
    countdownTimer.cancel();
  }

  // Sets some variable and starts the countdown timer
  void startUpLogic() {
    _resendEmailEnabled = false;
    _secondsRemain = 10;

    startTimer();
  }

  // Timer that ticks every second
  void startTimer() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      // Timer runs setCountDown every second
      setCountDown();
    });
  }

  void setCountDown() {
    setState(() {
      // Reduce secondsRemain by one very second
      _secondsRemain = _secondsRemain - 1;
    });

    // If _secondRemain reaches zero, stop the timer
    if (_secondsRemain == 0) {
      _resendEmailEnabled = true;
      countdownTimer.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Resend email button will not be visible until _secondsRemain hits zero
        Visibility(
          visible: _resendEmailEnabled,
          child: ElevatedButton(
            onPressed: _resendEmailEnabled
                ? () {
                    context.showSuccessBar(
                        content: const Text(
                          "Verification email resent",
                          style: TextStyle(color: Colors.green),
                        ),
                        position: FlashPosition.top);

                    Authenticate.sendEmailVerification();

                    setState(() {
                      startUpLogic();
                    });
                  }
                : null,
            child: const Text(
              "Resend Verification",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),

        Visibility(
          // Resend after countdown
          visible: !_resendEmailEnabled,
          child: Text(
            "Resend again after $_secondsRemain seconds",
            style: const TextStyle(
              color: Colors.blueAccent,
            ),
          ),
        ),
      ],
    );
  }
}

//TODO does not work first time (maybe call reload twice, or set a 1 sec delay)
// TODO maybe sign out after user verifies
// Check if user has verified email or not
bool? _checkForVerification() {
  FirebaseAuth.instance.currentUser?.reload();
  return FirebaseAuth.instance.currentUser!.emailVerified;
}
