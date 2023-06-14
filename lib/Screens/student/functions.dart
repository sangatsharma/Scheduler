import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:scheduler/Screens/student/student_homepage.dart';

List<Widget> fetchRoutine(String day, BuildContext context) {
  //fetch all data from database
  //items to be fetched and convert to list
  //todo make list empty and add from database
  List<String> startingTime = [
    '10:15',
    '11:55',
    '1:35',
    '2:05',
    '2:55',
    '10:15',
    '11:55',
    '1:35',
    '2:05',
    '2:55',
  ];
  List<String> endingTime = [
    '11:55',
    '1:35',
    '2:05',
    '2:55',
    '4:35',
    //
    '11:55',
    '1:35',
    '2:05',
    '2:55',
    '4:35',
  ];
  List<String> teacherName = [
    'Dr.Rammani Adhikari',
    'Er.Rishi Sharan Khanal',
    'N/A ',
    'Er. Sujan Dhakal',
    'Er. ShivaramDam/Er. Sujan Dhakal',
    //
    'Dr.Rammani Adhikari',
    'Er.Rishi Sharan Khanal',
    'N/A ',
    'Er. Sujan Dhakal',
    'Er. ShivaramDam/Er. Sujan Dhakal',
  ];
  List<String> subjectName = [
    'Numerical Method(2L)',
    'DBMs(2T)(A/B)',
    'Break',
    'Computer Graphics(1L)',
    'Computer Organization and Architecture(2P)(A)',
    //
    'Numerical Method(2L)',
    'Database Management System(2T)(A/B)',
    'Break',
    'Computer Graphics(1L)',
    'Computer Organization and Architecture (2P)(A)/Computer Graphics (2p)(B)',
  ];
  List<Widget> allRoutine = [];
  for (int i = 0; i < startingTime.length; i++) {
    Widget tempContainer = Container(
      margin: const EdgeInsets.only(top: 3, left: 5, right: 5, bottom: 3),
      height: 85,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: isLightMode ? const Color(0xffECC9EE) : Colors.black),
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            width: MediaQuery.of(context).size.width * 0.28,
            child: Row(
              children: [
                Text(
                  startingTime[i],
                  style: TextStyle(
                    fontFamily: 'poppins',
                    fontSize: MediaQuery.of(context).size.width * 0.038,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                const Icon(
                  Icons.arrow_forward,
                  size: 20,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  endingTime[i],
                  style: TextStyle(
                    fontFamily: 'poppins',
                    fontSize: MediaQuery.of(context).size.width * 0.038,
                  ),
                ),
              ],
            ),
          ),
          VerticalDivider(
              thickness: 2,
              color: isLightMode ? Colors.pinkAccent : Colors.white),
          Container(
            margin: const EdgeInsets.only(left: 5),
            height: double.infinity,
            width: MediaQuery.of(context).size.width * 0.58,
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
      return fetchRoutine('SAT', context);
    default:
      return [];
  }
}
