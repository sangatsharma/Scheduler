import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../Auth/auth_service.dart';
import '../../Widgets/login_users.dart';
import '../../Widgets/shared_prefs.dart';
import '../../Widgets/themes.dart';
import 'package:scheduler/Screens/select_actor.dart';
import 'getAdmin_institution.dart';

class TeacherDetailsEntry extends StatefulWidget {
  const TeacherDetailsEntry({Key? key}) : super(key: key);
  // final User? user;

  static const String screen = 'TeacherDetailsEntry';
  @override
  State<TeacherDetailsEntry> createState() => _TeacherDetailsEntryState();
}

String teacherId = '';
String teacherName = '';
int teacherSubjNo = 1;
List<String> subject = ['-', '-', '-', '-'];

class _TeacherDetailsEntryState extends State<TeacherDetailsEntry> {
  final _formKey = GlobalKey<FormState>();
  Future<bool> showExitPopup() async {
    return await showDialog(
          barrierColor: Colors.transparent.withOpacity(0.6),
          //show confirm dialogue
          //the return value will be from "Yes" or "No" options
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor:
                isLightMode ? const Color(0xffC0FFFF) : Colors.blueAccent,
            title: Text(
              'Exit Scheduler ?',
              style: TextStyle(
                  color: isLightMode ? Colors.black : Colors.white,
                  fontSize: 20,
                  fontFamily: 'poppins'),
            ),
            content: Text(
              'Are you sure you want to exit?',
              style: TextStyle(
                  color: isLightMode ? Colors.black : Colors.white,
                  fontSize: 15,
                  fontFamily: 'poppins'),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(
                            isLightMode
                                ? const Color(0xffB1B2FF)
                                : Colors.pinkAccent),
                        foregroundColor: MaterialStatePropertyAll<Color>(
                            isLightMode ? Colors.black : Colors.white)),
                    onPressed: () => Navigator.of(context).pop(),
                    //return true when click on "Yes"
                    child: const Text('Yes'),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(
                            isLightMode
                                ? const Color(0xffB1B2FF)
                                : Colors.pinkAccent),
                        foregroundColor: MaterialStatePropertyAll<Color>(
                            isLightMode ? Colors.black : Colors.white)),
                    onPressed: () => Navigator.of(context).pop(false),
                    //return false when click on "NO"
                    child: const Text('No'),
                  ),
                ],
              ),
            ],
          ),
        ) ??
        false; //if showDialog had returned null, then return false
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> generateSubjectField(int num, double width) {
      List<Widget> inputFieldList = [];
      for (int i = 2; i <= (num < 5 ? num : 4); i++) {
        Row t = Row(
          children: [
            SizedBox(
              width: width * 0.02,
            ),
            SizedBox(
              width: width * 0.16,
              child: TextFormField(
                onChanged: (value) {
                  subject[i - 1] = value;
                  setState(() {});
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
                  labelText: 'Subject $i',
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
            )
          ],
        );
        inputFieldList.add(t);
      }
      return inputFieldList;
    }

    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: showExitPopup,
      child: MaterialApp(
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
                              bool success =
                                  await Authenticate.signOut(context: context);
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
                    ])),
            body: Container(
              color: isLightMode ? Colors.white : Colors.black12,
              child: Column(children: [
                Container(
                  decoration: BoxDecoration(
                      color:
                          isLightMode ? const Color(0xffB1B2FF) : Colors.black,
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
                                  maxLines: 4,
                                  maxFontSize: 25,
                                  minFontSize: 15,
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
                        color: isLightMode
                            ? const Color(0xff9DB2FD)
                            : Colors.black,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8))),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: Text('Enter Details :',
                                style: TextStyle(
                                  fontFamily: 'poppins',
                                  fontSize: 15,
                                  color:
                                      isLightMode ? Colors.black : Colors.white,
                                )),
                          ),
                          const SizedBox(height: 10),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Form(
                              key: _formKey,
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 40),
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: width * 0.15,
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
                                          labelText: 'Teacher Id',
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
                                        });
                                      },
                                      items: <int>[1, 2, 3, 4].map((int value) {
                                        return DropdownMenuItem<int>(
                                          value: value,
                                          child: Text(value.toString()),
                                        );
                                      }).toList(),
                                    ),
                                    SizedBox(
                                      width: width * 0.02,
                                    ),
                                    SizedBox(
                                      width: width * 0.16,
                                      child: TextFormField(
                                        onChanged: (value) {
                                          subject[0] = value;
                                          setState(() {});
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
                                          labelText: 'Subject 1',
                                          errorStyle: TextStyle(
                                              fontSize: width * 0.018),
                                          border: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                        ),

                                        // ****  VALIDATION LOGIC ****//
                                        validator: (value) {
                                          final RegExp pattern = RegExp(
                                              r'^[A-Za-z][A-Za-z0-9 +\-]*$');

                                          // Make sure that input field is not Empty neither null
                                          if (value == null || value.isEmpty) {
                                            return 'Subject ?';
                                          } else if (!pattern.hasMatch(value)) {
                                            return 'Invalid Subject';
                                          }
                                          // If everything is good, return null
                                          return null;
                                        },
                                      ),
                                    ),
                                    Row(
                                      children: generateSubjectField(
                                          teacherSubjNo, width),
                                    ),
                                    SizedBox(
                                      width: width * 0.02,
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          loginUser(_formKey);
                                          if (loginUser(_formKey)) {
                                            //todo add this to collection
                                            print(teacherId);
                                            print(teacherName);
                                            print(teacherSubjNo);
                                            print(subject);
                                          }
                                        },
                                        child: const Text('Add')),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Teacher Details',
                                    style: TextStyle(
                                        fontFamily: 'poppins',
                                        fontSize: width * 0.03,
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
                            color: isLightMode ? Colors.black26 : Colors.white,
                            thickness: 2,
                          ),
                          DataTable(
                            showCheckboxColumn: true,
                            columns: const <DataColumn>[
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    'Name',
                                    style: TextStyle(
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    'Age',
                                    style:
                                        TextStyle(fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    'Edit',
                                    style:
                                        TextStyle(fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    'Delete',
                                    style:
                                        TextStyle(fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ),
                            ],
                            rows: <DataRow>[
                              DataRow(
                                cells: <DataCell>[
                                  DataCell(Text('Sarah')),
                                  DataCell(Text('19')),
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
                                  DataCell(Text('Janine')),
                                  DataCell(Text('43')),
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
                                  DataCell(Text('William')),
                                  DataCell(Text('27')),
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
                    ),
                  ),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
