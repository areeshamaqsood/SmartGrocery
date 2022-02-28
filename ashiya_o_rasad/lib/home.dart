// import 'dart:html';

import 'package:ashiya_o_rasad/cart.dart';
import 'package:ashiya_o_rasad/search.dart';
import 'package:ashiya_o_rasad/categories.dart';
import 'dart:convert';
import '/products/product_details.dart';
import 'account.dart';
import 'variables.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

DocumentSnapshot snapshot;

final firestoreInstance = FirebaseFirestore.instance;
Future<QuerySnapshot> years =
    FirebaseFirestore.instance.collection('Orders').get();

var prodlist = [
  'ID1',
  'ID10',
  'ID13',
  'ID17',
  'ID18',
  'ID24',
  'ID5',
];

// 'ID1', 'Lipton'
// 'ID10', 'SB'
// 'ID13', 'Olpers'
// 'ID17', 'Dalda Canola Oil Pouch'
// 'ID18', 'Ariel'
// 'ID24', 'Surf Excel'
// 'ID5', 'Dawn'

Future<List<String>> getproducts() async {
  // var prod = List<dynamic>();
  for (var i = 0; i <= Category.cat.length - 1; i++)
    firestoreInstance.collection("Category").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        firestoreInstance
            .collection("Category")
            .doc(result.id)
            .collection(Category.cat[i])
            .get()
            .then((querySnapshot) {
          querySnapshot.docs.forEach((result) {
            // print(result.data);
            print(result.data());
          });
        });
      });
    });
  // return prod;
}

class _HomeWidgetState extends State<HomeWidget> {
  // TextEditingController searchFieldController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var ord = [];

  void getOrd() async {
    var collection = FirebaseFirestore.instance.collection('Orders');
    var querySnapshots = await collection.get();
    for (var snapshot in querySnapshots.docs) {
      ord.add(snapshot.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'Home',
          style: GoogleFonts.poppins(
            fontSize: 20.0,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [],
        centerTitle: false,
      ),
      backgroundColor: Color(
        (0xFFf4f5f9),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            // Search for Grocery button
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Color(0xFFF4F5F9),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(15, 10, 15, 0),
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchWidget()
                                  // NavBarPage(initialPage: 'Home'),
                                  ),
                            );
                          },
                          label: Text('Search for Grocery',
                              style: GoogleFonts.poppins(
                                  fontSize: 15, fontWeight: FontWeight.w500)),
                          icon: Icon(
                            Icons.search,
                            size: 20,
                          ),
                          style: ElevatedButton.styleFrom(
                              fixedSize: const Size(350, 50),
                              primary: Color(0xFF28b446)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Generate Grocery List button
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Color(0xFFF4F5F9),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(15, 10, 15, 0),
                        child: ElevatedButton.icon(
                          onPressed: () {
                            print("Generate Grocery List");
                          },
                          label: Text('Generate Grocery List',
                              style: GoogleFonts.poppins(
                                  fontSize: 15, fontWeight: FontWeight.w500)),
                          icon: Icon(
                            Icons.shopping_bag_outlined,
                            size: 20,
                          ),
                          style: ElevatedButton.styleFrom(
                              fixedSize: const Size(350, 50),
                              primary: Color(0xFF28b446)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            //Categories title on top
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 12, 20, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Categories',
                    style: GoogleFonts.poppins(
                      fontSize: 20.0,
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            // Show categories in a single row
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    for (var i = 0; i < 3; i++)
                      // Shows category boxes with 3 different options to choose from
                      Container(
                        width: 90,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                        ),
                        child: InkWell(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //Circle with Image inside
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 5, 5, 5),
                                    child: Image.asset(
                                      'assets/images/categories/${Category.cat[i]}.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                // Bottom Text
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 0),
                                  child: Text(
                                    Category.cat[i],
                                    style: GoogleFonts.poppins(
                                      fontSize: 13.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              // final CollectionReference catget =
                              //     FirebaseFirestore.instance
                              //         .collection('Category');
                              // catget
                              //     .doc('${Account.email1}')
                              //     .get()
                              //     .then((DocumentSnapshot documentSnapshot) {
                              //   if (documentSnapshot.exists) {
                              //     Map<String, dynamic> data = documentSnapshot
                              //         .data() as Map<String, dynamic>;
                              //     print(
                              //         '${Account.pass1}, ${data['password']}');
                              //     if (Account.pass1 == data['password']) {
                              //       print('Document exists on the database');
                              //       Account.name1 = data['name'];
                              //       print(
                              //           "Full Name: ${data['name']}, Email: ${data['email']}");
                              //     }
                              //   }
                              // });
                            }),
                      ),
                    // More Button
                    GestureDetector(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoriesWidget(),
                          ),
                        );
                      },
                      child: Container(
                        width: 80,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: Color(0xFF28B446),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                              child: Text(
                                'More',
                                style: GoogleFonts.poppins(
                                  fontSize: 12.0,
                                  color: Color(0xFF8B97A2),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Featured Products title(of all)
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 8, 20, 8),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Featured Products',
                    style: GoogleFonts.poppins(
                      fontSize: 20.0,
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            /*
            Column(
              // mainAxisSize: MainAxisSize.max,
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  // mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(3, 0, 3, 0),
                        child:
                            // GridView(
                            //   padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                            //   gridDelegate:
                            //       SliverGridDelegateWithFixedCrossAxisCount(
                            //     crossAxisCount: 2,
                            //     crossAxisSpacing: 10,
                            //     mainAxisSpacing: 10,
                            //     childAspectRatio: 1,
                            //   ),
                            //   primary: true,
                            //   shrinkWrap: true,
                            //   children: [
                            // getproducts();

                            //for (var i = 0; i <= 5; i++)
                            //   FirebaseFirestore.instance
                            //       .collection('users')
                            //       .get()
                            //       .then((QuerySnapshot querySnapshot) {
                            //           querySnapshot.docs.forEach((doc) {
                            //               print(doc["first_name"]);
                            //           });
                            //       });

                            StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('Orders')
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              // return Text('ErrorLOTS');
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return new GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 1,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                return Center(
                                  child: Card(
                                    child: InkWell(
                                      splashColor: Colors.white,
                                      onTap: () async {
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ProductDetailsWidget(),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        child: Column(
                                          children: [
                                            Row(
                                              // mainAxisSize:
                                              //     MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 0, 0),
                                                  child: Image.network(
                                                    'http://orfiagro.com/wp-content/uploads/2020/10/milk-435295-960x640-1.png',
                                                    width: 80,
                                                    height: 80,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  snapshot
                                                      .data.docs[index]['Price']
                                                      .toString(),
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 13.0,
                                                    color: Color(0xFF28B446),
                                                    fontWeight: FontWeight.w500,
                                                  ),

                                                  // style: FlutterFlowTheme.bodyText1.override(
                                                  //   fontFamily: 'Poppins',
                                                  //   color: Color(0xFF28B446),
                                                  //   fontSize: 13,
                                                  //   fontWeight: FontWeight.w500,
                                                  // ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  snapshot
                                                      .data
                                                      .docs[index]
                                                          ['ProductName']
                                                      .toString(),
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 15.0,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w600,
                                                  ),

                                                  // style: FlutterFlowTheme.bodyText1.override(
                                                  //   fontFamily: 'Poppins',
                                                  //   color: Colors.black,
                                                  //   fontSize: 15,
                                                  //   fontWeight: FontWeight.w600,
                                                  // ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 0, 1),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    '1.0 Litre',
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 13.0,
                                                      color: Color(0xFF868889),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),

                                                    // style: FlutterFlowTheme.bodyText1
                                                    //     .override(
                                                    //   fontFamily: 'Poppins',
                                                    //   color: Color(0xFF868889),
                                                    //   fontSize: 13,
                                                    // ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // Row(
                                    //   // mainAxisSize: MainAxisSize.max,
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.center,
                                    //   children: [
                                    //     ElevatedButton.icon(
                                    //       onPressed: () async {
                                    //         ScaffoldMessenger.of(context)
                                    //             .showSnackBar(
                                    //           SnackBar(
                                    //             content: Text(
                                    //               'Added To Cart',
                                    //               style: GoogleFonts.poppins(
                                    //                 fontSize: 15.0,
                                    //                 color: Colors.grey[800],
                                    //                 fontWeight:
                                    //                     FontWeight.w400,
                                    //               ),
                                    //             ),
                                    //             duration: Duration(
                                    //                 milliseconds: 4000),
                                    //             backgroundColor: Colors.white,
                                    //           ),
                                    //         );
                                    //       },
                                    //       label: Text('Add To Cart',
                                    //           style: GoogleFonts.poppins(
                                    //               fontWeight:
                                    //                   FontWeight.w500)),
                                    //       icon: Icon(
                                    //         Icons.shopping_bag_outlined,
                                    //         color: Colors.white,
                                    //         size: 17,
                                    //       ),
                                    //       style: ElevatedButton.styleFrom(
                                    //           fixedSize: const Size(181, 40),
                                    //           primary: Color(0xFF28b446)),
                                    //     ),
                                    //   ],
                                    // ),
                                  ),
                                );
                              },
                              itemCount: snapshot.data.docs.length,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            */
            //Show several different products
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: GridView(
                        physics: ScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1,
                        ),
                        primary: false,
                        shrinkWrap: true,
                        children: [
                          StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('Orders')
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return new ListView(
                                shrinkWrap: true,
                                children: snapshot.data.docs.map(
                                  (document) {
                                    if (prodlist
                                        .contains(document['InvoiceID'])) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        //Build a card for a sample product
                                        child: Card(
                                          child: Column(
                                            children: [
                                              //Touchable Card
                                              InkWell(
                                                splashColor: Colors.white,
                                                // What will happen if you press the blank screen of the card
                                                onTap: () async {
                                                  await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ProductDetailsWidget(),
                                                    ),
                                                  );
                                                },
                                                // How the deisgn structure of the card would look like
                                                child: Container(
                                                  //From top to bottom what will different tems look like
                                                  child: Column(
                                                    children: [
                                                      //Image display of the card
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        0,
                                                                        0,
                                                                        0),
                                                            child: Image.asset(
                                                              'assets/images/Products/' +
                                                                  document[
                                                                      'ProductName'] +
                                                                  '.png',
                                                              width: 80,
                                                              height: 80,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      //Show Product Name
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            document[
                                                                'ProductName'],
                                                            style: GoogleFonts
                                                                .poppins(
                                                              fontSize: 13.0,
                                                              color: Color(
                                                                  0xFF28B446),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      //Show Price
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            'PKR ' +
                                                                document[
                                                                        'Price']
                                                                    .toString(),
                                                            style: GoogleFonts
                                                                .poppins(
                                                              fontSize: 15.0,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      //Show Quantity
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0, 0, 0, 1),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              '1.0 Litre',
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                fontSize: 13.0,
                                                                color: Color(
                                                                    0xFF868889),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              //Add to Cart Button
                                              Row(
                                                // mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  ElevatedButton.icon(
                                                    onPressed: () async {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                            'Added To Cart',
                                                            style: GoogleFonts
                                                                .poppins(
                                                              fontSize: 15.0,
                                                              color: Colors
                                                                  .grey[800],
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                          duration: Duration(
                                                              milliseconds:
                                                                  4000),
                                                          backgroundColor:
                                                              Colors.white,
                                                        ),
                                                      );
                                                    },
                                                    label: Text('Add To Cart',
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                    icon: Icon(
                                                      Icons
                                                          .shopping_bag_outlined,
                                                      color: Colors.white,
                                                      size: 17,
                                                    ),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            fixedSize:
                                                                const Size(
                                                                    181, 40),
                                                            primary: Color(
                                                                0xFF28b446)),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Container();
                                    }
                                  },
                                ).toList(),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
