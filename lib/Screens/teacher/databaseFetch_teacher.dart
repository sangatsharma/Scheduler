import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:scheduler/Screens/teacher/teacher_name_select.dart';
import '../select_actor.dart';
import 'package:scheduler/Models/db_operations.dart';

// List<String> startingTimeTeacher = [
//   '17:17',
//   '17:19',
//   '17:10',
//   '17:21',
//   '14:57',
//   '14:58',
//   '14:59',
// ];
// //List can be of type dateTime
// List<String> endingTimeTeacher = [
//   '08:45',
//   '10:25',
//   '10:35',
//   '10:45',
//   '11:15',
//   '11:35',
//   '12:05',
// ];
// List<String> classNameTeacher = [
//   'BSE 4th sem',
//   'BSE 3rd sem',
//   'BSE 2nd sem',
//   'BSE 5th sem',
//   'BSE 6th sem',
//   'BSE 7th sem',
//   'BSE 8th sem',
// ];
// List<String> subjectNameTeacher = [
//   'Computer Organization and Architecture(2P)(A)',
//   'Numerical Method(2L)',
//   'Database Management System(2T)(A/B)',
//   'Numerical Method(2L)',
//   'DBMs(2T)(A/B)',
//   'Break',
//   'Computer Graphics(1L)',
// ];

List<Widget> fetchTeacherRoutine(
    String day, Map<String, dynamic> data, BuildContext context) {
  //fetch all data from database
  //items to be fetched and convert to list
  //todo make list empty and add from database
  //List can be of type dateTime
  List<Widget> allRoutine = [];
  List<String> startingTimeTeacher = data["starting_times"] ?? [];
  List<String> endingTimeTeacher = data["ending_times"] ?? [];
  String subjectNameTeacher =selectedTeacherName;
  //TODO
  List<String> classNameTeacher = ["BSE-4th"];

  for (int i = 0; i < startingTimeTeacher.length; i++) {
    Widget tempContainer = Container(
      margin: const EdgeInsets.only(top: 2, left: 4, right: 4, bottom: 3),
      height: 86,
      width: double.infinity,
      decoration: BoxDecoration(
        color: isLightMode ? const Color(0xffECC9EE) : Colors.black,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(
            color: isClassLive(startingTimeTeacher[i], endingTimeTeacher[i])
                ? Colors.green
                : Colors.transparent),
      ),
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
                  startingTimeTeacher[i],
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
                  endingTimeTeacher[i],
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
              color: isClassLive(startingTimeTeacher[i], endingTimeTeacher[i])
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
                      subjectNameTeacher,
                      style: const TextStyle(fontSize: 14),
                    ),
                    subjectNameTeacher,
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
                    classNameTeacher[i],
                    overflowReplacement: Text(
                      classNameTeacher[i],
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
List<Widget> showRoutine(
    String dayIndex, Map<String, dynamic> data, BuildContext context) {
  final d = data[dayIndex];
  switch (dayIndex) {
    case '1':
      return fetchTeacherRoutine('MON', d, context);

    case '2':
      return fetchTeacherRoutine('TUE', d, context);
    case '3':
      return fetchTeacherRoutine('WED', d, context);
    case '4':
      return fetchTeacherRoutine('THU', d, context);

    case '5':
      return fetchTeacherRoutine('FRI', d, context);

    case '6':
      return fetchTeacherRoutine('SAT', d, context);

    case '7':
      return fetchTeacherRoutine('SUN', d, context);
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

//Database
// import 'package:cloud_firestore/cloud_firestore.dart';

// Retrieve data
// void getData() {
//   FirebaseFirestore.instance
//       .collection('your_collection')
//       .doc('your_document_id')
//       .get()
//       .then((DocumentSnapshot documentSnapshot) {
//     if (documentSnapshot.exists) {
//       print('Document data: ${documentSnapshot.data()}');
//     } else {
//       print('Document does not exist on the database');
//     }
//   });
// }

// Store data
// void storeData() {
//   FirebaseFirestore.instance
//       .collection('your_collection')
//       .doc('your_document_id')
//       .set({
//     'field1': 'value1',
//     'field2': 'value2',
//   })
//       .then((value) => print('Data stored successfully'))
//       .catchError((error) => print('Failed to store data: $error'));
// }

// import 'package:cloud_firestore/cloud_firestore.dart';

// Add subject routine for a specific college, day, and period
// void addSubjectRoutine(String collegeId, String day, int period, String startTime, String endTime, String subjectName, String teacher) {
//   FirebaseFirestore.instance.collection('subject_routines').doc(collegeId).collection(day).doc('period_$period').set({
//     'start_time': startTime,
//     'end_time': endTime,
//     'subject_name': subjectName,
//     'teacher': teacher,
//   })
//       .then((value) => print('Subject routine added for college $collegeId on $day, period $period'))
//       .catchError((error) => print('Failed to add subject routine: $error'));
// }

// Get subject routine for a specific college, day, and period
// void getSubjectRoutine(String collegeId, String day, int period) {
//   FirebaseFirestore.instance.collection('subject_routines').doc(collegeId).collection(day).doc('period_$period').get()
//       .then((DocumentSnapshot documentSnapshot) {
//     if (documentSnapshot.exists) {
//       Map<String, dynamic> routine = documentSnapshot.data();
//       print('Subject routine for college $collegeId, $day, period $period:');
//       print('Start Time: ${routine['start_time']}');
//       print('End Time: ${routine['end_time']}');
//       print('Subject Name: ${routine['subject_name']}');
//       print('Teacher: ${routine['teacher']}');
//     } else {
//       print('Subject routine for college $collegeId, $day, period $period does not exist');
//     }
//   });
// }

// Create a document for a college
// void createCollegeDocument(String collegeId, String collegeName) {
//   FirebaseFirestore.instance.collection('colleges').doc(collegeId).set({
//     'name': collegeName,
//   })
//       .then((value) => print('College document created successfully'))
//       .catchError((error) => print('Failed to create college document: $error'));
// }

// import 'dart:math';

// Generate a unique ID with a timestamp and random number
// String generateUniqueId() {
//   DateTime now = DateTime.now();
//   String timestamp = now.microsecondsSinceEpoch.toString();
//   int randomNumber = Random().nextInt(1000000); // Generate a random number up to 999,999
//   String uniqueId = timestamp + randomNumber.toString().padLeft(6, '0');
//   return uniqueId.substring(0, 6); // Take the first 6 characters
// }
// OR

// import 'package:uuid/uuid.dart';
//
// String generateUniqueId() {
//   var uuid = Uuid();
//   String id = uuid.v4().split('-').join('').substring(0, 6);
//   return id;
// }
//
// void main() {
//   String uniqueId = generateUniqueId();
//   print('Unique ID: $uniqueId');
// }
