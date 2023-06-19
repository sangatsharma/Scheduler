import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:scheduler/Screens/student/student_homepage.dart';

List<String> startingTime = [
  '09:57',
  '09:58',
  '10:00',
  '10:05',
  '10:08',
  '11:15',
  '11:35',
  '12:05',
  '12:15',
  '14:37',
  '14:38',
  '15:28',
];
//List can be of type dateTime
List<String> endingTime = [
  '08:38',
  '10:25',
  '10:35',
  '10:45',
  '11:15',
  '11:35',
  '12:05',
  '12:15',
  '12:55',
  '14:38',
  '14:39',
  '14:40',
];
List<String> teacherName = [
  'Er. ShivaramDam/Er. Sujan Dhakal',
  'Dr.Rammani Adhikari',
  'Er.Rishi Sharan Khanal',
  'Dr.Rammani Adhikari',
  'Er.Rishi Sharan Khanal',
  'N/A ',
  'Er. Sujan Dhakal',
  'Er. ShivaramDam/Er. Sujan Dhakal',
  'Dr.Rammani Adhikari',
  'Er.Rishi Sharan Khanal',
  'N/A ',
  'Er. Sujan Dhakal',
];
List<String> subjectName = [
  'Computer Organization and Architecture(2P)(A)',
  'Numerical Method(2L)',
  'Database Management System(2T)(A/B)',
  'Numerical Method(2L)',
  'DBMs(2T)(A/B)',
  'Break',
  'Computer Graphics(1L)',
  'Computer Organization and Architecture(2P)(A)',
  'Numerical Method(2L)',
  'Database Management System(2T)(A/B)',
  'Break',
  'Computer Graphics(1L)',
];

List<Widget> fetchRoutine(String day, BuildContext context) {
  //fetch all data from database
  //items to be fetched and convert to list
  //todo make list empty and add from database
  //List can be of type dateTime
  List<Widget> allRoutine = [];
  for (int i = 0; i < startingTime.length; i++) {
    Widget tempContainer = Container(
      margin: const EdgeInsets.only(top: 2, left: 4, right: 4, bottom: 3),
      height: 86,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(
              color: isClassLive(startingTime[i], endingTime[i])
                  ? Colors.green
                  : Colors.transparent),
          color: isLightMode ? const Color(0xffECC9EE) : Colors.black),
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            width: MediaQuery.of(context).size.width * 0.3,
            child: Row(
              children: [
                Text(
                  startingTime[i],
                  style: TextStyle(
                    fontFamily: 'poppins',
                    fontSize: MediaQuery.of(context).size.width * 0.036,
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                const Icon(
                  Icons.arrow_forward,
                  size: 20,
                ),
                const SizedBox(
                  width: 2,
                ),
                Text(
                  endingTime[i],
                  style: TextStyle(
                    fontFamily: 'poppins',
                    fontSize: MediaQuery.of(context).size.width * 0.036,
                  ),
                ),
              ],
            ),
          ),
          VerticalDivider(
              thickness: 2,
              color: isClassLive(startingTime[i], endingTime[i])
                  ? Colors.green
                  : Colors.pinkAccent),
          Container(
            margin: const EdgeInsets.only(left: 5),
            height: double.infinity,
            width: MediaQuery.of(context).size.width * 0.56,
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: AutoSizeText(
                    textAlign: TextAlign.left,
                    maxLines: 4,
                    maxFontSize: 28,
                    minFontSize: 17,
                    overflowReplacement: Text(
                      subjectName[i],
                      style: const TextStyle(fontSize: 14),
                    ),
                    subjectName[i],
                    style: const TextStyle(fontFamily: 'poppins'),
                  ),
                ),
                SizedBox(
                  height: 18,
                  width: double.infinity,
                  child: AutoSizeText(
                    textAlign: TextAlign.left,
                    maxLines: 2,
                    maxFontSize: 15,
                    minFontSize: 12,
                    teacherName[i],
                    overflowReplacement: Text(
                      teacherName[i],
                      style: const TextStyle(fontSize: 10),
                    ),
                    style: const TextStyle(
                      fontFamily: 'poppins',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    allRoutine.add(tempContainer);
  }
  return allRoutine;
}

//List to fetch routine from database caled by passing day as a string
//can be change day string to index according to the input field in admin section
//List to fetch routine from database caled by passing day as a string
//can be change day string to index according to the input field in admin section
List<Widget> showRoutine(String dayIndex, BuildContext context) {
  switch (dayIndex) {
    case '1':
      return fetchRoutine('MON', context);

    case '2':
      return fetchRoutine('TUE', context);
    case '3':
      return fetchRoutine('WED', context);
    case '4':
      return fetchRoutine('THU', context);

    case '5':
      return fetchRoutine('FRI', context);

    case '6':
      return fetchRoutine('SAT', context);

    case '7':
      return fetchRoutine('SUN', context);
    default:
      return [];
  }
}

//function to check if class is live to indicate live class
// denoted by green color vertical divider
//todo check dates more precisely
bool isClassLive(String startTime, String endTime) {
  bool flag = false;
  DateTime now = DateTime.now();
  String classStartTimeString =
      '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}T$startTime';
  String classEndTimeString =
      '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}T$endTime';
  DateTime classStartTime = DateTime.parse(classStartTimeString);
  DateTime classEndTime = DateTime.parse(classEndTimeString);
  if (now.isAfter(classStartTime)) {
    if (now.isBefore(classEndTime)) {
      flag = true;
    }
  }

  return flag;
}

// if (dateTime1.isBefore(dateTime2)) {
// print('DateTime1 is earlier than DateTime2');
// } else if (dateTime1.isAfter(dateTime2)) {
// print('DateTime1 is later than DateTime2');
// } else {
// print('DateTime1 is equal to DateTime2');
// }

// to convert am pm time to date type
// String timeString = '12:30 pm';
// DateTime dateTime = DateFormat('hh:mm a').parse(timeString);
//
// print(dateTime); // Output: 2023-06-17 12:30:00.000

// DateTime dateTime = DateTime(
//   now.year,
//   now.month,
//   now.day,
//   timeOfDay.hour,
//   timeOfDay.minute,
// );

// String timeString = '12:45';
// DateTime now = DateTime.now();
// String formattedTimeString =
//     '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}T$timeString';
// DateTime dateTime = DateTime.parse(formattedTimeString);
// print(dateTime);
