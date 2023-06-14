import 'package:flutter/material.dart';

Widget showRoutine(String dayIndex) {
  switch (dayIndex) {
    case '1':
      return Container(
        color: Colors.grey,
        margin: const EdgeInsets.all(8),
        width: double.infinity,
        child: const Text('Monday'),
      );
    case '2':
      return Container(
        color: Colors.greenAccent,
        margin: const EdgeInsets.all(8),
        width: double.infinity,
        child: const Text('Tuesday'),
      );
    case '3':
      return Container(
        color: Colors.greenAccent,
        margin: const EdgeInsets.all(8),
        width: double.infinity,
        child: const Text('wednesday'),
      );
    case '4':
      return Container(
        color: Colors.greenAccent,
        margin: const EdgeInsets.all(8),
        width: double.infinity,
        child: const Text('thursday'),
      );
    case '5':
      return Container(
        color: Colors.greenAccent,
        margin: const EdgeInsets.all(8),
        width: double.infinity,
        child: const Text('Friday'),
      );
    case '6':
      return Container(
        color: Colors.greenAccent,
        margin: const EdgeInsets.all(8),
        width: double.infinity,
        child: const Text('saturday'),
      );
    case '7':
      return Container(
        color: Colors.red,
        margin: const EdgeInsets.all(8),
        width: double.infinity,
        child: const Text('sunday'),
      );
    default:
      return Container();
  }
}

// onHorizontalDragEnd: (details) {
//   // Swiping in left direction.
//   setState(() {
//     if (details.primaryVelocity! < 0) {
//       _selectedDateIndex = selectedDate
//           .add(const Duration(days: 1))
//           .weekday
//           .toString();
//       selectedDate =
//           selectedDate.add(const Duration(days: 1));
//     }
//
//     // Swiping in right direction.
//     if (details.primaryVelocity! > 0) {
//       _selectedDateIndex = selectedDate
//           .subtract(const Duration(days: 1))
//           .weekday
//           .toString();
//       selectedDate =
//           selectedDate.subtract(const Duration(days: 1));
//     }
//   });
// },
