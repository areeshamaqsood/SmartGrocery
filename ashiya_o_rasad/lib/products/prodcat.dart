import 'package:ashiya_o_rasad/home.dart';
import 'package:ashiya_o_rasad/categories.dart';
import '/products/prodshow.dart';
import '../variables.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// import 'package:ashiya_o_rasad/bottomnav.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductCategoriesWidget extends StatefulWidget {
  const ProductCategoriesWidget({Key key}) : super(key: key);

  @override
  _ProductCategoriesWidgetState createState() =>
      _ProductCategoriesWidgetState();
}

class _ProductCategoriesWidgetState extends State<ProductCategoriesWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  // Create array for all categories

  static String lower;
  static bool redirect = false;
  final Stream _prodcat = FirebaseFirestore.instance
      .collection('Category')
      .doc('categories')
      .collection(Category.cat1)
      .doc(lower)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFEFEFEF),
      // Top Bar Information

      appBar: AppBar(
        title: Text(
          Category.cat1,
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        leading: GestureDetector(
          // Go back to Home Page
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CategoriesWidget()
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
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: AlwaysScrollableScrollPhysics(),
        children: List.generate(
          Category.ProductTypes.length,
          (index) {
            return InkWell(
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  //Define Inside Components
                  children: [
                    //Positioning Image on box
                    Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                      ),
                      child: Image.asset(
                        'assets/images/ProductTypes/' +
                            Category.ProductTypes[index] +
                            '.png',
                        width: 60,
                        height: 60,
                        fit: BoxFit.contain,
                      ),
                    ),
                    //Positioning Category name under box
                    Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                        child: Text(
                          Category.ProductTypes[index],
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // On Tap what will happen
              onTap: () {
                Category.Products.clear();
                redirect = false;
                lower = convertlower();
                print("Pressed a ${lower},${Category.cat1}");
                // List<String> userLists = [];
                String catcopy;
                if (Category.cat1 == "Processed") {
                  catcopy = "Processed Food";
                } else {
                  catcopy = Category.cat1;
                }
                FirebaseFirestore.instance
                    .collection('Category')
                    .doc('categories')
                    .collection(catcopy)
                    .doc(lower)
                    .get()
                    .then((DocumentSnapshot documentSnapshot) {
                  if (documentSnapshot.exists) {
                    print(
                        'Document data: ${documentSnapshot.data()},  ID: ${documentSnapshot.id},   PROD: ${documentSnapshot['prod']}');
                    Category.ProdMap.forEach((key, value) {
                      if (key.contains('${Category.ProductTypes[index]}')) {
                        // There is no entry for the product as of yet so it cant redirect
                        if (value.contains("{}")) {
                          print(
                              'Sorry, no products yet for ${Category.ProductTypes[index]}');

                          var snackBar = SnackBar(
                            content: Text(
                              'Sorry, no products yet for ${Category.ProductTypes[index]}',
                              style: GoogleFonts.poppins(
                                fontSize: 15.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            duration: Duration(milliseconds: 1500),
                            backgroundColor: Colors.red,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          print("We found it: ${Category.ProdMap[key]}");
                          Category.Products.add(Category.ProdMap[key]);
                          if (!redirect) {
                            redirect = true;
                          }
                        }
                      }
                      if (redirect) {
                        Category.currentproductcat =
                            Category.ProductTypes[index];
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductShowWidget()
                              // NavBarPage(initialPage: 'Home'),
                              ),
                        );
                      }
                    });
                    print(Category.ProductTypes);
                  } else {
                    print('Document does not exist on the database');
                  }
                });
              },
            );
          },
        ),
      ),
    );
  }
}
