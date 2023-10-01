import 'package:auto_size_text/auto_size_text.dart';
import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scheduler/Models/db_operations.dart';
import 'package:scheduler/Screens/admin/teacher_details_entry.dart';
import 'package:scheduler/Screens/student/student_class_select.dart';
import '../../Auth/auth_service.dart';
import '../../Widgets/login_users.dart';
import '../../Widgets/shared_prefs.dart';
import '../../Widgets/themes.dart';
import 'package:scheduler/Screens/select_actor.dart';
import 'getAdmin_institution.dart';

class ClassRoutineEntry extends StatefulWidget {
  const ClassRoutineEntry({Key? key}) : super(key: key);

  static const String screen = 'CourseRoutineEntry';
  @override
  State<ClassRoutineEntry> createState() => _ClassRoutineEntryState();
}

Map<String, Map<String, List<String>>> routineDetails = {};
List<dynamic> classNames = [];
//variables for storing all details
String selectedDay = 'Select Day';
String totalPeriod = 'Total periods';
List<String> saveTeachers = [];
List<String> saveSubjects = [];
List<String> saveStartTime = [];
List<String> saveEndTime = [];

//variable to add new class
String addedClass = '';

//todo get period no. and other details from database of active class
//for displaying routines
String activeClass = '';
int activeClassPeriod = 1;
List<String> day = ['.'];
List<String> startTime = [""];
List<String> endTime = [""];
List<String> subjects = [""];
List<String> teachers = [""];
//todo below function is used to update values for each class routine
void updateValues(String className) {
  //todo update from db
  // List<String> day = ['Sunday'];
  // List<String> startTime = ['10:20', '10:40'];
  // List<String> endTime = ['10:40', '11:30'];
  // List<String> subjects = ['Maths', 'Science'];
  // List<String> teachers = ['Prem Gurung', 'Ramesh Bhandari'];
}

//For taking routine inputs
//todo fetch data from database
List<String> teachersDB = ['Select Teacher'];
List<String> subjectDB = ['Select Subject'];
List<String> inputTeacher = [
  'Select Teacher',
  'Select Teacher',
  'Select Teacher',
  'Select Teacher',
  'Select Teacher',
  'Select Teacher',
  'Select Teacher',
  'Select Teacher',
  'Select Teacher',
  'Select Teacher'
];
List<String> inputSubject = [
  'Select Subject',
  'Select Subject',
  'Select Subject',
  'Select Subject',
  'Select Subject',
  'Select Subject',
  'Select Subject',
  'Select Subject',
  'Select Subject',
  'Select Subject'
];
List<String> inputStartTimes = ['', '', '', '', '', '', '', '', '', ''];
List<String> inputEndTimes = ['', '', '', '', '', '', '', '', '', ''];

final _formKey = GlobalKey<FormState>();

class _ClassRoutineEntryState extends State<ClassRoutineEntry> {
  final _formKey1 = GlobalKey<FormState>();

  void fetchRoutine(var newValue) {
    setState(() {
      selectedDay = newValue!;
      day = [selectedDay];
      String w = RoutineOp.weekDay(selectedDay);
      activeClassPeriod = routineDetails[w]?["starting_times"]!.length ?? 1;
      startTime = routineDetails[w]?["starting_times"] ?? [''];
      endTime = routineDetails[w]?["ending_times"] ?? [''];
      subjects = routineDetails[w]?["subjects"] ?? [''];
      teachers = routineDetails[w]?["teachers_name"] ?? [''];
    });
  }

  void first() {
    RoutineOp.getClasses(institutionName).then((classN) {
      CourseCollectionOp.fetchCourse(institutionName).then((cources) {
        TeacherCollectionOp.fetchAllTeachers(institutionName).then((teachers) {
          List<String> names = [];
          teachers.forEach((k,v) {
            names.add(v["teacher_name"]);
          });
          setState(() {
            classNames = classN;
            subjectDB = subjectDB + cources;
            teachersDB = teachersDB + names;
          });
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    first();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    List<Widget> getRoutineFields(
        String allPeriods, GlobalKey<FormState> formKey) {
      List<Widget> temp = [];

      //check time in : HH:MM 24 format
      bool isValidTime(String time) {
        final RegExp timeRegex = RegExp(
          r'^(0[0-9]|1[0-9]|2[0-3]):([0-5][0-9])$',
        );
        return timeRegex.hasMatch(time);
      }

      //check if dropdown is not selected
      bool checkDropdown(String num) {
        int no = int.parse(num);
        bool flag = true;
        for (int k = 0; k < no; k++) {
          if (inputTeacher[k] == 'Select Teacher' &&
              inputSubject[k] == 'Select Subject') {
            flag = false;
          }
        }
        return flag;
      }

      if (allPeriods == 'Total periods') {
        return temp;
      } else {
        int j = int.parse(allPeriods);
        for (int i = 0; i < j; i++) {
          Column t = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('  Period ${i + 1}'),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                width: 80,
                height: 40,
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      inputStartTimes[i] = value;
                    });
                  },
                  style: const TextStyle(
                    fontFamily: 'poppins',
                    fontSize: 10,
                  ),
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      fontFamily: 'poppins',
                      color: isLightMode ? Colors.black : Colors.white,
                    ),
                    labelText: 'Start time',
                    errorStyle: const TextStyle(fontSize: 10),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),

                  //****  VALIDATION LOGIC ****//
                  validator: (value) {
                    // Make sure that input field is not Empty neither null
                    if (value == null || value.isEmpty) {
                      return 'HH:MM ?';
                    }
                    if (!isValidTime(inputStartTimes[i])) return 'HH:MM !';
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                width: 80,
                height: 40,
                child: TextFormField(
                  onChanged: (value) {
                    inputEndTimes[i] = value;
                  },
                  style: const TextStyle(
                    fontFamily: 'poppins',
                    fontSize: 12,
                  ),
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      fontFamily: 'poppins',
                      color: isLightMode ? Colors.black : Colors.white,
                    ),
                    labelText: 'End time',
                    errorStyle: const TextStyle(fontSize: 10),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),

                  //****  VALIDATION LOGIC ****//
                  validator: (value) {
                    // Make sure that input field is not Empty neither null
                    if (value == null || value.isEmpty) {
                      return 'HH:MM ?';
                    }
                    if (!isValidTime(inputEndTimes[i])) return 'HH:MM !';
                    // If everything is good, return null
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              DropdownButton<String>(
                value: inputTeacher[i],
                onChanged: (String? newValue) {
                  setState(() {
                    inputTeacher[i] = newValue!;
                  });
                },
                items: teachersDB.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontFamily: 'poppins',
                        fontSize: 12,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 10,
              ),
              DropdownButton<String>(
                value: inputSubject[i],
                onChanged: (String? newValue) {
                  setState(() {
                    inputSubject[i] = newValue!;
                  });
                },
                items: subjectDB.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontFamily: 'poppins',
                        fontSize: 12,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          );
          temp.add(t);
          temp.add(const SizedBox(
            width: 5,
          ));
        }
        temp.add(
          ElevatedButton(
              onPressed: () async {
                if (activeClass == '') {
                  context.showErrorBar(
                      content: const Text(
                        'Select class first',
                        style:
                            TextStyle(color: Colors.red, fontFamily: 'poppins'),
                      ),
                      position: FlashPosition.top);
                  return;
                }
                loginUser(formKey);
                if (loginUser(formKey) &&
                    checkDropdown(allPeriods) &&
                    selectedDay != 'Select Day') {
                  //todo fetch data to database and ui
                  List<Map<String, dynamic>> d = [];
                  setState(() {
                    for (int i = 0; i < int.parse(allPeriods); i++) {
                      Map<String, dynamic> t = {
                        "starting_time": inputStartTimes[i],
                        "ending_time": inputEndTimes[i],
                        "teacher_name": inputTeacher[i],
                        "subject": inputSubject[i]
                      };
                      d.add(t);
                    }
                    RoutineOp.uploadRoutine(
                        institutionName, activeClass, d, selectedDay);
                    //todo save below variables to db
                    context.showSuccessBar(
                        content: const Text(
                          'Added successfully',
                          style: TextStyle(
                              color: Colors.green, fontFamily: 'poppins'),
                        ),
                        position: FlashPosition.top);
                    //Clear all the input field after data is saved to database and change is reflected in ui
                    inputEndTimes = ['', '', '', '', '', '', '', '', '', ''];
                    inputStartTimes = ['', '', '', '', '', '', '', '', '', ''];
                    inputSubject = [
                      'Select Subject',
                      'Select Subject',
                      'Select Subject',
                      'Select Subject',
                      'Select Subject',
                      'Select Subject',
                      'Select Subject',
                      'Select Subject',
                      'Select Subject',
                      'Select Subject'
                    ];
                    inputTeacher = [
                      'Select Teacher',
                      'Select Teacher',
                      'Select Teacher',
                      'Select Teacher',
                      'Select Teacher',
                      'Select Teacher',
                      'Select Teacher',
                      'Select Teacher',
                      'Select Teacher',
                      'Select Teacher'
                    ];
                  });
                  fetchRoutine(selectedDay);
                  formKey.currentState?.reset();
                } else {
                  context.showErrorBar(
                      content: const Text(
                        'Select all Fields',
                        style:
                            TextStyle(color: Colors.red, fontFamily: 'poppins'),
                      ),
                      position: FlashPosition.top);
                }
              },
              child: const SizedBox(
                height: 40,
                width: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Add',
                      style: TextStyle(fontSize: 12),
                    ),
                    Icon(
                      Icons.add,
                      size: 8,
                    ),
                  ],
                ),
              )),
        );
        return temp;
      }
    }

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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                margin: const EdgeInsets.only(left: 5, right: 5, top: 5),
                decoration: BoxDecoration(
                    color: isLightMode ? const Color(0xff9DB2FD) : Colors.black,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: Text('Enter Routine Details :',
                          style: TextStyle(
                            fontFamily: 'poppins',
                            fontSize: 15,
                            color: isLightMode ? Colors.black : Colors.white,
                          )),
                    ),
                    const SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Form(
                        key: _formKey1,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              DropdownButton<String>(
                                value: selectedDay,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedDay = newValue!;
                                    day = [selectedDay];
                                    String w = RoutineOp.weekDay(selectedDay);
                                    activeClassPeriod = routineDetails[w]
                                                ?["starting_times"]!
                                            .length ??
                                        1;
                                    startTime = routineDetails[w]
                                            ?["starting_times"] ??
                                        [''];
                                    endTime = routineDetails[w]
                                            ?["ending_times"] ??
                                        [''];
                                    subjects =
                                        routineDetails[w]?["subjects"] ?? [''];
                                    teachers = routineDetails[w]
                                            ?["teachers_name"] ??
                                        [''];
                                  });
                                },
                                items: <String>[
                                  "Select Day",
                                  "Monday",
                                  "Tuesday",
                                  "Wednesday",
                                  "Thursday",
                                  "Friday",
                                  "Saturday",
                                  "Sunday",
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                        fontFamily: 'poppins',
                                        fontSize: width * 0.008,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                              SizedBox(
                                width: width * 0.02,
                              ),
                              DropdownButton<String>(
                                value: totalPeriod,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    totalPeriod = newValue!;
                                  });
                                },
                                items: <String>[
                                  'Total periods',
                                  '4',
                                  '5',
                                  '6',
                                  '7',
                                  '8',
                                  '9',
                                  '10'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                        fontFamily: 'poppins',
                                        fontSize: width * 0.008,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children:
                                    getRoutineFields(totalPeriod, _formKey1),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Classes:',
                              style: TextStyle(
                                  fontFamily: 'poppins',
                                  color: isLightMode
                                      ? Colors.black
                                      : Colors.white)),
                          const SizedBox(
                            width: 150,
                          ),
                          Text('Routine: $activeClass',
                              style: TextStyle(
                                  fontFamily: 'poppins',
                                  color: isLightMode
                                      ? Colors.black
                                      : Colors.white)),
                        ],
                      ),
                    ),
                    Divider(
                      color: isLightMode ? Colors.black26 : Colors.white,
                      thickness: 2,
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
                        color: isLightMode
                            ? const Color(0xff9DB2FD)
                            : Colors.black,
                        borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8))),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            //class name list
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                  right: BorderSide(
                                      color: isLightMode
                                          ? Colors.grey
                                          : Colors.white,
                                      width: 2.0),
                                )),
                                width: 200,
                                height: height * 0.58,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Form(
                                      key: _formKey,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 120,
                                            height: 60,
                                            child: TextFormField(
                                              onChanged: (value) {
                                                addedClass = value;
                                              },
                                              style: const TextStyle(
                                                fontFamily: 'poppins',
                                                fontSize: 12,
                                              ),
                                              decoration: InputDecoration(
                                                labelStyle: TextStyle(
                                                  fontFamily: 'poppins',
                                                  color: isLightMode
                                                      ? Colors.black
                                                      : Colors.white,
                                                ),
                                                labelText: 'Add class',
                                                errorStyle: const TextStyle(
                                                    fontSize: 12),
                                                border:
                                                    const OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(10),
                                                  ),
                                                ),
                                              ),

                                              //****  VALIDATION LOGIC ****//
                                              validator: (value) {
                                                // Make sure that input field is not Empty neither null
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'class ?';
                                                }
                                                // If everything is good, return null
                                                return null;
                                              },
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          ElevatedButton(
                                              onPressed: () async {
                                                loginUser(_formKey);
                                                if (loginUser(_formKey)) {
                                                  //todo add this to collection
                                                  RoutineOp.addClass(
                                                      institutionName,
                                                      addedClass);

                                                  context.showSuccessBar(
                                                      content: Text(
                                                    "Added class $addedClass",
                                                    style: const TextStyle(
                                                        color: Colors.green),
                                                  ));
                                                  //Clear all the input field
                                                  _formKey.currentState
                                                      ?.reset();
                                                }
                                              },
                                              child: const SizedBox(
                                                height: 40,
                                                width: 30,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Add',
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                    Icon(
                                                      Icons.add,
                                                      size: 8,
                                                    ),
                                                  ],
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                    const Divider(thickness: 2, endIndent: 10),
                                    Expanded(
                                      child: SizedBox(
                                        width: 198,
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.vertical,
                                          child: SizedBox(
                                            height: height * 0.5,
                                            width: 190,
                                            child: ListView.builder(
                                              itemCount: classNames.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return ListTile(
                                                  title: Column(
                                                    children: [
                                                      ElevatedButton(
                                                        onPressed: () async {
                                                          RoutineOp.fetchRoutine(
                                                                  institutionName,
                                                                  classNames[
                                                                      index])
                                                              .then((value) {
                                                            print(value);
                                                            setState(() {
                                                              routineDetails =
                                                                  value;
                                                            });
                                                            if (selectedDay !=
                                                                'Select Day') {
                                                              fetchRoutine(
                                                                  selectedDay);
                                                            }
                                                          });
                                                          setState(() {
                                                            activeClass =
                                                                classNames[
                                                                    index];
                                                            updateValues(
                                                                activeClass);
                                                          });
                                                        },
                                                        child: SizedBox(
                                                          height: 20,
                                                          width: 200,
                                                          child: Text(
                                                            classNames[index],
                                                          ),
                                                        ),
                                                      ),
                                                      const Divider(
                                                          thickness: 1,
                                                          endIndent: 10),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          Expanded(
                            flex: 10,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: SizedBox(
                                height: height * 0.58,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          children: [
                                            SingleChildScrollView(
                                              scrollDirection: Axis.vertical,
                                              child: Column(
                                                children: [
                                                  SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        //todo make data table here
                                                        DataTable(
                                                          dataRowMaxHeight: 65,
                                                          showCheckboxColumn:
                                                              true,
                                                          columns: generateColumn(
                                                              activeClassPeriod),
                                                          rows: generateRow(
                                                              context,
                                                              fetchRoutine),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
              )
            ]),
          ),
        ),
      ),
    );
  }
}

List<DataColumn> generateColumn(int totalPeriod) {
  List<DataColumn> temp = [];
  if (totalPeriod == 0) {
    return [const DataColumn(label: Text(""))];
  }
  temp.add(
    const DataColumn(
      label: Expanded(
        child: Text(
          'Day',
          style: TextStyle(
            fontFamily: 'poppins',
          ),
        ),
      ),
    ),
  );
  for (int i = 0; i < totalPeriod; i++) {
    temp.add(
      DataColumn(
        label: Expanded(
          child: Text(
            'Period ${i + 1}',
            style: const TextStyle(
              fontFamily: 'poppins',
            ),
          ),
        ),
      ),
    );
  }
  temp.add(
    const DataColumn(
      label: Expanded(
        child: Text(
          'Edit',
          style: TextStyle(
            fontFamily: 'poppins',
          ),
        ),
      ),
    ),
  );
  temp.add(
    const DataColumn(
      label: Expanded(
        child: Text(
          'Delete',
          style: TextStyle(
            fontFamily: 'poppins',
          ),
        ),
      ),
    ),
  );
  return temp;
}

List<DataRow> generateRow(BuildContext c, var fetchRoutine) {
  List<DataRow> temp = [];

  if (activeClassPeriod == 0) {
    return [];
  }
  List<DataCell> tempCell = [];
  for (int k = 0; k < day.length; k++) {
    tempCell.add(DataCell(Text(
      day[k],
      style: const TextStyle(
        fontFamily: 'poppins',
      ),
    )));
    for (int i = 0; i < activeClassPeriod; i++) {
      tempCell.add(DataCell(
        Text(
          '${startTime[i]} - ${endTime[i]}\n${subjects[i]}\n${teachers[i]}',
          style: const TextStyle(
            fontFamily: 'poppins',
          ),
        ),
      ));
    }
  }
  tempCell.add(DataCell(
    const Icon(Icons.edit),
    onTap: () async {
      //TODO edit
    },
  ));
  tempCell.add(DataCell(
    const Icon(Icons.delete),
    onTap: () {
      //Todo remove
      RoutineOp.removeWeekDay(institutionName, activeClass, selectedDay)
          .then((value) {
        c.showSuccessBar(
            content: const Text(
          "Removed",
          style: TextStyle(color: Colors.green),
        ));
      });
      fetchRoutine(selectedDay);
    },
  ));

  temp.add(DataRow(cells: tempCell));
  return temp;
}
