import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'products/product_details.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeProduct extends StatelessWidget {
  final prodlist;
  HomeProduct(this.prodlist);

  @override
  Widget build(BuildContext context) {
    return GridView(
      physics: ScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
        childAspectRatio: 1,
      ),
      primary: false,
      shrinkWrap: true,
      children: [
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Orders').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return new ListView(
              shrinkWrap: true,
              children: snapshot.data.docs.map(
                (document) {
                  if (prodlist.contains(document['InvoiceID'])) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Card(
                        child: Column(
                          children: [
                            InkWell(
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
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 0, 0),
                                          child: Image.asset(
                                            'assets/images/Products/' +
                                                document['ProductName'] +
                                                '.png',
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
                                          document['ProductName'],
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
                                          'PKR ' + document['Price'].toString(),
                                          style: GoogleFonts.poppins(
                                            fontSize: 15.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 1),
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
                                              fontWeight: FontWeight.w500,
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
                            Row(
                              // mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () async {
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
    );
  }
}
