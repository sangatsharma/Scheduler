import 'package:flutter/material.dart';

//Todo Saurav fetch data from database based on the institution code
//filled by teacher
//List of class routine name
//should be fetch from database this is just dummy list

List<String> classNameList = [
  'Select your Class',
  'BSE 4th sem',
  'BSE 3rd sem',
  'BSE 2nd sem',
  'BSE 5th sem',
  'BSE 6th sem',
  'BSE 7th sem',
  'BSE 8th sem',
  'BOCE 1st sem',
  'BOCE 2nd sem',
  'BOCE 4th sem',
  'BOCE 5th sem',
  'BOCE 6th sem',
];

//function to convert string list of class into dropdownitemlist

List<DropdownMenuItem<String>> getDropDownItem() {
  List<DropdownMenuItem<String>> classNameDropDownItem = [];
  for (int i = 0; i < classNameList.length; i++) {
    var newItem = DropdownMenuItem<String>(
      value: classNameList[i],
      child: Text(classNameList[i]),
    );
    classNameDropDownItem.add(newItem);
  }
  return classNameDropDownItem;
}
