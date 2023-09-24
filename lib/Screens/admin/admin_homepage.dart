import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../Auth/auth_service.dart';
import '../../Widgets/shared_prefs.dart';
import '../../Widgets/themes.dart';
import 'package:scheduler/Screens/select_actor.dart';
import 'getAdmin_institution.dart';

class AdminHomepage extends StatefulWidget {
  const AdminHomepage({super.key, required this.user});
  final User? user;

  static const String screen = 'AdminHomepage';
  @override
  State<AdminHomepage> createState() => _AdminHomepageState();
}

class _AdminHomepageState extends State<AdminHomepage> {
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
                    onPressed: () => exit(0),
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
    var photoUrl = widget.user?.photoURL ??
        'https://upload.wikimedia.org/wikipedia/commons/f/f7/Facebook_default_male_avatar.gif';
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
                    isLightMode ? const Color(0xffB1B2FF) : Colors.transparent,
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
              color: isLightMode ? Colors.white : Colors.transparent,
              child: Column(children: [
                Container(
                  decoration: BoxDecoration(
                      color: isLightMode
                          ? const Color(0xffB1B2FF)
                          : Colors.transparent,
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
                              Container(
                                margin: const EdgeInsets.only(right: 20),
                                child: Row(
                                  children: [
                                    MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        child: const Icon(
                                          Icons.copy,
                                          size: 20,
                                        ),
                                        onTap: () async {
                                          await Clipboard.setData(
                                              ClipboardData(text: inviteCode));
                                          context.showSuccessBar(
                                              position: FlashPosition.top,
                                              content: const Text(
                                                  'Code copied to clipboard!',
                                                  style: TextStyle(
                                                      color: Colors.green)));
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(inviteCode,
                                        style: TextStyle(
                                            fontFamily: 'poppins',
                                            fontSize: 15,
                                            color: isLightMode
                                                ? Colors.black
                                                : Colors.white))
                                  ],
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
                    padding: const EdgeInsets.all(20),
                    width: double.infinity,
                    margin: const EdgeInsets.only(
                        bottom: 10, left: 5, right: 5, top: 5),
                    decoration: BoxDecoration(
                        color: isLightMode
                            ? const Color(0xff9DB2BF)
                            : Colors.black,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(isLightMode
                                        ? const Color(0xffB1B2FF)
                                        : Colors.pinkAccent),
                                foregroundColor:
                                    MaterialStatePropertyAll<Color>(isLightMode
                                        ? Colors.black
                                        : Colors.white)),
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const AutoSizeText(
                              textAlign: TextAlign.left,
                              maxLines: 4,
                              minFontSize: 20,
                              overflowReplacement: Text(
                                'Manage Teacher Details',
                              ),
                              'Manage Teacher Details',
                              style: TextStyle(fontFamily: 'poppins'),
                            ),
                            //return false when click on "NO"
                            // child: Text(
                            //   'Manage Teacher Details',
                            //   style: TextStyle(
                            //       color:
                            //           isLightMode ? Colors.black : Colors.white,
                            //       fontSize: 25,
                            //       fontFamily: 'poppins'),
                            // ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(isLightMode
                                        ? const Color(0xffB1B2FF)
                                        : Colors.pinkAccent),
                                foregroundColor:
                                    MaterialStatePropertyAll<Color>(isLightMode
                                        ? Colors.black
                                        : Colors.white)),
                            onPressed: () => Navigator.of(context).pop(false),
                            //return false when click on "NO"
                            child: Text(
                              'Manage Routines',
                              style: TextStyle(
                                  color:
                                      isLightMode ? Colors.black : Colors.white,
                                  fontSize: 25,
                                  fontFamily: 'poppins'),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: Image.network(photoUrl),
                        )
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
