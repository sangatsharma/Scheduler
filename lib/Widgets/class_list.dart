import 'package:flutter/material.dart';
import 'package:scheduler/Models/db_operations.dart';
import 'package:scheduler/Screens/admin/getAdmin_institution.dart';

//Todo Saurav fetch data from database based on the institution code
//filled by teacher
//List of class routine name
//should be fetch from database this is just dummy list

List<String> classNameList = [
  'Select your Class',
];

//function to convert string list of class into dropdownitemlist

List<DropdownMenuItem<String>> getDropDownItem() {
  //todo dosent change auto
  RoutineOp.getClasses(institutionName).then((value) => {
        if (classNameList.length == 1)
          {classNameList = classNameList + List<String>.from(value)}
      });
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
