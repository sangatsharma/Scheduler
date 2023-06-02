import 'package:flutter/material.dart';

//Todo Saurav fetch data from database based on the institution code
//filled by teacher
//List of teachers name
//should be fetch from database this is just dummy list

List<String> teachersNameList = [
  'Select your name',
  'Pralhad Shrestha',
  'Udaya raj Dhungana sdsa sdsdssdsdsdsdsdsdss sd',
  'Prem Gurung'
];

//function to convert string list of teachers into dropdownitemlist

List<DropdownMenuItem<String>> getDropDownItem() {
  List<DropdownMenuItem<String>> teacherNameDropDownItem = [];
  for (int i = 0; i < teachersNameList.length; i++) {
    var newItem = DropdownMenuItem<String>(
      value: teachersNameList[i],
      child: Text(teachersNameList[i]),
    );
    teacherNameDropDownItem.add(newItem);
  }
  return teacherNameDropDownItem;
}
