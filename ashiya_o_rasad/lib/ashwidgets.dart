import 'package:flutter/material.dart';
import 'products/product_details.dart';
import 'package:google_fonts/google_fonts.dart';
import '../variables.dart';

// Products List
class AllProducts extends StatefulWidget {
  const AllProducts({Key key}) : super(key: key);

  @override
  _AllProductsState createState() => _AllProductsState();
}

Map<String, List<String>> mapprod(Map<String, List<String>> Prods) {
  Map<String, List<String>> x = Prods;
  return x..removeWhere((key, value) => key == null || value.isEmpty == true);
}

class _AllProductsState extends State<AllProducts> {
  List<String> prod1 = [];
  Map<String, List<String>> ProdMap = mapprod(Category.ProdMap);
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
          // Get key of product in productmap i.e Bread1
          String k1 = Category.ProdMap.keys.elementAt(index);
          // print("k1 = ${k1}");
          // Get product details against key of product in productmap i.e [Dawn, Rs 85, Small, Whole Wheat, Bread]
          prod1 = ProdMap[k1];
          // print("prod1 = ${prod1}");
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
                    // print("y: ${y}");
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
                                  EdgeInsetsDirectional.fromSTEB(0, 7.3, 0, 0),
                              child: Image.asset(
                                'assets/images/ProductTypes/${prod1.last}.png',
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      // If action performed what will happen
                      onPressed: () async {
                        String x = Category.ProdMap.keys.elementAt(index);
                        List<String> y = [];
                        y = ProdMap[x];
                        // print("y: ${y}");
                        Cart.ProdCart.add(y);
                        // print("ProdCart: ${Cart.ProdCart}");
                        // print(ProdMap[index]);
                        Cart.ProdQty.add(1);
                        SnackMessage(context, "Added to Cart");
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

// For Search Query
class SearchProducts extends StatefulWidget {
  const SearchProducts({Key key}) : super(key: key);

  @override
  _SearchProductsState createState() => _SearchProductsState();
}

class _SearchProductsState extends State<SearchProducts> {
  List<String> prod1 = [];
  Map<String, List<String>> SearchMap = mapprod(Search.SearchMap);
  @override
  Widget build(BuildContext context) {
    print("SEARCHMAP LENGTH = ${Search.SearchMap.length}");
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
        SearchMap.length,
        (index) {
          // Get key of product in productmap i.e Bread1
          String k1 = Search.SearchMap.keys.elementAt(index);
          // print("k1 = ${k1}");
          // Get product details against key of product in productmap i.e [Dawn, Rs 85, Small, Whole Wheat, Bread]
          prod1 = SearchMap[k1];
          // print("prod1 = ${prod1}");
          return Card(
            child: Column(
              children: [
                //Touchable Card
                InkWell(
                  splashColor: Colors.white,
                  // What will happen if you press the blank screen of the card
                  onTap: () async {
                    Category.viewProduct.clear();
                    String x = Search.SearchMap.keys.elementAt(index);
                    List<String> y = [];
                    y = SearchMap[x];
                    // print("y: ${y}");
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
                                  EdgeInsetsDirectional.fromSTEB(0, 7.3, 0, 0),
                              child: Image.asset(
                                'assets/images/ProductTypes/${prod1.last}.png',
                                width: 56,
                                height: 56,
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
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      // If action performed what will happen
                      onPressed: () async {
                        String x = Search.SearchMap.keys.elementAt(index);
                        List<String> y = [];
                        y = SearchMap[x];
                        // print("y: ${y}");
                        Cart.ProdCart.add(y);
                        // print("ProdCart: ${Cart.ProdCart}");
                        // print(ProdMap[index]);
                        Cart.ProdQty.add(1);
                        // Show Message
                        SnackMessage(context, "Add to Cart");
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
                          fixedSize: const Size(171, 30),
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
