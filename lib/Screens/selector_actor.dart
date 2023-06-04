import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:scheduler/Screens/admin_login.dart';
import 'package:scheduler/Screens/student_login.dart';
import 'package:scheduler/Screens/teacher_login.dart';
import 'package:scheduler/Widgets/next_button.dart';

class SelectActor extends StatefulWidget {
  const SelectActor({Key? key}) : super(key: key);

  static const String screen = 'SelectActor';

  @override
  State<SelectActor> createState() => _SelectActorState();
}

class _SelectActorState extends State<SelectActor> {
  //initial selected actor=student
  String selectedActor = 'Student';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 80),
              child: const CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.transparent,
                  child: Image(
                    image: AssetImage(
                      'Assets/images/logo.jpg',
                    ),
                    fit: BoxFit.cover,
                  )),
            ),
            const Text(
              'I am a',
              style: TextStyle(
                  fontFamily: 'cursive',
                  fontSize: 60,
                  fontWeight: FontWeight.w900),
            ),
            Container(
              alignment: Alignment.center,
              height: 150,
              width: 160,
              child: CupertinoPicker(
                scrollController: FixedExtentScrollController(initialItem: 1),
                itemExtent: 50,
                onSelectedItemChanged: (index) {
                  setState(() {
                    switch (index) {
                      case 0:
                        selectedActor = 'Teacher';
                        break; // The switch statement must be told to exit, or it will execute every case.
                      case 2:
                        selectedActor = 'Admin';
                        break;
                      default:
                        selectedActor = 'Student';
                    }
                  });
                  debugPrint(selectedActor);
                },
                children: const [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        'Teacher',
                        style: TextStyle(fontSize: 30, fontFamily: 'poppins'),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        'Student',
                        style: TextStyle(fontSize: 30, fontFamily: 'poppins'),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        'Admin',
                        style: TextStyle(fontSize: 30, fontFamily: 'poppins'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                switch (selectedActor) {
                  case 'Student':
                    Navigator.pushNamed(context, StudentLogin.screen);
                    break;
                  case 'Teacher':
                    Navigator.pushNamed(context, TeacherLogin.screen);
                    break;
                  case 'Admin':
                    Navigator.pushNamed(context, AdminLogin.screen);
                    break;
                  default:
                }
              },
              child: const NextButton(
                //nextbtn is a custom widget from next_button.dart
                btnIcon: Icon(
                  Icons.east,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
