import '../auth/auth_util.dart';
// import '../flutter_flow/flutter_flow_theme.dart';
// import '../flutter_flow/flutter_flow_util.dart';
// import '../flutter_flow/flutter_flow_widgets.dart';
import '../login.dart';
import '../main.dart';
import '../bottomnav.dart';
import '../Welcome.dart';
import '../home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  TextEditingController emailAddressController1;
  TextEditingController emailAddressController2;
  TextEditingController passwordController;
  bool passwordVisibility;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    emailAddressController1 = TextEditingController();
    emailAddressController2 = TextEditingController();
    passwordController = TextEditingController();
    passwordVisibility = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFF262D34),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 1,
            decoration: BoxDecoration(
              color: Color(0xFF262D34),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: Image.asset(
                  'assets/images/signup.jpg',
                ).image,
              ),
            ),
            child: Align(
              alignment: AlignmentDirectional(0, 1),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: const Color(0xFFf4f5f9),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 8,
                          color: Color(0x66000000),
                          offset: Offset(0, -4),
                        )
                      ],
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Text(
                                  'Login',
                                  style: GoogleFonts.poppins(
                                    fontSize: 24.0,
                                    color: Color(0xFF090F13),
                                    fontWeight: FontWeight.bold,
                                  ),

                                  // style: FlutterFlowTheme.title1.override(
                                  //   fontFamily: 'Poppins',
                                  //   color: Color(0xFF090F13),
                                  //   fontSize: 24,
                                  //   fontWeight: FontWeight.bold,
                                  // ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(20, 16, 20, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: emailAddressController2,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Your Email',
                                    labelStyle: GoogleFonts.poppins(
                                      fontSize: 14.0,
                                      color: Color(0xFF95A1AC),
                                      fontWeight: FontWeight.w600,
                                      //   FlutterFlowTheme.bodyText1.override(
                                      // fontFamily: 'Lexend Deca',
                                      // color: Color(0xFF95A1AC),
                                      // fontSize: 14,
                                      // fontWeight: FontWeight.normal,
                                    ),
                                    hintText: 'Enter your email here...',
                                    hintStyle: GoogleFonts.poppins(
                                      fontSize: 14.0,
                                      color: Color(0xFF95A1AC),
                                      fontWeight: FontWeight.w600,
                                      //   FlutterFlowTheme.bodyText1.override(
                                      // fontFamily: 'Lexend Deca',
                                      // color: Color(0xFF95A1AC),
                                      // fontSize: 14,
                                      // fontWeight: FontWeight.normal,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFDBE2E7),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFDBE2E7),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            16, 24, 0, 24),
                                    prefixIcon: Icon(
                                      Icons.mail_outlined,
                                    ),
                                  ),
                                  style: GoogleFonts.poppins(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    //   FlutterFlowTheme.bodyText1.override(
                                    // fontFamily: 'Lexend Deca',
                                    // color: Color(0xFF95A1AC),
                                    // fontSize: 14,
                                    // fontWeight: FontWeight.normal,
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(20, 16, 20, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: passwordController,
                                  obscureText: !passwordVisibility,
                                  decoration: InputDecoration(
                                    labelText: 'Enter Password',
                                    labelStyle: GoogleFonts.poppins(
                                      fontSize: 14.0,
                                      color: Color(0xFF95A1AC),
                                      fontWeight: FontWeight.w600,
                                      //   FlutterFlowTheme.bodyText1.override(
                                      // fontFamily: 'Lexend Deca',
                                      // color: Color(0xFF95A1AC),
                                      // fontSize: 14,
                                      // fontWeight: FontWeight.normal,
                                    ),
                                    hintText: 'Enter your password here...',
                                    hintStyle: GoogleFonts.poppins(
                                      fontSize: 14.0,
                                      color: Color(0xFF95A1AC),
                                      fontWeight: FontWeight.w600,
                                    ),

                                    //     FlutterFlowTheme.bodyText1.override(
                                    //   fontFamily: 'Lexend Deca',
                                    //   color: Color(0xFF95A1AC),
                                    //   fontSize: 14,
                                    //   fontWeight: FontWeight.normal,
                                    // ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFDBE2E7),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0xFFDBE2E7),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            16, 24, 0, 24),
                                    prefixIcon: Icon(
                                      Icons.lock_outlined,
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
                                        color: Color(0xFF95A1AC),
                                        size: 25,
                                      ),
                                    ),
                                  ),
                                  style: GoogleFonts.poppins(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  keyboardType: TextInputType.visiblePassword,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20, 0, 20, 0),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    // final user = await createAccountWithEmail(
                                    //   context,
                                    //   emailAddressController2.text,
                                    //   passwordController.text,
                                    // );
                                    // if (user == null) {
                                    //   return;
                                    // }

                                    // await Navigator.pushAndRemoveUntil(
                                    //   context,
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => MainScreen(),
                                        // NavBarPage(initialPage: 'Home'),
                                      ),
                                      //   (r) => false,
                                    );
                                  },
                                  child: Text('Login',
                                      style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500)),
                                  style: ElevatedButton.styleFrom(
                                      fixedSize: const Size(350, 60),
                                      primary: Color(0xFF28b446)),

                                  // options: FFButtonOptions(
                                  // width: 330,
                                  // height: 60,

                                  // color: const Color(0xFF28b446),
                                  // textStyle: TextStyle(
                                  //   fontSize: 14.0,
                                  //   color: Colors.white,
                                  //   fontWeight: FontWeight.normal,
                                  // ),

                                  //     FlutterFlowTheme.bodyText2.override(
                                  //   fontFamily: 'Poppins',
                                  //   color: Colors.white,
                                  // ),
                                  // borderSide: BorderSide(
                                  //   color: Colors.transparent,
                                  //   width: 1,
                                  // ),
                                  // borderRadius: 12,
                                  // ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 30),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  'Dont have an account?',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14.0,
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.normal,
                                  ),
                                  // style: FlutterFlowTheme.bodyText2.override(
                                  //   fontFamily: 'Poppins',
                                  //   fontSize: 14,
                                  // ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 0),
                                  child: InkWell(
                                    onTap: () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => WelcomeWidget(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Sign Up',
                                      textAlign: TextAlign.start,
                                      style: GoogleFonts.poppins(
                                        fontSize: 14.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
