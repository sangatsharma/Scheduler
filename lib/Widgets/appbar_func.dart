import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context, String labelText) {
  return AppBar(
    backgroundColor: Colors.transparent,
    leading: Row(
      children: [
        const SizedBox(
          width: 5,
        ),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(
              Icons.west,
              color: Colors.black,
              size: 30,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          labelText,
          style: const TextStyle(
              fontFamily: 'poppins', fontSize: 25, color: Colors.black),
        )
      ],
    ),
    leadingWidth: 160,
    elevation: 0,
  );
}
