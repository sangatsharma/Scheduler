import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:scheduler/Models/db_operations.dart';
import 'package:scheduler/Screens/admin/course_details_entry.dart';
import 'package:scheduler/Screens/admin/getAdmin_institution.dart';
import 'package:scheduler/Screens/admin/teacher_details_entry.dart';
import '../Screens/select_actor.dart';
import 'login_users.dart';

class CourseDetailsEditBox extends StatefulWidget {
  final int index;
  final String selectedCourseId;
  final String selectedCourseName;
  const CourseDetailsEditBox(
      {super.key,
      required this.index,
      required this.selectedCourseId,
      required this.selectedCourseName});

  @override
  State<CourseDetailsEditBox> createState() => _CourseDetailsEditBoxState();
}

class _CourseDetailsEditBoxState extends State<CourseDetailsEditBox> {
  final _formKey = GlobalKey<FormState>();
  String editedId = '';
  String editedCourse = '';
  @override
  void initState() {
    super.initState();
    editedId = widget.selectedCourseId;
    editedCourse = widget.selectedCourseName;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text('Edit Course Details:${widget.index}'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          Form(
            key: _formKey,
            child: Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width * 0.15,
                    child: TextFormField(
                      initialValue: widget.selectedCourseId,
                      onChanged: (value) {
                        editedId = value;
                      },
                      style: TextStyle(
                        fontFamily: 'poppins',
                        fontSize: width * 0.015,
                      ),
                      decoration: InputDecoration(
                        labelStyle: const TextStyle(
                          fontFamily: 'poppins',
                          color: Colors.black,
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
                        final RegExp pattern =
                            RegExp(r'^[A-Za-z][A-Za-z0-9 +\-]*$');

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
                      initialValue: widget.selectedCourseName,
                      onChanged: (value) {
                        setState(() {
                          editedCourse = value;
                        });
                      },
                      style: TextStyle(
                        fontFamily: 'poppins',
                        fontSize: width * 0.015,
                      ),
                      decoration: InputDecoration(
                        labelStyle: const TextStyle(
                          fontFamily: 'poppins',
                          color: Colors.black,
                        ),
                        labelText: 'Course name',
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
                            RegExp(r'^[A-Za-z][A-Za-z0-9 +\-]*$');

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
                      onPressed: () async {
                        loginUser(_formKey);
                        if (loginUser(_formKey)) {
                          //todo add this to collection
                          if (editedId == widget.selectedCourseId &&
                              editedCourse == widget.selectedCourseName) {
                            context.showInfoBar(
                              position: FlashPosition.top,
                              content: const Text(
                                "No changes made.",
                                style: TextStyle(
                                    fontFamily: 'poppins', color: Colors.black),
                              ),
                            );
                          }
                          else if (await CourseCollectionOp.updateCourse(
                              institutionName,
                              widget.selectedCourseId,
                              editedId,
                              editedCourse)) {
                            if (context.mounted) {
                              context.showSuccessBar(
                                content: const Text(
                                  "Edited successfully.",
                                  style: TextStyle(color: Colors.green),
                                ),
                              );
                            setState(() {
                              courseDetails?.removeAt(widget.index);
                              courseDetails?.insert(widget.index, {
                                "course_id": editedId,
                                "course_name": editedCourse,
                              });
                            });
                            }
                          }
                          if(context.mounted) {
                            Navigator.of(context).pop();
                          }
                        }
                      },
                      child: SizedBox(
                        height: height * 0.05,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Edit',
                              style: TextStyle(
                                fontFamily: 'poppins',
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.edit,
                              size: 18,
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
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
