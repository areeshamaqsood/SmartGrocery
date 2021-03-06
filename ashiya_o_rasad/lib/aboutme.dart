// import '../flutter_flow/flutter_flow_theme.dart';
// import '../flutter_flow/flutter_flow_util.dart';
// import '../flutter_flow/flutter_flow_widgets.dart';
// import 'package:ashiya_o_rasad/account.dart';
import 'package:ashiya_o_rasad/bottomnav.dart';
import '../variables.dart';
// import '../main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AboutMeWidget extends StatefulWidget {
  const AboutMeWidget({Key key}) : super(key: key);

  @override
  _AboutMeWidgetState createState() => _AboutMeWidgetState();
}

class _AboutMeWidgetState extends State<AboutMeWidget> {
  TextEditingController textController1;
  TextEditingController textController2;
  TextEditingController textController3;
  bool passwordVisibility;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final CollectionReference users =
      FirebaseFirestore.instance.collection('Users');
  // static int added;

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController(text: Account.name1);
    textController2 = TextEditingController(text: Account.email1);
    textController3 = TextEditingController(text: Account.pass1);
    passwordVisibility = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainScreen()),
            );
          },
          child: Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
            size: 24,
          ),
        ),
        title: Text(
          'About Me',
          style: GoogleFonts.poppins(
            fontSize: 18.0,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 2,
      ),
      backgroundColor: Color(0xFFF1F4F8),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15, 20, 0, 10),
              child: Text(
                'Personal Details',
                style: GoogleFonts.poppins(
                  fontSize: 15.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 1, 0, 0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.345,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 20),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: textController1,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Your Name',
                                  labelStyle: GoogleFonts.poppins(
                                    fontSize: 14.0,
                                    color: Color(0xFF090F13),
                                    fontWeight: FontWeight.normal,
                                  ),
                                  hintText: 'What do people call you...?',
                                  hintStyle: GoogleFonts.poppins(
                                    fontSize: 14.0,
                                    color: Color(0xFF8B97A2),
                                    fontWeight: FontWeight.normal,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFDBE2E7),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFDBE2E7),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                style: GoogleFonts.poppins(
                                  fontSize: 14.0,
                                  color: Color(0xFF090F13),
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: textController2,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Email Address',
                                  labelStyle: GoogleFonts.poppins(
                                    fontSize: 14.0,
                                    color: Color(0xFF090F13),
                                    fontWeight: FontWeight.normal,
                                  ),
                                  hintText: 'Enter a new email',
                                  hintStyle: GoogleFonts.poppins(
                                    fontSize: 14.0,
                                    color: Color(0xFF8B97A2),
                                    fontWeight: FontWeight.normal,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFDBE2E7),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFDBE2E7),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                style: GoogleFonts.poppins(
                                  fontSize: 14.0,
                                  color: Color(0xFF090F13),
                                  fontWeight: FontWeight.normal,
                                ),
                                keyboardType: TextInputType.emailAddress,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: textController3,
                                obscureText: !passwordVisibility,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: GoogleFonts.poppins(
                                    fontSize: 14.0,
                                    color: Color(0xFF090F13),
                                    fontWeight: FontWeight.normal,
                                  ),
                                  hintText: 'Enter a new password',
                                  hintStyle: GoogleFonts.poppins(
                                    fontSize: 14.0,
                                    color: Color(0xFF8B97A2),
                                    fontWeight: FontWeight.normal,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFDBE2E7),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFDBE2E7),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  suffixIcon: InkWell(
                                    onTap: () => setState(
                                      () => passwordVisibility =
                                          !passwordVisibility,
                                    ),
                                    child: Icon(
                                      passwordVisibility
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      size: 25,
                                    ),
                                  ),
                                ),
                                style: GoogleFonts.poppins(
                                  fontSize: 14.0,
                                  color: Color(0xFF090F13),
                                  fontWeight: FontWeight.normal,
                                ),
                                keyboardType: TextInputType.visiblePassword,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      Account.name1 = textController1.text;
                      Account.email1 = textController2.text;
                      Account.pass1 = textController3.text;
                      await users
                          .doc('$Account.email1')
                          .update(
                            {
                              'name': '${Account.name1}',
                              'email': '${Account.email1}',
                              'password': '${Account.pass1}'
                            },
                          )
                          .then((value) => print("User Updated"))
                          .catchError((error) =>
                              print("Failed to update user: $error"));
                      SnackMessage(context, 'Changes saved');
                    },
                    child: Text('Save Changes',
                        style: GoogleFonts.poppins(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(350, 60),
                        primary: Color(0xFF28b446)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
