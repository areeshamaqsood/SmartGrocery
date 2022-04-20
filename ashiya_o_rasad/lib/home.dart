import 'package:ashiya_o_rasad/search.dart';
import 'package:ashiya_o_rasad/categories.dart';
import 'cart.dart';
import 'variables.dart';
import 'ashwidgets.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'API.dart';
import 'dart:convert';
import 'login.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

DocumentSnapshot snapshot;

final firestoreInstance = FirebaseFirestore.instance;
Future<QuerySnapshot> years =
    FirebaseFirestore.instance.collection('Orders').get();

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
            print(result.data());
          });
        });
      });
    });
  return null;
}

class _HomeWidgetState extends State<HomeWidget> {
  // TextEditingController searchFieldController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var ord = [];
  var gdata;
  String url;
  Map<String, dynamic> QueryText = {};

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
                          onPressed: () async {
                            print("Generate Grocery List");
                            url = 'http://10.0.2.2:5000/recomm?Query=' + "test2";
                            // Account.email1.toString();
                            gdata = await getData(url);
                            // print(gdata.toString());
                            var decodedData = jsonDecode(gdata);
                            print("decodedData: ${decodedData}");
                            setState(() {
                              QueryText = decodedData['Query'];
                            });
                            print("QueryText: ${QueryText}");
                            for (var v in decodedData['ProductID']) {
                              print(v);
                              Cart.ProdCart.add(Category.ProdMap[v]);
                              Cart.ProdQty.add(1);
                              // Cart.ProdID.add(v);
                            }
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CartWidget()
                              ),
                            );
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
                            // Press Categories
                            onTap: () {}),
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
            //Show several different products
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      // Call an external widget that shows all product list
                      child: AllProducts(),
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
