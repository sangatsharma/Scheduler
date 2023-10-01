import 'dart:collection';

import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:scheduler/Models/db_operations.dart';
import 'package:scheduler/Screens/admin/getAdmin_institution.dart';
import 'package:scheduler/Screens/teacher/teacher_name_select.dart';
// import '../Screens/admin/teacher_details_entry.dart';
import '../Screens/admin/teacher_details_entry.dart';
import '../Screens/select_actor.dart';
import 'login_users.dart';

class TeacherDetailsEditBox extends StatefulWidget {
  final int index;
  final String selectedTeacherId;
  final String selectedTeacherName;
  final int subjNo;
  final List<String> selectedSubject;
  const TeacherDetailsEditBox(
      {super.key,
      required this.index,
      required this.selectedTeacherId,
      required this.selectedTeacherName,
      required this.subjNo,
      required this.selectedSubject});

  @override
  State<TeacherDetailsEditBox> createState() => _TeacherDetailsEditBoxState();
}

class _TeacherDetailsEditBoxState extends State<TeacherDetailsEditBox> {
  final _formKey = GlobalKey<FormState>();
  String editedId = '';
  String editedName = '';
  late int editedSubjNo;
  late List<String> editedSubject;
  late List<String> selectedCourse;
  late List<String> saveSelectedCourse;

  @override
  void initState() {
    super.initState();
    editedId = widget.selectedTeacherId;
    editedName = widget.selectedTeacherName;
    editedSubjNo = widget.subjNo;
    editedSubject = widget.selectedSubject;
    selectedCourse = [
      editedSubject[0],
      editedSubject[1],
      editedSubject[2],
      editedSubject[3],
    ];
  }

  void first() {
    TeacherCollectionOp.fetchAllTeachers(institutionName).then((res) {
      setState(() {
        data = SplayTreeMap.from(res);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> generateSubjectDropdown(int num, double width) {
      List<Widget> inputDropdownList = [];
      for (int i = 0; i <= (num < 3 ? num : 3); i++) {
        Row t = Row(
          children: [
            SizedBox(
              height: width * 0.06,
              child: DropdownButton<String>(
                value: selectedCourse[i],
                onChanged: (newValue) {
                  setState(() {
                    selectedCourse[i] = newValue!;
                    editedSubject[i] = newValue;
                  });
                },
                items: fetchAllCourse.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                        fontSize: width * 0.015,
                        fontFamily: 'poppins',
                        color: Colors.black,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(
              height: width * 0.02,
            ),
          ],
        );
        inputDropdownList.add(t);
      }
      return inputDropdownList;
    }

    bool validateDropDown(int num) {
      bool flag = true;
      for (int i = 0; i < (num); i++) {
        if (selectedCourse[i] == 'Select course') {
          flag = false;
        }
      }
      return flag;
    }

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text('Edit Teacher Details: ${widget.index + 1}'),
      content: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Form(
                key: _formKey,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: width * 0.1,
                        child: TextFormField(
                          initialValue: widget.selectedTeacherId,
                          onChanged: (value) {
                            editedId = value;
                          },
                          style: TextStyle(
                            fontFamily: 'poppins',
                            fontSize: width * 0.015,
                          ),
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                              fontFamily: 'poppins',
                              color: isLightMode ? Colors.black : Colors.white,
                            ),
                            labelText: 'Id',
                            errorStyle: TextStyle(fontSize: width * 0.018),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),

                          //****  VALIDATION LOGIC ****//
                          validator: (value) {
                            final RegExp pattern = RegExp(r'^[1-9]\d*$');

                            // Make sure that input field is not Empty neither null
                            if (value == null || value.isEmpty) {
                              return 'Id ?';
                            } else if (!pattern.hasMatch(value)) {
                              return 'Invalid Id';
                            }
                            // If everything is good, return null
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      SizedBox(
                        width: width * 0.15,
                        child: TextFormField(
                          initialValue: widget.selectedTeacherName,
                          onChanged: (value) {
                            editedName = value;
                          },
                          style: TextStyle(
                            fontFamily: 'poppins',
                            fontSize: width * 0.015,
                          ),
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                              fontFamily: 'poppins',
                              color: isLightMode ? Colors.black : Colors.white,
                            ),
                            labelText: 'Name',
                            errorStyle: TextStyle(fontSize: width * 0.018),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),

                          //****  VALIDATION LOGIC ****//
                          validator: (value) {
                            final RegExp pattern =
                                RegExp(r'^[A-Za-z][A-Za-z ]*$');

                            // Make sure that input field is not Empty neither null
                            if (value == null || value.isEmpty) {
                              return 'Name ?';
                            } else if (!pattern.hasMatch(value)) {
                              return 'Invalid Name';
                            }
                            // If everything is good, return null
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      Column(
                        children: [
                          Text(
                            'No of subject:',
                            style: TextStyle(
                              fontSize: width * 0.015,
                              fontFamily: 'poppins',
                              color: isLightMode ? Colors.black : Colors.white,
                            ),
                          ),
                          SizedBox(width: width * 0.02),
                          DropdownButton<int>(
                            value: editedSubjNo,
                            onChanged: (int? newValue) {
                              setState(() {
                                editedSubjNo = newValue!;
                                editedSubject = ['-', '-', '-', '-'];
                                selectedCourse = [
                                  widget.selectedSubject[0] != '-'
                                      ? widget.selectedSubject[0]
                                      : 'Select course',
                                  widget.selectedSubject[1] != '-'
                                      ? widget.selectedSubject[1]
                                      : 'Select course',
                                  widget.selectedSubject[2] != '-'
                                      ? widget.selectedSubject[2]
                                      : 'Select course',
                                  widget.selectedSubject[3] != '-'
                                      ? widget.selectedSubject[3]
                                      : 'Select course',
                                ];
                              });
                            },
                            items: <int>[1, 2, 3, 4].map((int value) {
                              return DropdownMenuItem<int>(
                                value: value,
                                child: Text(
                                  value.toString(),
                                  style: TextStyle(
                                      fontSize: width * 0.02,
                                      fontFamily: 'poppins',
                                      color: Colors.black),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  children: [
                    Column(
                      children:
                          generateSubjectDropdown(editedSubjNo - 1, width),
                    ),
                    SizedBox(
                      width: height * 0.015,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          loginUser(_formKey);
                          if (loginUser(_formKey) &&
                              validateDropDown(editedSubjNo)) {
                            //todo add this to collection
                            saveSelectedCourse = [
                              selectedCourse[0] != 'Select course' &&
                                      editedSubjNo >= 1
                                  ? selectedCourse[0]
                                  : '-',
                              selectedCourse[1] != 'Select course' &&
                                      editedSubjNo >= 2
                                  ? selectedCourse[1]
                                  : '-',
                              selectedCourse[2] != 'Select course' &&
                                      editedSubjNo >= 3
                                  ? selectedCourse[2]
                                  : '-',
                              selectedCourse[3] != 'Select course' &&
                                      editedSubjNo == 4
                                  ? selectedCourse[3]
                                  : '-'
                            ];
                              print(saveSelectedCourse);
                            Map<String, dynamic> t = {};
                            data.forEach((key, value) {
                              if (key == widget.selectedTeacherId) {
                                t[editedId] = {
                                  "teacher_name": editedName,
                                  "subjects": saveSelectedCourse,
                                };
                              }
                            });
                            if (await TeacherCollectionOp.updateTeacher(
                                    institutionName,
                                    t) &&
                                context.mounted) {
                              context.showSuccessBar(
                                  content: const Text(
                                "Updated",
                                style: TextStyle(color: Colors.green),
                              ));
                              // first();
                              setState(() {
                                data.remove(widget.selectedTeacherId);
                                data[editedId] = {
                                  "teacher_name": editedName,
                                  "subjects": saveSelectedCourse,
                                };
                              });
                              Navigator.of(context).pop();
                            }
                            // //Clear all the input field
                            // _formKey.currentState?.reset();
                            // setState(() {
                            //   editedSubjNo = 1;
                            //   selectedCourse = [
                            //     'Select course',
                            //     'Select course',
                            //     'Select course',
                            //     'Select course',
                            //   ];
                            // });
                          } else {
                            //Show error message
                            context.showErrorBar(
                                content: const Text(
                                  'Select all field.',
                                  style: TextStyle(
                                      color: Colors.red, fontFamily: 'poppins'),
                                ),
                                position: FlashPosition.top);
                          }
                        },
                        child: SizedBox(
                          height: height * 0.05,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Edit',
                                style: TextStyle(fontFamily: 'poppins'),
                              ),
                              Icon(Icons.edit),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: const Text(
            'Cancel',
            style: TextStyle(
              fontFamily: 'poppins',
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog box
          },
        ),
      ],
    );
  }
}
