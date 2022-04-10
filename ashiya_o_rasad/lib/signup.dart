import '../variables.dart';
import '../bottomnav.dart';
import '../Welcome.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../variables.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({Key key}) : super(key: key);

  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

// Persist a new user to Firestore

void CreateUser(CollectionReference users) async {
  await users
      .doc('${Account.email1}')
      .set({
        "email": Account.email1,
        "name": Account.name1,
        "password": Account.pass1
      })
      .then((_) => print('Added'))
      .catchError((error) => print('Add failed: $error'));
}

class _SignUpWidgetState extends State<SignUpWidget> {
  TextEditingController emailAddressController;
  // TextEditingController emailAddressController2;
  TextEditingController passwordController;
  TextEditingController NameController;
  bool passwordVisibility;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final CollectionReference users =
      FirebaseFirestore.instance.collection('Users');
  static int added;
  static String comp;

  @override
  void initState() {
    super.initState();
    emailAddressController = TextEditingController();
    passwordController = TextEditingController();
    NameController = TextEditingController();
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
                                  'Create Account',
                                  style: GoogleFonts.poppins(
                                    fontSize: 24.0,
                                    color: Color(0xFF090F13),
                                    fontWeight: FontWeight.bold,
                                  ),
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
                                  controller: NameController,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Your Name',
                                    labelStyle: GoogleFonts.poppins(
                                      fontSize: 14.0,
                                      color: Color(0xFF95A1AC),
                                      fontWeight: FontWeight.w600,
                                    ),
                                    hintText: 'Enter your name here...',
                                    hintStyle: GoogleFonts.poppins(
                                      fontSize: 14.0,
                                      color: Color(0xFF95A1AC),
                                      fontWeight: FontWeight.w600,
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
                                      Icons.person_outline,
                                    ),
                                  ),
                                  style: GoogleFonts.poppins(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Email Form
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(20, 16, 20, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: emailAddressController,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    // Label for Email
                                    labelText: 'Your Email',
                                    labelStyle: GoogleFonts.poppins(
                                      fontSize: 14.0,
                                      color: Color(0xFF95A1AC),
                                      fontWeight: FontWeight.w600,
                                    ),
                                    // Hint for Email
                                    hintText: 'Enter your email here...',
                                    hintStyle: GoogleFonts.poppins(
                                      fontSize: 14.0,
                                      color: Color(0xFF95A1AC),
                                      fontWeight: FontWeight.w600,
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
                                    labelText: 'Create Password',
                                    labelStyle: GoogleFonts.poppins(
                                      fontSize: 14.0,
                                      color: Color(0xFF95A1AC),
                                      fontWeight: FontWeight.w600,
                                    ),
                                    hintText: 'Enter your password here...',
                                    hintStyle: GoogleFonts.poppins(
                                      fontSize: 14.0,
                                      color: Color(0xFF95A1AC),
                                      fontWeight: FontWeight.w600,
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
                                    added = 0;
                                    Account.name1 = NameController.text;
                                    Account.pass1 = passwordController.text;
                                    Account.email1 =
                                        emailAddressController.text;
                                    comp = Account.email1;
                                    print('Before User $added');
                                    await users
                                        .doc('${Account.email1}')
                                        .get()
                                        .then((DocumentSnapshot
                                            documentSnapshot) {
                                      if (documentSnapshot.exists) {
                                        print('User already exists');
                                        // Show Message
                                        SnackMessage(
                                            context, 'User already exists!');
                                        SnackMessage(
                                            context, 'User Already Exists!');

                                        added = 1;
                                      }
                                    });
                                    print('After validating User $added');

                                    NameController.text = '';
                                    passwordController.text = '';
                                    emailAddressController.text = '';
                                    // If user doesnt exist
                                    if (Account.name1 != null &&
                                        Account.pass1 != null &&
                                        Account.email1 != null) {
                                      //if it doesnt exist then add and login
                                      if (added == 0) {
                                        print('Adding new User $comp, $added');
                                        CreateUser(users);
                                        // Show Message
                                        SnackMessage(context,
                                            'Enjoy your experience ${Account.name1}!');
                                      } else {
                                        //if it exists
                                        print('User exists $comp, $added');
                                        SnackMessage(context,
                                            '${Account.email1} already exists please log in');
                                      }
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => MainScreen(),
                                        ),
                                      );
                                    } else {
                                      SnackMessage(
                                          context, 'Information is missing');
                                    }
                                  },
                                  child: Text('Sign Up',
                                      style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500)),
                                  style: ElevatedButton.styleFrom(
                                      fixedSize: const Size(350, 60),
                                      primary: Color(0xFF28b446)),
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
                                  'Already have an account?',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14.0,
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 0),
                                  child: InkWell(
                                    onTap: () async {
                                      await fetchproducts();
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => WelcomeWidget(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Log In',
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
