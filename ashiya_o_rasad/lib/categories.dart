import 'package:ashiya_o_rasad/home.dart';

// import '../flutter_flow/flutter_flow_theme.dart';
// import '../flutter_flow/flutter_flow_util.dart';
import '../main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ashiya_o_rasad/bottomnav.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({Key key}) : super(key: key);

  @override
  _CategoriesWidgetState createState() => _CategoriesWidgetState();
}

var prod;

class _CategoriesWidgetState extends State<CategoriesWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var cat = [
    'Beverages',
    'Condiments',
    'Dairy',
    'Detergent',
    'Fats and Olis',
    'Flour',
    'Processed Food',
    'Spices'
  ];

  var catim = [
    'Beverages.png',
    'Condiments.png',
    'Dairy.png',
    'Detergent.png',
    'Fats.png',
    'Flour.png',
    'Processed.png',
    'Spices.png'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFEFEFEF),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AppBar(
            title: Text(
              "Categories",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500, color: Colors.black),
            ),
            backgroundColor: Colors.white,
            leading: GestureDetector(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MainScreen()
                      // NavBarPage(initialPage: 'Home'),
                      ),
                );
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          ),
          /*
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.1,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
                            child: InkWell(
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MainScreen(),
                                  ),
                                );
                              },
                              child: Icon(
                                Icons.arrow_back_rounded,
                                color: Colors.black,
                                size: 30,
                              ),
                            ),
                          ),
                          Text(
                            'Categories',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          */
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                      child: GridView(
                        padding: EdgeInsets.zero,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 0,
                          mainAxisSpacing: 0,
                          childAspectRatio: 1,
                        ),
                        primary: false,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        children: [
                          for (var i = 0; i <= cat.length - 1; i++)
                            // prod = catim[i];
                            StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('Category')
                                  .doc('categories')
                                  .collection(cat[i])
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  // return Text('ErrorLOTS');
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                return new ListView(
                                  shrinkWrap: true,
                                  children: snapshot.data.docs.map((document) {
                                    return Container(
                                      child: Center(
                                        child: Container(
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.rectangle,
                                                ),
                                                child: Image.asset(
                                                  'assets/images/categories/' +
                                                      catim[i],
                                                  width: 60,
                                                  height: 60,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                    AlignmentDirectional(0, 0),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 2, 0, 0),
                                                  child: Text(
                                                    document['title'],
                                                    style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                );
                              },
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
