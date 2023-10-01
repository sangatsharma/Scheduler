import 'package:flash/flash_helper.dart';
import 'package:flutter/rendering.dart';
import 'package:scheduler/Models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scheduler/Screens/admin/teacher_details_entry.dart';

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
  static Future<List<String>> fetchCourse(String iname) async {
    final res = await db.collection(iname).doc("CourseDetails").get();
    final t = res.data()?["course_list"].map((e) => e["course_name"]);
    return List.from(t);
  }

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
  
  static Future<List<dynamic>> getClasses(String iname) async{
    final docRef = await db.collection(iname).doc("Routine").get();
    List<dynamic> res = docRef.data()?["class_name"]??[];
    return res;
  }

  static String weekDay(String w) {
    if (w == "Sunday")
      return "7";
    else if (w == "Monday")
      return "1";
    else if (w == "Tuesday")
      return "2";
    else if (w == "Wednesday")
      return "3";
    else if (w == "Thrusday")
      return "4";
    else if (w == "Friday") return "5";
    return "6";
  }

  static Future<Map<String, Map<String, List<String>>>> fetchRoutine(
      String iname, String cn) async {
    final classColRef =
        await db.collection(iname).doc("Routine").collection(cn).get();

    Map<String, Map<String, List<String>>> res = {
      "7": {
        "starting_times": [],
        "ending_times": [],
        "teachers_name": [],
        "subjects": []
      },
      "1": {
        "starting_times": [],
        "ending_times": [],
        "teachers_name": [],
        "subjects": []
      },
      "2": {
        "starting_times": [],
        "ending_times": [],
        "teachers_name": [],
        "subjects": []
      },
      "3": {
        "starting_times": [],
        "ending_times": [],
        "teachers_name": [],
        "subjects": []
      },
      "4": {
        "starting_times": [],
        "ending_times": [],
        "teachers_name": [],
        "subjects": []
      },
      "5": {
        "starting_times": [],
        "ending_times": [],
        "teachers_name": [],
        "subjects": []
      },
      "6": {
        "starting_times": [],
        "ending_times": [],
        "teachers_name": [],
        "subjects": []
      },
    };

    for (var doc in classColRef.docs) {
      List<String> starting_time = [];
      List<String> ending_time = [];
      List<String> teachers_name = [];
      List<String> subjects = [];

      final a = doc.get("periods");
      for (var b in a) {
        starting_time.add(b["starting_time"]);
        ending_time.add(b["ending_time"]);
        teachers_name.add(b["teacher_name"]);
        subjects.add(b["subject"]);
      }
      res[weekDay(doc.get("week_day"))]?["starting_times"]
          ?.addAll(starting_time);
      res[weekDay(doc.get("week_day"))]?["ending_times"]?.addAll(ending_time);
      res[weekDay(doc.get("week_day"))]?["teachers_name"]
          ?.addAll(teachers_name);
      res[weekDay(doc.get("week_day"))]?["subjects"]?.addAll(subjects);
    }
    return res;
  }

  static Future<bool> addClass(String iname, String cname) async {
    final docRef2 = db.collection(iname).doc("Routine");
    await docRef2.set({
      "class_name": FieldValue.arrayUnion([cname]),
    }, SetOptions(merge: true)).then((value) => true);

    return true;
  }

  static Future<bool> uploadRoutine(String iname, String cname, List<Map<String, dynamic>> data, String weekday) async{
    final docRef = db.collection(iname).doc("Routine").collection(cname).doc(weekday);

    for(var element in data){
      await docRef.set({
        'periods': FieldValue.arrayUnion([element]),
        'week_day': weekday,
      }, SetOptions(merge: true)).then((value) => true);
    }

    await addClass(iname, cname);

    return true;
  }

  static Future<bool> removeWeekDay(String iname, String cname, String weekday) async {
    final docRef = db.collection(iname).doc("Routine").collection(cname).doc(weekday);
    await docRef.delete();

    return true;
  }
}


class TeacherCollectionOp {
  static Future<bool> addTeacher(String iname, String tid, String tname, List<String> course) async{
    TeacherDetail td = TeacherDetail(tname: tname, subjects: course);

    final docRef = db.collection(iname).doc("Teachers");
    final docRef2 = db.collection(iname).doc("TeacherSubjectMapping");

    await docRef.set({
      tid: td.toMap(),
    }, SetOptions(merge: true)).then((value) => true);

    await docRef2.set({
      tid: {
        "teacher_name": tname,
        "subjects": [],
        "week_days": [],
        "starting_time": [],
        "ending_time": [],
        "class_name": []
      }
    });

    return true;
  }

  static Future<Map<String, dynamic>> fetchAllTeachers(String iname) async {
    final docRef = await db.collection(iname).doc("Teachers").get();
    final d = docRef.data()??{};
    return d;
  }

  static Future<bool> updateTeacher(String iname, Map<String, dynamic> t) async {
    final docs = await db.collection(iname).doc("Teachers").get();
    Map<String, dynamic> res = {};

    // docs.data()?.forEach((key, value) {
    //   if (key == tid) {
    //     res[tid] = {
    //       "teacher_name": tname,
    //       "subjects": subs,
    //     };
    //   }
    //   else {
    //     res[key] = value;
    //   }
    // });
    
    await db.collection(iname).doc("Teachers").set(t);
    return true;
  }

  static Future<bool> removeTeacher(String? aid, String cid) async {
    if (aid == null) {
      return false;
    }
    final docRef = await db.collection(aid).doc("Teachers").get();
    Map<String, dynamic> dataRef = docRef.data()??{};

    dataRef.remove(cid);

    await db.collection(aid).doc("Teachers").set(dataRef);
    return true;
  }

  static Future<Map<String, dynamic>> teacherHomepage(String aid, String tid, String cname) async {
    final docRef = await db.collection(aid).doc("TeacherSubjectMapping").get();
    Map<String, dynamic> res = {
      "teacher_id": "",
      "starting_time": [],
      "ending_time": [],
      "class_name": [],
      "subject_name": [],
      "week_days": []
    };

    docRef.data()?.forEach((key, value) {
      res["teacher_id"] = key;
      res["teacher_name"] = value["teacher_name"];

      for(var i = 0; i < value["starting_time"].length; i++) {
        res["starting_time"].add(value["starting_time"][i]);
        res["ending_time"].add(value["ending_time"][i]);
        res["class_name"].add(value["class_name"][i]);
        res["subject_name"].add(value["subjects"][i]);
        res["week_days"].add(value["week_days"][i]);
      }
    });
    return res;
  }


  static Future<Map<String, Map<String, List<String>>>> fetchRoutine(
      String cn, String tid) async {
    final classColRef =
        await db.collection("demo-admin").doc("Routine").collection(cn).get();

    Map<String, Map<String, List<String>>> res = {
      "7": {
        "starting_times": [],
        "ending_times": [],
        "subjects": []
      },
      "1": {
        "starting_times": [],
        "ending_times": [],
        "subjects": []
      },
      "2": {
        "starting_times": [],
        "ending_times": [],
        "subjects": []
      },
      "3": {
        "starting_times": [],
        "ending_times": [],
        "subjects": []
      },
      "4": {
        "starting_times": [],
        "ending_times": [],
        "subjects": []
      },
      "5": {
        "starting_times": [],
        "ending_times": [],
        "subjects": []
      },
      "6": {
        "starting_times": [],
        "ending_times": [],
        "subjects": []
      },
    };

    for (var doc in classColRef.docs) {
      List<String> starting_time = [];
      List<String> ending_time = [];
      List<String> subjects = [];

      final a = doc.get("periods");
      for (var b in a) {
        if(b["teacher_name"] == tid) {
          starting_time.add(b["starting_time"]);
          ending_time.add(b["ending_time"]);
          subjects.add(b["subject"]);
        }
      }
      res[RoutineOp.weekDay(doc.get("week_day"))]?["starting_times"]
          ?.addAll(starting_time);
      res[RoutineOp.weekDay(doc.get("week_day"))]?["ending_times"]?.addAll(ending_time);
      res[RoutineOp.weekDay(doc.get("week_day"))]?["subjects"]?.addAll(subjects);
    }
    print(res);
    return res;
  }
}