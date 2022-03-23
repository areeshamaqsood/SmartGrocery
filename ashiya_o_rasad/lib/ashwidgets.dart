// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'products/product_details.dart';
import 'package:google_fonts/google_fonts.dart';
import '../variables.dart';

// List<String> proditems() {
//   List<String> prod1;
//   return prod1;
// }

class AllProducts extends StatefulWidget {
  const AllProducts({Key key}) : super(key: key);

  @override
  _AllProductsState createState() => _AllProductsState();
}

Map<String, List<String>> mapprod() {
  Map<String, List<String>> x = Category.ProdMap;
  return x..removeWhere((key, value) => key == null || value.isEmpty == true);
}

class _AllProductsState extends State<AllProducts> {
  // final prodlist;
  // HomeProduct(this.prodlist);
  // List<String> prod1 = proditems();
  List<String> prod1 = [];
  Map<String, List<String>> ProdMap = mapprod();
  @override
  Widget build(BuildContext context) {
    print("PRODMAP LENGTH = ${Category.ProdMap.length}");
    return GridView(
      physics: ScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
        childAspectRatio: 1,
      ),
      primary: false,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: List.generate(
        ProdMap.length,
        (index) {
          String k1 = Category.ProdMap.keys.elementAt(index);
          print("k1 = ${k1}");
          prod1 = ProdMap[k1];
          print("prod1 = ${prod1}");
          return Card(
            child: Column(
              children: [
                //Touchable Card
                InkWell(
                  splashColor: Colors.white,
                  // What will happen if you press the blank screen of the card
                  onTap: () async {
                    Category.viewProduct.clear();
                    String x = Category.ProdMap.keys.elementAt(index);
                    List<String> y = [];
                    y = ProdMap[x];
                    print("y: ${y}");
                    Category.viewProduct.add(y);
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailsWidget(),
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              child: Image.asset(
                                'assets/images/Products/SB Super.png',
                                width: 70,
                                height: 70,
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
                              prod1[0],
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
                              prod1[1],
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
                                prod1[2],
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
                        String x = Category.ProdMap.keys.elementAt(index);
                        List<String> y = [];
                        y = ProdMap[x];
                        print("y: ${y}");
                        Cart.ProdCart.add(y);
                        print("ProdCart: ${Cart.ProdCart}");
                        print(ProdMap[index]);
                        Cart.ProdQty.add(1);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Added To Cart',
                              style: GoogleFonts.poppins(
                                fontSize: 15.0,
                                color: Colors.grey[800],
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            duration: Duration(milliseconds: 4000),
                            backgroundColor: Colors.white,
                          ),
                        );
                      },
                      label: Text('Add To Cart',
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.w500)),
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
    );
  }
}
