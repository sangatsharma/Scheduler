//    MappingCollection(collection)
//                 | 
//                 | [doc name = admin_id]
//                 |
//    --------------------------(data)
//    |             |          |
//    |             |          |
//  admin_name   ins-name     code

class MappingCollection {
  final String aname;
  final String iname;
  final String code;

  MappingCollection({
      required this.aname,
      required this.iname, 
      required this.code
    });

  Map<String, dynamic> toMap() {
    return {
      'admin_name': aname,
      'institution_name': iname,
      'code': code,
    };
  }
}

class CourseDetails {
  final String cid;
  final String cname;

  CourseDetails({
    required this.cid,
    required this.cname
  });

  Map<String, dynamic> toMap(){
    return {
      'course_id': cid,
      'course_name': cname,
    };
  }
}