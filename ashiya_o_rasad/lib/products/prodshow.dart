// import 'package:ashiya_o_rasad/home.dart';
// import 'package:ashiya_o_rasad/categories.dart';
// import '../main.dart';
import '../variables.dart';
import '/products/prodcat.dart';
import '/products/product_details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// import 'package:ashiya_o_rasad/bottomnav.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class ProductShowWidget extends StatefulWidget {
  const ProductShowWidget({Key key}) : super(key: key);

  @override
  _ProductShowWidgetState createState() => _ProductShowWidgetState();
}

class _ProductShowWidgetState extends State<ProductShowWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  static List<String> ind = [];
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
          // Go back to Categories Page
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductCategoriesWidget()),
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
            ind = Category.Products[index];
            return Card(
              child: Column(
                children: [
                  //Touchable Card
                  InkWell(
                    splashColor: Colors.white,
                    // What will happen if you press the blank screen of the card
                    onTap: () async {
                      Category.viewProduct[0] = Category.Products[index];
                      print(
                          "VIEW = ${Category.Products[index]},    PRODVIEW =  ${Category.viewProduct}, LISTVIEW = ${ind}");

                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailsWidget(),
                        ),
                      );
                    },
                    // How the design structure of the card would look like
                    child: Container(
                      //From top to bottom what will different tems look like
                      child: Column(
                        children: [
                          //Image display of the card
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                child: Image.asset(
                                  'assets/images/ProductTypes/' +
                                      Category.currentproductcat +
                                      '.png',
                                  width: 75,
                                  height: 75,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                          //Show Product Name
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                ind[0],
                                style: GoogleFonts.poppins(
                                  fontSize: 13.0,
                                  color: Color(0xFF28B446),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          //Show Price
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                ind[1],
                                style: GoogleFonts.poppins(
                                  fontSize: 15.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          //Show Quantity
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 1),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  ind[2],
                                  style: GoogleFonts.poppins(
                                    fontSize: 13.0,
                                    color: Color(0xFF868889),
                                    fontWeight: FontWeight.w500,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () async {
                          SnackMessage(context, 'Added to Cart');
                        },
                        label: Text('Add To Cart',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500)),
                        icon: Icon(
                          Icons.shopping_bag_outlined,
                          color: Colors.white,
                          size: 17,
                        ),
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(181, 40),
                            primary: Color(0xFF28b446)),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
