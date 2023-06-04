import 'package:flutter/material.dart';
import 'package:scheduler/Widgets/teachers_list.dart';
import 'package:scheduler/Screens/teacher_login.dart';

import '../Widgets/appbar_func.dart';
import '../Widgets/next_button.dart';

class TeacherNameSelect extends StatefulWidget {
  const TeacherNameSelect({Key? key}) : super(key: key);
  static const String screen = 'TeacherNameSelect';

  @override
  State<TeacherNameSelect> createState() => _TeacherNameSelectState();
}

class _TeacherNameSelectState extends State<TeacherNameSelect> {
  //initial value for selectedTeacherName,
  //final value should not be same as initial.
  String selectedTeacherName = 'Select your name';
  Color dropDownBorderColor = Colors.grey;
  Color errorTextColor = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: buildAppBar(context, 'Teacher'),
          body: Center(
              child: SingleChildScrollView(
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.transparent,
                  child: Image(
                    image: AssetImage(
                      'Assets/images/logo.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                const Text(
                  'Ready to join ?',
                  style: TextStyle(
                      fontFamily: 'poppins',
                      fontSize: 35,
                      fontWeight: FontWeight.normal),
                ),
                const SizedBox(height: 40),
                TextFormField(
                  initialValue: teacherInstitutionCode,
                  readOnly: true,
                  style: const TextStyle(
                    fontFamily: 'poppins',
                    fontSize: 18,
                  ),
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(fontFamily: 'poppins'),
                    labelText: 'Institution Code',
                    prefixIcon: Icon(Icons.key),
                    constraints: BoxConstraints(maxHeight: 60, maxWidth: 300),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),

                  //validation of institution code {* Not required in this page}
                  //validation should be done in previous page so that teachers dropdown list
                  //of that institution will be fetch from that institution's database.
                  // validator: (value) {
                  //   if (value == null) {
                  //     return 'Please enter your username';
                  //   }
                  //   return null;
                  // },
                ),
                const SizedBox(height: 20),
                Container(
                  clipBehavior: Clip.hardEdge,
                  height: 60,
                  width: 300,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: dropDownBorderColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  //Teacher name dropDownButton
                  child: DropdownButton<String>(
                    isExpanded: true,
                    padding: const EdgeInsets.only(left: 20, top: 5),
                    style: const TextStyle(
                        fontFamily: 'poppins',
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                    alignment: Alignment.center,
                    focusColor: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    value: selectedTeacherName,
                    //getDropDownItem() from teacher_list.dart
                    items: getDropDownItem(),
                    onChanged: (value) {
                      setState(() {
                        selectedTeacherName = value.toString();
                      });
                      //validation for selected name
                      validateSelectName();
                    },
                    underline: Container(color: Colors.transparent),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  height: 20,
                  width: 300,
                  padding: const EdgeInsets.only(top: 4, left: 10),
                  child: Text(
                    'Please select your name',
                    style: TextStyle(fontSize: 12, color: errorTextColor),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    //validation for selected name
                    if (selectedTeacherName != teachersNameList[0]) {
                      // route to next page
                    } else {
                      validateSelectName();
                    }
                  },
                  //hero is used for simple animation similar to morph in powerpoint
                  child: const Hero(
                    tag: 'Button',
                    child: NextButton(
                      //next btn is a custom widget from next_button.dart
                      btnIcon: Icon(
                        Icons.east,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ))),
    );
  }

  //****  VALIDATION LOGIC ****//
//function to check if final selected name is not equal to initial.
  void validateSelectName() {
    //validation for selected name
    setState(() {
      if (selectedTeacherName != teachersNameList[0]) {
        debugPrint(selectedTeacherName);
        errorTextColor = Colors.transparent;
        dropDownBorderColor = Colors.grey;
      } else {
        errorTextColor = Colors.red;
        dropDownBorderColor = Colors.red;
      }
    });
  }
}
