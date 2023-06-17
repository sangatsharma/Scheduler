import 'dart:io';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; //formats date
import 'package:scheduler/Screens/selector_actor.dart';
import 'package:scheduler/Widgets/shared_prefs.dart';
import 'package:scheduler/Screens/student/student_class_select.dart';
import 'databaseFetch_Student.dart';
import 'package:scheduler/Widgets/themes.dart';

class StudentHomepage extends StatefulWidget {
  const StudentHomepage({Key? key}) : super(key: key);
  static const String screen = 'studentHomepage';
  @override
  State<StudentHomepage> createState() => _StudentHomepageState();
}

//default set to light mode
//from themes.dart
bool isLightMode = true;

class _StudentHomepageState extends State<StudentHomepage>
    with SingleTickerProviderStateMixin {
  //function to show when back button is pressed
  Future<bool> showExitPopup() async {
    return await showDialog(
          barrierColor: Colors.transparent.withOpacity(0.6),
          //show confirm dialogue
          //the return value will be from "Yes" or "No" options
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor:
                isLightMode ? const Color(0xffC0FFFF) : Colors.blueAccent,
            title: Text(
              'Exit Scheduler ?',
              style: TextStyle(
                  color: isLightMode ? Colors.black : Colors.white,
                  fontSize: 20,
                  fontFamily: 'poppins'),
            ),
            content: Text(
              'Are you sure you want to exit?',
              style: TextStyle(
                  color: isLightMode ? Colors.black : Colors.white,
                  fontSize: 15,
                  fontFamily: 'poppins'),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(
                            isLightMode
                                ? const Color(0xffB1B2FF)
                                : Colors.pinkAccent),
                        foregroundColor: MaterialStatePropertyAll<Color>(
                            isLightMode ? Colors.black : Colors.white)),
                    onPressed: () => exit(0),
                    //return true when click on "Yes"
                    child: const Text('Yes'),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(
                            isLightMode
                                ? const Color(0xffB1B2FF)
                                : Colors.pinkAccent),
                        foregroundColor: MaterialStatePropertyAll<Color>(
                            isLightMode ? Colors.black : Colors.white)),
                    onPressed: () => Navigator.of(context).pop(false),
                    //return false when click on "NO"
                    child: const Text('No'),
                  ),
                ],
              ),
            ],
          ),
        ) ??
        false; //if showDialog had returned null, then return false
  }

  late AnimationController _controller;
  String _selectedDateIndex = DateTime.now().weekday.toString();
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    //list of routines
    _controller = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );

    //Start the animation after a short delay (e.g., 500 milliseconds)
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  void _resetAnimation() {
    _controller.reset();
    _controller.forward();
  }

  List<Widget> routines = [];
  void _addItems(BuildContext context) {
    routines = showRoutine(_selectedDateIndex, context);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _addItems(context);
    return WillPopScope(
      onWillPop: showExitPopup,
      child: MaterialApp(
        theme: isLightMode ? lightTheme : darkTheme,
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: Scaffold(
            appBar: AppBar(
                elevation: 0,
                backgroundColor:
                    isLightMode ? const Color(0xffB1B2FF) : Colors.transparent,
                leadingWidth: double.infinity,
                leading: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isLightMode = !isLightMode;
                            setThemeMode(isLightMode);
                            _resetAnimation();
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color: isLightMode
                                      ? Colors.black
                                      : Colors.white),
                              borderRadius: BorderRadius.circular(20)),
                          margin: const EdgeInsets.only(left: 15),
                          child: isLightMode
                              ? const Icon(
                                  Icons.nightlight,
                                  size: 20,
                                  color: Colors.black,
                                )
                              : const Icon(
                                  Icons.sunny,
                                  size: 20,
                                  color: Colors.white,
                                ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 20),
                        child: Center(
                          child: IconButton(
                            splashRadius: 15,
                            mouseCursor: MaterialStateMouseCursor.clickable,
                            splashColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            alignment: Alignment.center,
                            onPressed: () {
                              setStudentLoginStatus(false);
                              Navigator.pushNamed(context, SelectActor.screen);
                            },
                            icon: const Icon(
                              Icons.account_circle,
                              size: 40,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      )
                    ])),
            body: Container(
              color: isLightMode ? const Color(0xffC0FFFF) : Colors.transparent,
              child: Column(children: [
                Container(
                  decoration: BoxDecoration(
                      color: isLightMode
                          ? const Color(0xffB1B2FF)
                          : Colors.transparent,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15))),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                                DateFormat.yMMMMd().format(DateTime.now()),
                                style: TextStyle(
                                    fontFamily: 'poppins',
                                    fontSize: 15,
                                    color: isLightMode
                                        ? Colors.black
                                        : Colors.white)),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  'Today',
                                  style: TextStyle(
                                      fontFamily: 'poppins',
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500,
                                      color: isLightMode
                                          ? Colors.black
                                          : Colors.white),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(right: 20),
                                child: Text(selectedClass,
                                    style: TextStyle(
                                        fontFamily: 'poppins',
                                        fontSize: 15,
                                        color: isLightMode
                                            ? Colors.black
                                            : Colors.white)),
                              ),
                            ],
                          )
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            bottom: 10, left: 5, right: 5, top: 5),
                        decoration: BoxDecoration(
                            color: isLightMode
                                ? const Color(0xffC0FFFF)
                                : Colors.black,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8))),
                        child: buildDatePicker(context, selectedDate),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  // child: showRoutine(_selectedDateIndex),
                  child: SingleChildScrollView(
                    child: Column(
                      children: List.generate(
                        routines.length,
                        (index) {
                          final delay =
                              const Duration(milliseconds: 40) * (index + 1);
                          return FutureBuilder(
                            future: Future.delayed(delay),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return AnimatedBuilder(
                                  animation: _controller,
                                  builder: (context, child) {
                                    return FadeTransition(
                                      opacity: Tween<double>(
                                        begin: 0.0,
                                        end: 1.0,
                                      ).animate(CurvedAnimation(
                                        parent: _controller,
                                        curve: Curves.easeIn,
                                      )),
                                      child: SlideTransition(
                                        position: Tween<Offset>(
                                                begin: const Offset(0.0, 1.0),
                                                end: const Offset(0.0, 0.0))
                                            .animate(CurvedAnimation(
                                          parent: _controller,
                                          curve: Curves.easeIn,
                                        )),
                                        child: child,
                                      ),
                                    );
                                  },
                                  child: routines[index],
                                );
                              } else {
                                return Container(); // Placeholder while waiting for animation
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  DatePicker buildDatePicker(BuildContext context, DateTime initialDate) {
    return DatePicker(
      DateTime.now(),
      height: 90,
      width: MediaQuery.of(context).size.width * 0.123, //0.123
      deactivatedColor: Colors.white,
      initialSelectedDate: initialDate,
      selectionColor: Colors.pinkAccent,
      daysCount: 7,
      selectedTextColor: Colors.white,
      dateTextStyle: TextStyle(
          fontSize: 10,
          color: isLightMode ? Colors.black : Colors.white,
          fontFamily: 'poppins',
          fontWeight: FontWeight.w200),
      dayTextStyle: TextStyle(
          fontSize: 11,
          color: isLightMode ? Colors.black : Colors.white,
          fontFamily: 'poppins',
          fontWeight: FontWeight.w600),
      monthTextStyle: TextStyle(
          fontSize: 10,
          color: isLightMode ? Colors.black : Colors.white,
          fontFamily: 'poppins',
          fontWeight: FontWeight.w300),
      onDateChange: (date) {
        // New date selected

        if (selectedDate != date) {
          setState(() {
            _selectedDateIndex = date.weekday.toString();
            selectedDate = date;
            _resetAnimation();
          });
        }
      },
    );
  }
}
