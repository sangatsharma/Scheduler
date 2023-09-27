import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:scheduler/Models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scheduler/Screens/student/databaseFetch_student.dart';
import 'package:scheduler/tmp/db_schema.dart';

final db = FirebaseFirestore.instance;

class MappingCollectionOp {
  // USAGE: <true/false> MappingCollectionOp.uploadMapping(...);
  static Future<bool> uploadMapping(
      String aid, String aname, String iname, String code) async {
    MappingCollection newCollection =
        MappingCollection(aname: aname, iname: iname, code: code);

    final m1Map = newCollection.toMap();
    final docRef = db.collection("mapping-collection").doc(aid);

    return await docRef.set(m1Map).then((value) => true, onError: (e) => false);
  }

  // USAGE: <MAP/null> MappingCollectionOp.fetchMapping(...);
  static Future<Map<String, dynamic>?> fetchMapping(String? aid) async {
    final docRef = await db.collection("mapping-collection").doc(aid).get();
    if (docRef.exists) {
      return docRef.data();
    }
    return null;
  }

  static Future<bool> institutionNameExists(String? name) async {
    final docRef = await db
        .collection("mapping-collection")
        .where("institution_name", isEqualTo: name)
        .get();
    return docRef.docs.isNotEmpty;
  }

  static Future<bool> institutionCodeExists(String? code) async {
    final docRef = await db
        .collection("mapping-collection")
        .where("code", isEqualTo: code)
        .get();
    return docRef.docs.isNotEmpty;
  }
}

class CourseCollectionOp {
  static Future<bool> uploadCourse(
      String? aid, String cname, String cid) async {
    CourseDetails courseDetails = CourseDetails(cid: cid, cname: cname);
    if (aid == null) {
      return false;
    }
    final docRef = db.collection(aid).doc("CourseDetails");

    // Append to the end of course_list
    return await docRef.set({
      'course_list': FieldValue.arrayUnion([courseDetails.toMap()])
    }, SetOptions(merge: true)).then((value) => true);
  }

  // Remove a course
  static Future<bool> removeCourse(String? aid, String cid) async {
    if (aid == null) {
      return false;
    }
    final docRef = db.collection(aid).doc("CourseDetails");
    final dataRef = await docRef.get();
    var data = [];

    dataRef.data()?["course_list"].forEach((value) {
      if (value["course_id"] != cid) {
        data.add(value);
      }
    });

    await docRef.set({
      'course_list': data,
    });
    return true;
  }

  // Update a course
  static Future<bool> updateCourse(
      String? aid, String cid, String ncid, String ncname) async {
    if (aid == null) {
      return false;
    }
    final docRef = db.collection(aid).doc("CourseDetails");
    final dataRef = await docRef.get();
    var data = [];

    dataRef.data()?["course_list"].forEach((value) {
      if (value["course_id"] != cid) {
        data.add(value);
      } else {
        data.add({
          "course_id": ncid,
          "course_name": ncname,
        });
      }
    });

    await docRef.set({
      'course_list': data,
    });
    return true;
  }
}

class InstituteCollection {
  static Future<bool> create(String name) async {
    await db.collection(name).get();
    return true;
  }

  static Future<Map<String, dynamic>?> getCourseDetails(String iname) async {
    final docRef = await db.collection(iname).doc("CourseDetails").get();
    return docRef.data();
  }
}

class RoutineOp {
  static int _weekDay(String w) {
    if (w == "Sunday")
      return 0;
    else if (w == "Monday")
      return 1;
    else if (w == "Tuesday")
      return 2;
    else if (w == "Wednesday")
      return 3;
    else if (w == "Thrusday")
      return 4;
    else if (w == "Friday") return 5;
    return 6;
  }

  static Future<Map<String, dynamic>> fetchRoutine() async {
    final classColRef = await db
        .collection("demo-admin")
        .doc("Routine")
        .collection("BSE-4th")
        .get();

    Map<String, List<dynamic>> res = {
      "starting_times": [],
      "ending_times": [],
      "teachers_name": [],
      "subjects": []
    };

    for (var doc in classColRef.docs) {
      List<String> starting_time = [];
      List<String> ending_time = [];
      List<String> teachers_name = [];
      List<String> subjects = [];

      final a = doc.get("periods");
      for (var b in a) {
        print(b);
        starting_time.add(b["starting_time"]);
        ending_time.add(b["ending_time"]);
        teachers_name.add(b["teacher_name"]);
        subjects.add(b["subject"]);
      }
      res["starting_times"]?.add({_weekDay(doc.get("week_day")): starting_time});
      res["ending_times"]?.add({_weekDay(doc.get("week_day")): starting_time});
      res["teachers_name"]?.add({_weekDay(doc.get("week_day")): starting_time});
      res["subjects"]?.add({_weekDay(doc.get("week_day")): starting_time});
    }
    return res;
  }
}
