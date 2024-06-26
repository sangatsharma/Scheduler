import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scheduler/Screens/admin/admin_homepage.dart';
import 'package:scheduler/Screens/student/student_class_select.dart';
import 'package:scheduler/Widgets/login_users.dart';
import 'package:scheduler/Widgets/appbar_func.dart';
import 'package:scheduler/Models/db_operations.dart';

class GetInstitutionDetails extends StatefulWidget {
  const GetInstitutionDetails({super.key, required this.user});
  final User? user;
  static const String screen = 'GetInstitutionDetails';

  @override
  State<GetInstitutionDetails> createState() => _GetInstitutionDetailsState();
}

// A key helps uniquely identify a form and validate it.
final _formKey = GlobalKey<FormState>();
String institutionName = '';
String inviteCode = '';
bool isClicked = false;

class _GetInstitutionDetailsState extends State<GetInstitutionDetails> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: buildAppBar(context, 'Admin'),
          body: Center(
              child: SingleChildScrollView(
            child: Form(
              // We then associate the key to this Form
              key: _formKey,

              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.transparent,
                    child: Image(
                      image: AssetImage(
                        'Assets/images/logo.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Text(
                    'Your info?',
                    style: TextStyle(
                        fontFamily: 'poppins',
                        fontSize: 35,
                        fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(height: 40),
                  Column(
                    children: [
                      SizedBox(
                        height: 85,
                        child: TextFormField(
                          onChanged: (value) {
                            institutionName = value;
                          },
                          style: const TextStyle(
                            fontFamily: 'poppins',
                            fontSize: 18,
                          ),
                          decoration: const InputDecoration(
                            labelText: 'Institution Name',
                            labelStyle: TextStyle(fontFamily: 'poppins'),
                            prefixIcon: Icon(Icons.school),
                            constraints:
                                BoxConstraints(maxHeight: 25, maxWidth: 300),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),

                          //****  VALIDATION LOGIC ****//
                          validator: (value) {
                            // Make sure that input field is not Empty neither null
                            if (value == null || value.isEmpty) {
                              return 'Please name your Institution';
                            } else if (value.length < 6) {
                              return 'Name must be at least 6 character';
                            } else if (value.length > 25) {
                              return 'Name must be at most 25 character';
                            }
                            if (value == 'Pokhara') {
                              // todo check if institute already exist
                              return 'Institue with this name already exist';
                            }
                            // If everything is good, return null
                            return null;
                          },
                        ),
                      ),
                      ElevatedButton(
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(
                              Colors.pinkAccent),
                        ),
                        onPressed: () async {
                          if (institutionName.isEmpty) {
                            context.showErrorBar(
                                position: FlashPosition.top,
                                content: const Text('Empty fields not allowed',
                                    style: TextStyle(color: Colors.red)));
                            return;
                          }
                          // Check if institution Name already exists or not
                          if (await MappingCollectionOp.institutionNameExists(
                              institutionName)) {
                            if (context.mounted) {
                              context.showErrorBar(
                                  position: FlashPosition.top,
                                  content: const Text('Institution Name exists',
                                      style: TextStyle(color: Colors.red)));
                              return;
                            }
                          }
                          loginUser(_formKey);
                          if (loginUser(_formKey)) {
                            isClicked && context.mounted
                                ? context.showErrorBar(
                                    position: FlashPosition.top,
                                    content: const Text(
                                        'Code already generated',
                                        style: TextStyle(color: Colors.red)))
                                : setState(() {
                                    isClicked = true;
                                  });
                          }
                        },
                        child: const Text('Generate invite code'),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  SizedBox(height: 85, child: showCode(isClicked, context)),
                  GestureDetector(
                    onTap: () async {
                      loginUser(_formKey);
                      if (loginUser(_formKey) && isClicked == true) {
                        // Upload admin instituion detail to DB
                        bool mapping = await MappingCollectionOp.uploadMapping(
                            widget.user!.uid,
                            widget.user?.email ?? "",
                            institutionName,
                            inviteCode);
                        try {
                          await InstituteCollection.create(institutionName);
                        } catch (e) {
                          if (context.mounted) {
                            context.showErrorBar(
                                content: const Text(
                              "Error! Something went wrong",
                              style: TextStyle(color: Colors.red),
                            ));
                          }
                        }

                        if (mapping == true && context.mounted) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AdminHomepage(
                                        user: widget.user,
                                      )));
                        }
                      } else if (loginUser(_formKey) && isClicked == false) {
                        context.showErrorBar(
                            position: FlashPosition.top,
                            content: const Text('Generate code first',
                                style: TextStyle(color: Colors.red)));
                      }
                    },
                    child: Container(
                      height: 45,
                      width: 70,
                      margin: const EdgeInsets.only(top: 10),
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
                ],
              ),
            ),
          ))),
    );
  }
}

Widget showCode(bool isClicked, BuildContext context) {
  if (isClicked == true) {
    return TextFormField(
      readOnly: true,
      initialValue: getUniqueCode(),
      style: const TextStyle(
        fontFamily: 'poppins',
        fontSize: 18,
      ),
      decoration: InputDecoration(
        labelStyle: const TextStyle(fontFamily: 'poppins'),
        labelText: 'Invite Code',
        prefixIcon: const Icon(Icons.key),
        suffixIcon: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            child: const Icon(
              Icons.copy,
            ),
            onTap: () async {
              await Clipboard.setData(ClipboardData(text: inviteCode));
              context.showSuccessBar(
                  position: FlashPosition.top,
                  content: const Text('Code copied to clipboard!',
                      style: TextStyle(color: Colors.green)));
            },
          ),
        ),
        constraints: const BoxConstraints(maxHeight: 60, maxWidth: 300),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );
  } else {
    return const SizedBox();
  }
}

String getUniqueCode() {
  DateTime now = DateTime.now();
  String tempCode = institutionName[2] +
      institutionName[4] +
      now.second.toString() +
      institutionName[2] +
      now.hour.toString() +
      institutionName[0] +
      now.minute.toString();
  inviteCode = tempCode.replaceAll(' ', '');
  print(inviteCode);
  return inviteCode;
}
