import '../variables.dart';
import '../products/prodcat.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ashiya_o_rasad/bottomnav.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({Key key}) : super(key: key);

  @override
  _CategoriesWidgetState createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFEFEFEF),
      appBar: AppBar(
        title: Text(
          "Categories",
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        leading: GestureDetector(
          // Go back to Home Page
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
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Top Bar Information
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
                          for (var i = 0; i <= Category.cat.length - 1; i++)
                            // prod = catim[i];
                            StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('Category')
                                  .doc('categories')
                                  .collection(Category.cat[i])
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
                                        //Create InkWell for each category
                                        child: new InkWell(
                                          // Generate Box
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
                                              //Define Inside Components

                                              children: [
                                                //Positioning Image on box
                                                Container(
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.rectangle,
                                                  ),
                                                  child: Image.asset(
                                                    'assets/images/categories/' +
                                                        Category.cat[i] +
                                                        '.png',
                                                    width: 60,
                                                    height: 60,
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                                //Positioning Category name under box
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0, 0),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 0, 0, 0),
                                                    child: Text(
                                                      document['title'],
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // On Tap what will happen
                                          onTap: () {
                                            Category.cat1 = document['title'];
                                            Category.cat2 = document['prod'];
                                            Category.ProductTypes =
                                                ProductType();
                                            print("Pressed ${Category.cat[i]}");
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductCategoriesWidget(),
                                              ),
                                            );
                                          },
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
