import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../Auth/auth_service.dart';
import '../../Widgets/login_users.dart';
import '../../Widgets/shared_prefs.dart';
import '../../Widgets/themes.dart';
import 'package:scheduler/Screens/select_actor.dart';
import 'getAdmin_institution.dart';

class CourseDetailsEntry extends StatefulWidget {
  const CourseDetailsEntry({Key? key}) : super(key: key);

  static const String screen = 'CourseDetailsEntry';
  @override
  State<CourseDetailsEntry> createState() => _CourseDetailsEntryState();
}

String courseId = '';
String courseName = '';
int i = 1;

class _CourseDetailsEntryState extends State<CourseDetailsEntry> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  margin: const EdgeInsets.only(
                      bottom: 5, left: 5, right: 5, top: 5),
                  decoration: BoxDecoration(
                      color:
                          isLightMode ? const Color(0xff9DB2FD) : Colors.black,
                      borderRadius: const BorderRadius.all(Radius.circular(8))),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              child: Text('Enter Course Details :',
                                  style: TextStyle(
                                    fontFamily: 'poppins',
                                    fontSize: 15,
                                    color: isLightMode
                                        ? Colors.black
                                        : Colors.white,
                                  )),
                            ),
                            const SizedBox(height: 10),
                            Form(
                              key: _formKey,
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 40),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: width * 0.15,
                                      child: TextFormField(
                                        onChanged: (value) {
                                          courseId = value;
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
                                          errorStyle: TextStyle(
                                              fontSize: width * 0.018),
                                          border: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                        ),

                                        //****  VALIDATION LOGIC ****//
                                        validator: (value) {
                                          final RegExp pattern = RegExp(
                                              r'^[A-Za-z][A-Za-z0-9 +\-]*$');

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
                                      width: width * 0.18,
                                      child: TextFormField(
                                        onChanged: (value) {
                                          setState(() {
                                            courseName = value;
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
                                          labelText: 'Course name',
                                          errorStyle: TextStyle(
                                              fontSize: width * 0.018),
                                          border: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                        ),

                                        //****  VALIDATION LOGIC ****//
                                        validator: (value) {
                                          final RegExp pattern = RegExp(
                                              r'^[A-Za-z][A-Za-z0-9 +\-]*$');

                                          // Make sure that input field is not Empty neither null
                                          if (value == null || value.isEmpty) {
                                            return 'Course name ?';
                                          } else if (!pattern.hasMatch(value)) {
                                            return 'Invalid course name';
                                          }
                                          // If everything is good, return null
                                          return null;
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: width * 0.02,
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          loginUser(_formKey);
                                          if (loginUser(_formKey)) {
                                            //todo add this to collection
                                            print(courseName);
                                            print(courseId);
                                            //Clear all the input field
                                            _formKey.currentState?.reset();
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
                            ),
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(right: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Course Details',
                                      style: TextStyle(
                                          fontFamily: 'poppins',
                                          color: isLightMode
                                              ? Colors.black
                                              : Colors.white)),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color:
                                  isLightMode ? Colors.black26 : Colors.white,
                              thickness: 2,
                            ),
                            Column(
                              children: [
                                DataTable(
                                  showCheckboxColumn: true,
                                  columns: const <DataColumn>[
                                    DataColumn(
                                      label: Expanded(
                                        child: Text(
                                          'S.N.',
                                          style: TextStyle(
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Expanded(
                                        child: Text(
                                          'Course Id',
                                          style: TextStyle(
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Expanded(
                                        child: Text(
                                          'Course Name',
                                          style: TextStyle(
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.bold),
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
                                  rows: <DataRow>[
                                    DataRow(
                                      cells: <DataCell>[
                                        DataCell(Text('${i++}')),
                                        DataCell(Text('Mth112')),
                                        DataCell(Text('Engineering Maths I')),
                                        DataCell(
                                          Icon(Icons.edit),
                                          onTap: () {},
                                        ),
                                        DataCell(
                                          Icon(Icons.delete),
                                          onTap: () {},
                                        ),
                                      ],
                                    ),
                                    DataRow(
                                      cells: <DataCell>[
                                        DataCell(Text('${i++}')),
                                        DataCell(Text('Cmp 221')),
                                        DataCell(Text('Computer Graphics')),
                                        DataCell(
                                          Icon(Icons.edit),
                                          onTap: () {},
                                        ),
                                        DataCell(
                                          Icon(Icons.delete),
                                          onTap: () {},
                                        ),
                                      ],
                                    ),
                                    DataRow(
                                      cells: <DataCell>[
                                        DataCell(Text('${i++}')),
                                        DataCell(Text('Dbm 331')),
                                        DataCell(
                                            Text('Database Management System')),
                                        DataCell(
                                          Icon(Icons.edit),
                                          onTap: () {},
                                        ),
                                        DataCell(
                                          Icon(Icons.delete),
                                          onTap: () {},
                                        ),
                                      ],
                                    ),
                                  ],
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
            ]),
          ),
        ),
      ),
    );
  }
}
