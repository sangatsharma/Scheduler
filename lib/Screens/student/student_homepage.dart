import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; //formats date
import 'package:scheduler/Screens/student/student_class_select.dart';
import 'functions.dart';

class StudentHomepage extends StatefulWidget {
  const StudentHomepage({Key? key}) : super(key: key);
  static const String screen = 'studentHomepage';
  @override
  State<StudentHomepage> createState() => _StudentHomepageState();
}

//default light mode is selected
bool isLightMode = true;

class _StudentHomepageState extends State<StudentHomepage> {
  String _selectedDateIndex = DateTime.now().weekday.toString();
  DateTime selectedDate = DateTime.now();
//Theme mode to be used
  final ThemeData _lightTheme = ThemeData(
    brightness: Brightness.light,
  );
  final ThemeData _darkTheme = ThemeData(
    brightness: Brightness.dark,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: isLightMode ? _lightTheme : _darkTheme,
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
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1,
                                color:
                                    isLightMode ? Colors.black : Colors.white),
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
                          onPressed: () {},
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
            child: Column(
              children: [
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
                        child: DatePicker(
                          DateTime.now(),
                          height: 90,
                          width:
                              MediaQuery.of(context).size.width * 0.123, //0.123
                          deactivatedColor: Colors.white,
                          initialSelectedDate: selectedDate,
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
                            setState(() {
                              _selectedDateIndex = date.weekday.toString();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  // child: showRoutine(_selectedDateIndex),
                  child: SingleChildScrollView(
                    child: Column(
                      children: showRoutine(_selectedDateIndex, context),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
