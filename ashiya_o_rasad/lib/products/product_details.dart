// import '../flutter_flow/flutter_flow_count_controller.dart';
// import '../flutter_flow/flutter_flow_icon_button.dart';
// import '../flutter_flow/flutter_flow_theme.dart';
// import '../flutter_flow/flutter_flow_util.dart';
// import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../variables.dart';

class ProductDetailsWidget extends StatefulWidget {
  const ProductDetailsWidget({Key key}) : super(key: key);

  @override
  _ProductDetailsWidgetState createState() => _ProductDetailsWidgetState();
}

class _ProductDetailsWidgetState extends State<ProductDetailsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int countControllerValue = 0;
  double b1 = 0;

  @override
  Widget build(BuildContext context) {
    if (Category.viewProduct.length <= 3) {
      b1 = 12;
    }
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            // Image Row
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Stack(
                    alignment: AlignmentDirectional(0, -1),
                    children: [
                      Image.asset(
                        'assets/images/Products/Lipton Yellow Label.png',
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.6,
                        fit: BoxFit.contain,
                      ),
                      Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                child: IconButton(
                                  icon: Icon(Icons.arrow_back_rounded),
                                  color: Colors.black,
                                  iconSize: 30,
                                  onPressed: () async {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Items on the bottom of Image
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                color: Color(0xFFEEEEEE),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(2, 0, 2, 2),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Price
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Text(
                              Category.viewProduct[0][1],
                              style: GoogleFonts.poppins(
                                fontSize: 20.0,
                                color: Color(0xFF28B446),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Product Name
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Text(
                              Category.viewProduct[0][0],
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Quantity
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 5, 0, b1),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            // flex: 1,
                            child: Text(
                              Category.viewProduct[0][2],
                              style: GoogleFonts.poppins(
                                fontSize: 15.0,
                                color: Color(0xFF868889),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    if (Category.viewProduct.length > 3)
                      // print("Category length = ${Category.viewProduct.length}");
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 12),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Text(
                                Category.viewProduct[0][3],
                                style: GoogleFonts.poppins(
                                  fontSize: 15.0,
                                  color: Color(0xFF868889),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    // Details before we add the cart
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, b1),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Text(
                              'To add this product to your cart please press "Add To Cart" Button Below, you can increase the quantity as well',
                              style: GoogleFonts.poppins(
                                fontSize: 14.0,
                                color: Color(0xFF8B97A2),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Product controller button
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        countControllerValue != 0
                            ? new IconButton(
                                icon: new Icon(Icons.remove),
                                onPressed: () =>
                                    setState(() => countControllerValue--),
                              )
                            : new Container(
                                child: Padding(padding: EdgeInsets.all(23.5)),
                              ),
                        new Text(
                          countControllerValue.toString(),
                          style: GoogleFonts.poppins(
                              fontSize: 16.0,
                              color: Color(0xFF28b446),
                              fontWeight: FontWeight.w600),
                        ),
                        new IconButton(
                            icon: new Icon(Icons.add),
                            onPressed: () =>
                                setState(() => countControllerValue++))
                      ],
                    ),
                    // Add to Cart button
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              Cart.ProdCart.add(Category.viewProduct[0]);
                              Cart.ProdQty.add(countControllerValue);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Added To Cart',
                                    style: GoogleFonts.getFont(
                                      'Poppins',
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                  ),
                                  duration: Duration(milliseconds: 4000),
                                  backgroundColor: Colors.white,
                                ),
                              );
                            },
                            child: Text('Add To Cart',
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
            ),
          ],
        ),
      ),
    );
  }
}
