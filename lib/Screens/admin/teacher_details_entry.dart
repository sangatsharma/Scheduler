import 'dart:collection';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scheduler/Models/db_operations.dart';
import 'package:scheduler/Widgets/dialogbox_teachcer_edit.dart';
import '../../Auth/auth_service.dart';
import '../../Widgets/login_users.dart';
import '../../Widgets/shared_prefs.dart';
import '../../Widgets/themes.dart';
import 'package:scheduler/Screens/select_actor.dart';
import 'getAdmin_institution.dart';

class TeacherDetailsEntry extends StatefulWidget {
  const TeacherDetailsEntry({Key? key}) : super(key: key);

  static const String screen = 'TeacherDetailsEntry';
  @override
  State<TeacherDetailsEntry> createState() => _TeacherDetailsEntryState();
}

List<String> selectedCourse = [
  'Select course',
  'Select course',
  'Select course',
  'Select course',
];
String teacherId = '';
String teacherName = '';
int teacherSubjNo = 1;
List<String> subject = ['-', '-', '-', '-'];

//todo fetch all course and always first add  'Select your course' to the list.(to give hint about selecting your class)
//todo when user leaves select your class as it is we check if it is equal we throw error text.
List<String> fetchAllCourse = <String>[
  'Select course',
];

SplayTreeMap data = SplayTreeMap();

class _TeacherDetailsEntryState extends State<TeacherDetailsEntry> {
  final _formKey = GlobalKey<FormState>();

  void startup() async {
    //TODO no dummy
    final res = await CourseCollectionOp.fetchCourse(institutionName);
    final tRes = await TeacherCollectionOp.fetchAllTeachers(institutionName);
<<<<<<< HEAD
    late final SplayTreeMap a;
=======
>>>>>>> 84e9cfe8c0b9b9a5d157b63a13cb8f6daffea71f
    // await TeacherCollectionOp.addTeacher("demo-admin", "1", "tname", 1, "cname");
    if (fetchAllCourse.length == 1) {
      setState(() {
        fetchAllCourse = fetchAllCourse + res;
        data = SplayTreeMap.from(tRes);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    startup();
  }

  @override
  Widget build(BuildContext context) {
    startup();
    List<Widget> generateSubjectDropdown(int num, double width) {
      List<Widget> inputDropdownList = [];
      for (int i = 0; i <= (num < 3 ? num : 3); i++) {
        Row t = Row(
          children: [
            SizedBox(
              width: width * 0.2,
              child: DropdownButton<String>(
                value: selectedCourse[i],
                onChanged: (newValue) {
                  setState(() {
                    selectedCourse[i] = newValue!;
                    subject[i] = newValue;
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
                        color: isLightMode ? Colors.black : Colors.white,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(
              width: width * 0.02,
            ),
          ],
        );
        inputDropdownList.add(t);
      }
      return inputDropdownList;
    }

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
      theme: isLightMode ? lightTheme : darkTheme,
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
              elevation: 0,
              backgroundColor:
                  isLightMode ? const Color(0xffB1B2FF) : Colors.black,
              leadingWidth: double.infinity,
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
                      child: Icon(
                        Icons.west,
                        color: isLightMode ? Colors.black : Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isLightMode = !isLightMode;
                                setThemeMode(isLightMode);
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1,
                                      color: isLightMode
                                          ? Colors.black
                                          : Colors.white),
                                  borderRadius: BorderRadius.circular(20)),
                              margin: const EdgeInsets.only(left: 15),
                              child: isLightMode
                                  ? const Icon(
                                      Icons.nightlight,
                                      size: 20,
                                      color: Colors.black,
                                    )
                                  : const Icon(
                                      Icons.sunny,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 20),
                            child: Center(
                              child: IconButton(
                                splashRadius: 15,
                                mouseCursor: MaterialStateMouseCursor.clickable,
                                splashColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                alignment: Alignment.center,
                                onPressed: () async {
                                  bool success = await Authenticate.signOut(
                                      context: context);
                                  if (success && context.mounted) {
                                    Navigator.of(context).pop();
                                    Navigator.of(context)
                                        .pushNamed(SelectActor.screen);
                                  }
                                },
                                icon: const Icon(
                                  Icons.logout_outlined,
                                  size: 40,
                                  color: Colors.redAccent,
                                ),
                              ),
                            ),
                          )
                        ]),
                  ),
                ],
              )),
          body: Container(
            color: isLightMode ? Colors.white : Colors.black12,
            child: Column(children: [
              Container(
                decoration: BoxDecoration(
                    color: isLightMode ? const Color(0xffB1B2FF) : Colors.black,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15))),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                              DateFormat.yMMMMd().format(DateTime.now()),
                              style: TextStyle(
                                  fontFamily: 'poppins',
                                  fontSize: 15,
                                  color: isLightMode
                                      ? Colors.black
                                      : Colors.white)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              padding:
                                  const EdgeInsets.only(left: 8, bottom: 5),
                              child: AutoSizeText(
                                textAlign: TextAlign.left,
                                maxLines: 1,
                                maxFontSize: 35,
                                minFontSize: 25,
                                overflowReplacement: Text(
                                  institutionName,
                                  style: const TextStyle(fontSize: 25),
                                ),
                                institutionName,
                                style: const TextStyle(fontFamily: 'poppins'),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                margin: const EdgeInsets.only(left: 5, right: 5, top: 5),
                decoration: BoxDecoration(
                    color: isLightMode ? const Color(0xff9DB2FD) : Colors.black,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(8),
                        topLeft: Radius.circular(8))),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          child: Text('Enter Teacher Details :',
                              style: TextStyle(
                                fontFamily: 'poppins',
                                fontSize: 15,
                                color:
                                    isLightMode ? Colors.black : Colors.white,
                              )),
                        ),
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
                                    onChanged: (value) {
                                      setState(() {
                                        teacherId = value;
                                      });
                                    },
                                    style: TextStyle(
                                      fontFamily: 'poppins',
                                      fontSize: width * 0.015,
                                    ),
                                    decoration: InputDecoration(
                                      labelStyle: TextStyle(
                                        fontFamily: 'poppins',
                                        color: isLightMode
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                      labelText: 'Id',
                                      errorStyle:
                                          TextStyle(fontSize: width * 0.018),
                                      border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                    ),

                                    //****  VALIDATION LOGIC ****//
                                    validator: (value) {
                                      final RegExp pattern =
                                          RegExp(r'^[1-9]\d*$');

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
                                    onChanged: (value) {
                                      setState(() {
                                        teacherName = value;
                                      });
                                    },
                                    style: TextStyle(
                                      fontFamily: 'poppins',
                                      fontSize: width * 0.015,
                                    ),
                                    decoration: InputDecoration(
                                      labelStyle: TextStyle(
                                        fontFamily: 'poppins',
                                        color: isLightMode
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                      labelText: 'Name',
                                      errorStyle:
                                          TextStyle(fontSize: width * 0.018),
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
                                        color: isLightMode
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: width * 0.02),
                                    DropdownButton<int>(
                                      value: teacherSubjNo,
                                      onChanged: (int? newValue) {
                                        setState(() {
                                          teacherSubjNo = newValue!;
                                          subject = ['-', '-', '-', '-'];
                                          selectedCourse = [
                                            'Select course',
                                            'Select course',
                                            'Select course',
                                            'Select course',
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
                                              color: isLightMode
                                                  ? Colors.black
                                                  : Colors.white,
                                            ),
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
                          child: Row(
                            children: [
                              Row(
                                children: generateSubjectDropdown(
                                    teacherSubjNo - 1, width),
                              ),
                              SizedBox(
                                width: width * 0.015,
                              ),
                              ElevatedButton(
                                  onPressed: () async {
                                    loginUser(_formKey);
                                    if (loginUser(_formKey) &&
                                        validateDropDown(teacherSubjNo)) {
                                      //todo add this to collection
                                      await TeacherCollectionOp.addTeacher(
                                          institutionName,
                                          teacherId,
                                          teacherName,
                                          subject);
                                      //Clear all the input field
                                      _formKey.currentState?.reset();
                                      setState(() {
                                        teacherSubjNo = 1;
                                        selectedCourse = [
                                          'Select course',
                                          'Select course',
                                          'Select course',
                                          'Select course',
                                        ];
                                      });
                                      setState(() {
                                        data[teacherId] = {
                                          "teacher_name": teacherName,
                                          "subjects": subject,
                                        };
                                        context.showSuccessBar(
                                            content: const Text(
                                          'Added',
                                          style: TextStyle(color: Colors.green),
                                        ));
                                      });
                                    } else {
                                      //Show error message
                                      context.showErrorBar(
                                          content: const Text(
                                            'Select all field.',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                          position: FlashPosition.top);
                                    }
                                  },
                                  child: SizedBox(
                                    height: height * 0.05,
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Add',
                                          style: TextStyle(),
                                        ),
                                        Icon(Icons.add),
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('Teacher Details',
                            style: TextStyle(
                                fontFamily: 'poppins',
                                color:
                                    isLightMode ? Colors.black : Colors.white)),
                        const SizedBox(
                          width: 5,
                        ),
                        Divider(
                          color: isLightMode ? Colors.black26 : Colors.white,
                          thickness: 2,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  margin: const EdgeInsets.only(
                    bottom: 5,
                    left: 5,
                    right: 5,
                  ),
                  decoration: BoxDecoration(
                      color:
                          isLightMode ? const Color(0xff9DB2FD) : Colors.black,
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8))),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  DataTable(
                                    showCheckboxColumn: true,
                                    columns: const <DataColumn>[
                                      DataColumn(
                                        label: Expanded(
                                          child: Text(
                                            'S.N',
                                            style: TextStyle(
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Expanded(
                                          child: Text(
                                            'Name',
                                            style: TextStyle(
                                                fontStyle: FontStyle.normal),
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Expanded(
                                          child: Text(
                                            'Subject 1',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic),
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Expanded(
                                          child: Text(
                                            'Subject 2',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic),
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Expanded(
                                          child: Text(
                                            'Subject 3',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic),
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Expanded(
                                          child: Text(
                                            'Subject 4',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic),
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Expanded(
                                          child: Text(
                                            'Edit',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic),
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Expanded(
                                          child: Text(
                                            'Delete',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic),
                                          ),
                                        ),
                                      ),
                                    ],
                                    rows: dataCellForTeachers(
                                        data, setState, context),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
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

List<DataRow> dataCellForTeachers(final td, final first, BuildContext context) {
  List<DataRow> res = [];
  print(td);

  if (td == null) {
    return res;
  }

  td.forEach((key, value) {
    int c = 0;
    List.from(value["subjects"]).forEach((element) {
      if (element != '-') {
        c++;
      }
    });
    List<String> l = List.from(value["subjects"]);
    DataRow tmp = DataRow(cells: <DataCell>[
      DataCell(Text(key)),
      DataCell(Text(value["teacher_name"])),
      DataCell(Text(value["subjects"][0])),
      DataCell(Text(value["subjects"][1])),
      DataCell(Text(value["subjects"][2])),
      DataCell(Text(value["subjects"][3])),
      DataCell(const Icon(Icons.edit), onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return TeacherDetailsEditBox(
              index: 0,
              selectedSubject: l,
              selectedTeacherId: key,
              selectedTeacherName: value["teacher_name"],
              subjNo: c,
            );
          },
        );
      }),
      DataCell(
        const Icon(Icons.delete),
        onTap: () async {
          TeacherCollectionOp.removeTeacher(institutionName, key);
          first(() {
            data.remove(key);
          });
          context.showSuccessBar(
              content: const Text(
            "Removed",
            style: TextStyle(color: Colors.green),
          ));
        },
      ),
    ]);

    res.add(tmp);
  });
  return res;
}
