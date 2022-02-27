import 'package:ashiya_o_rasad/home.dart';
import 'package:ashiya_o_rasad/categories.dart';
// import '../flutter_flow/flutter_flow_theme.dart';
// import '../flutter_flow/flutter_flow_util.dart';
// import '../main.dart';
import '../variables.dart';
import '/products/prodcat.dart';
import '/products/product_details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// import 'package:ashiya_o_rasad/bottomnav.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductShowWidget extends StatefulWidget {
  const ProductShowWidget({Key key}) : super(key: key);

  @override
  _ProductShowWidgetState createState() => _ProductShowWidgetState();
}

class _ProductShowWidgetState extends State<ProductShowWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

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
              MaterialPageRoute(builder: (context) => ProductCategoriesWidget()
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
          Category.Products.length,
          // Generate the Card
          (index) {
            /*
                                        return Card(
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
            */

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
                            Category.currentproductcat +
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
                          Category.Products[index],
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductDetailsWidget()
                      // NavBarPage(initialPage: 'Home'),
                      ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}