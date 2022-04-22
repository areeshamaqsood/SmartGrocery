// import 'package:ashiya_o_rasad/auth/auth_util.dart';
// import 'package:ashiya_o_rasad/home.dart';
// import 'package:ashiya_o_rasad/bottomnav.dart';
import '../variables.dart';
// import '../main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Add each product against each order
Future<void> addProduct(CollectionReference orderprod, String ID,
    List<String> prod2, int prodqty1, String prodid) async {
  return await orderprod
      .doc(ID)
      .set({
        'InvoiceID': ID,
        'OrderNo': "O${Order.ordcount}",
        'ProductName': prod2[0],
        'Price': prod2[1],
        'Size': prod2[2],
        'ProductQuantity': prodqty1,
        'ProductType': prod2.last,
        'ProductID': prodid,
      })
      .then((value) => print("Product Added"))
      .catchError((error) => print("Failed to add product: $error"));
}

// Perform action after "Proceeding to checkout"
Future<void> taketoorder() async {
  final CollectionReference orders =
      FirebaseFirestore.instance.collection('Order');
  // bool orderadded = checkorder(orders);
  if (Order.confirm) {
    print("User made");
    print("Before getting Document ID");
    print("OrdersCount = ${Order.ordcount}");
    // Add New Order
    Order.ordcount++;
    var ordnew = "O" + Order.ordcount.toString();
    // Update order count
    orders
        .doc(Account.email1)
        .update({'ordercount': Order.ordcount})
        .then((value) => print("Order Count Updated"))
        .catchError((error) => print("Failed to update Order Count: $error"));
    // Add Order name collection ()
    orders
        .doc(Account.email1)
        .collection(ordnew)
        .add({"productcount": Cart.ProdCart.length});
    CollectionReference orderprod =
        orders.doc(Account.email1).collection(ordnew);
    //Add each product id
    print("Order Created");
    for (var i = 0; i < Cart.ProdCart.length; i++) {
      int x = i + 1; //
      // print()
      print('${Cart.ProdCart[i]} , ${Cart.ProdQty[i]}');
      var prodnew = "ID" + x.toString();
      // Add new product
      addProduct(orderprod, prodnew, Cart.ProdCart[i], Cart.ProdQty[i],
          Cart.ProdID[i]);
    }
  }
  print('Cart Length = ${Cart.ProdCart.length}');
  await Cart.ProdCart.clear();
  await Cart.ProdQty.clear();
  await Cart.ProdID.clear();
}

// Calculate price against each cart item wth their value
int subtotal() {
  int sbtotes = 0;
  for (var i = 0; i < Cart.ProdCart.length; i++) {
    String price = Cart.ProdCart[i][1].replaceAll("Rs ", "");
    sbtotes = sbtotes + (int.parse(price) * Cart.ProdQty[i]);
  }
  // sbtotes = sbtotes + 100;
  return sbtotes;
}

class CartWidget extends StatefulWidget {
  const CartWidget({Key key}) : super(key: key);

  @override
  _CartWidgetState createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int countControllerValue1 = 0;
  // Each Product Index
  List<String> CartProd;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'Shopping Cart',
          style: GoogleFonts.poppins(
            fontSize: 18.0,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFf4f5f9),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(1, 0, 0, 0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                        child: Column(
                          // Show Cart items
                          children: List.generate(
                            Cart.ProdCart.length,
                            (index) {
                              // Product Card
                              return Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.96,
                                    height: 130,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 4,
                                          color: Color(0x3A000000),
                                          offset: Offset(0, 2),
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: Colors.white,
                                      ),
                                    ),
                                    // Contains Details inside card
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        // Product Image
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(8, 0, 0, 0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: Image.asset(
                                                  'assets/images/Products/${Cart.ProdCart[index][0]}.png',
                                                  width: 74,
                                                  height: 74,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        // Get Product Name Quantity and Price
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    8, 0, 0, 0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                // Product Names
                                                Text(
                                                  Cart.ProdCart[index][0],
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 18.0,
                                                    color: Color(0xFF111417),
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                // Product Quantity
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 4, 0, 4),
                                                  child: Text(
                                                    Cart.ProdCart[index][2],
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 14.0,
                                                      color: Color(0xFF090F13),
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                                ),
                                                // Product Price
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 8, 0, 0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      0, 16, 0),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                Cart.ProdCart[
                                                                    index][1],
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  fontSize:
                                                                      15.0,
                                                                  color: Color(
                                                                      0xFF28b446),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
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
                                          ),
                                        ),
                                        // Value Controllers
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    20, 0, 0, 0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                // Decrease Number of Products
                                                Cart.ProdQty[index] != 1
                                                    ? new IconButton(
                                                        icon: new Icon(
                                                            Icons.remove),
                                                        onPressed: () =>
                                                            setState(() =>
                                                                Cart.ProdQty[
                                                                    index]--),
                                                      )
                                                    : new Container(
                                                        child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    23.5)),
                                                      ),
                                                // Show Number of Products
                                                new Text(
                                                  Cart.ProdQty[index]
                                                      .toString(),
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 15.0,
                                                    color: Color(0xFF28b446),
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                // Increase Number of Products
                                                new IconButton(
                                                    icon: new Icon(Icons.add),
                                                    onPressed: () => setState(
                                                        () => Cart
                                                            .ProdQty[index]++))
                                              ],
                                            ),
                                          ),
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 10, 0),
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: Colors.white,
                                                  elevation: 0.0,
                                                ),
                                                child: Icon(
                                                  Icons.delete_outlined,
                                                  color: Colors.black,
                                                ),
                                                onPressed: () {
                                                  //delete action for this button
                                                  Cart.ProdCart.removeAt(index);
                                                  Cart.ProdQty.removeAt(index);
                                                  Cart.ProdID.removeAt(index);
                                                  setState(() {
                                                    //refresh UI after deleting element from list
                                                  });
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                      // Show Order Summary
                      Align(
                        alignment: AlignmentDirectional(-0.05, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.96,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 4,
                                  color: Color(0x3A000000),
                                  offset: Offset(0, 2),
                                )
                              ],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Order Summary
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16, 16, 16, 12),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Order Summary',
                                        style: GoogleFonts.poppins(
                                          fontSize: 16.0,
                                          color: Color(0xFF090F13),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Subtotal Details
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16, 0, 16, 8),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Subtotal',
                                        style: GoogleFonts.poppins(
                                          fontSize: 14.0,
                                          color: Color(0xFF8B97A2),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        "Rs. " + subtotal().toString(),
                                        textAlign: TextAlign.end,
                                        style: GoogleFonts.poppins(
                                          fontSize: 16.0,
                                          color: Color(0xFF111417),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Shipping Details
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16, 0, 16, 12),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Shipping',
                                        style: GoogleFonts.poppins(
                                          fontSize: 14.0,
                                          color: Color(0xFF8B97A2),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        'Rs. 100',
                                        textAlign: TextAlign.end,
                                        style: GoogleFonts.poppins(
                                          fontSize: 16.0,
                                          color: Color(0xFF111417),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Total Details
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16, 12, 16, 16),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Total',
                                        style: GoogleFonts.poppins(
                                          fontSize: 18.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "Rs. " + (subtotal() + 100).toString(),
                                        textAlign: TextAlign.end,
                                        style: GoogleFonts.poppins(
                                          fontSize: 18.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Checkout Button
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 20),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      if (!Cart.ProdCart.isEmpty) {
                                        print("Proceeding to Checkout");
                                        await checkorder();
                                        taketoorder();
                                        setState(() {
                                          Cart.ProdCart.clear();
                                          Cart.ProdQty.clear();
                                          Cart.ProdID.clear();
                                        });
                                      } else {
                                        SnackMessage(context,
                                            'Please add products first!');
                                      }
                                    },
                                    child: Text('Proceed to Checkout',
                                        style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500)),
                                    style: ElevatedButton.styleFrom(
                                        fixedSize: const Size(350, 60),
                                        primary: Color(0xFF28b446)),
                                  ),
                                ),
                              ],
                            ),
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
    );
  }
}
