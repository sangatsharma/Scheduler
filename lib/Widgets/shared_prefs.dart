//shared preferences for themeMode data
import 'package:shared_preferences/shared_preferences.dart';

//function to set theme
void setThemeMode(bool themeMode) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('isLightModeSaved', themeMode);
}

//Returns bool for the saved value of theme mode
Future<bool?> selectedThemeMode() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isLightModeSaved') ?? true;
}

bool isStudentLogin = false;
bool isTeacherLogin = false;
//function to set theme
void setStudentLoginStatus(bool isLoggedIn) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('isStudentLoggedIn', isLoggedIn);
}

void setStudentClassName(String className) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('studentClass', className);
}

void setTeacherName(String teacherName) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('teacherName', teacherName);
}

void setTeacherLoginStatus(bool isLoggedIn) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('isTeacherLoggedIn', isLoggedIn);
}

//Returns bool for the saved value of theme mode
Future<bool?> checkStudentLogInStatus() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  bool check = prefs.getBool('isStudentLoggedIn') ?? false;
  return check;
}

Future<bool?> checkTeacherLogInStatus() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  bool check = prefs.getBool('isTeacherLoggedIn') ?? false;
  return check;
}
