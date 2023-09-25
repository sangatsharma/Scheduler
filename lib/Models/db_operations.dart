import 'package:scheduler/Models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  static Future<bool> instituionNameExists(String? name) async {
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
  static Future<bool> uploadCourse(String aid, String cname, String cid) async {
    CourseDetails courseDetails = CourseDetails(cid: cid, cname: cname);

    final docRef = db.collection(aid).doc("CourseDetails");

    // Append to the end of course_list
    return await docRef.set({
      'course_list': FieldValue.arrayUnion([courseDetails.toMap()])
    }, SetOptions(merge: true)).then((value) => true);
  }
}
