import 'package:flutter/material.dart';
import 'package:scheduler/Models/db_operations.dart';
import 'package:scheduler/Screens/admin/getAdmin_institution.dart';

//Todo Saurav fetch data from database based on the institution code
//filled by teacher
//List of teachers name
//should be fetch from database this is just dummy list

List<String> teachersNameList = [
  'Select your name',
];

//function to convert string list of teachers into dropdownitemlist

List<DropdownMenuItem<String>> getDropDownItem() {
  List<DropdownMenuItem<String>> teacherNameDropDownItem = [];
  List<String> names = [];
  TeacherCollectionOp.fetchAllTeachers(institutionName).then((value){
    value.forEach((key, value) {
      names.add(value["teacher_name"]);
    });
    teachersNameList = teachersNameList + names;
  });
  for (int i = 0; i < teachersNameList.length; i++) {
    var newItem = DropdownMenuItem<String>(
      value: teachersNameList[i],
      child: Text(teachersNameList[i]),
    );
    teacherNameDropDownItem.add(newItem);
  }
  return teacherNameDropDownItem;
}
