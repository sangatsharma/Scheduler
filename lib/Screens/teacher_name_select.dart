import 'package:flutter/material.dart';
import 'package:scheduler/Widgets/teachers_list.dart';
import 'package:scheduler/Screens/teacher_login.dart';

class TeacherNameSelect extends StatefulWidget {
  const TeacherNameSelect({Key? key}) : super(key: key);
  static const String screen = 'TeacherNameSelect';

  @override
  State<TeacherNameSelect> createState() => _TeacherNameSelectState();
}

class _TeacherNameSelectState extends State<TeacherNameSelect> {
  String selectedTeacherName = 'Select your name';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: Row(
              children: [
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(
                    Icons.west,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'Teacher',
                  style: TextStyle(
                      fontFamily: 'poppins', fontSize: 25, color: Colors.black),
                )
              ],
            ),
            leadingWidth: 160,
            elevation: 0,
          ),
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

                  //Todo validation of institution code
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
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  //Teacher name dropDownButton
                  child: DropdownButton<String>(
                    isExpanded: true,
                    padding: const EdgeInsets.only(left: 20, top: 5),
                    style: const TextStyle(
                        fontFamily: 'poppins',
                        fontSize: 15,
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
                    },
                    underline: Container(color: Colors.transparent),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  //hero is used for simple animation similar to morph in powerpoint
                  child: Hero(
                    tag: 'Button',
                    child: Container(
                      height: 45,
                      width: 70,
                      margin: const EdgeInsets.only(top: 30),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.elliptical(35, 35),
                        ),
                        border: Border.fromBorderSide(
                          BorderSide(width: 1),
                        ),
                      ),
                      child: const Icon(Icons.east, size: 30),
                    ),
                  ),
                ),
              ],
            ),
          ))),
    );
  }
}
