// import '../flutter_flow/flutter_flow_count_controller.dart';
// import '../flutter_flow/flutter_flow_icon_button.dart';
// import '../flutter_flow/flutter_flow_theme.dart';
// import '../flutter_flow/flutter_flow_util.dart';
// import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:ashiya_o_rasad/home.dart';
import 'package:ashiya_o_rasad/bottomnav.dart';

import '../main.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({Key key}) : super(key: key);

  @override
  _CartWidgetState createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int countControllerValue1 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
/*
        leading: ElevatedButton.icon(
          // borderColor: Colors.transparent,
          // borderRadius: 30,
          // buttonSize: 46,
          label: Text(""),
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
            size: 24,
          ),
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeWidget(),
              ),
            );
          },
        ),
        */
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
      body: SafeArea(
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
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.96,
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
                                width: 0,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8, 0, 0, 0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.asset(
                                          'assets/images/Products/Lipton Yellow Label.png',
                                          width: 74,
                                          height: 74,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12, 0, 0, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Lipton Yellow Label',
                                          style: GoogleFonts.poppins(
                                            fontSize: 18.0,
                                            color: Color(0xFF111417),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 4, 0, 4),
                                          child: Text(
                                            '1.0 litre',
                                            style: GoogleFonts.poppins(
                                              fontSize: 14.0,
                                              color: Color(0xFF090F13),
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 8, 0, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 16, 0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Rs. 198',
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: 15.0,
                                                          color:
                                                              Color(0xFF28b446),
                                                          fontWeight:
                                                              FontWeight.w500,
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
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      countControllerValue1 != 0
                                          ? new IconButton(
                                              icon: new Icon(Icons.remove),
                                              onPressed: () => setState(() =>
                                                  countControllerValue1--),
                                            )
                                          : new Container(
                                              child: Padding(
                                                  padding:
                                                      EdgeInsets.all(23.5)),
                                            ),
                                      new Text(
                                        countControllerValue1.toString(),
                                        style: GoogleFonts.poppins(
                                          fontSize: 15.0,
                                          color: Color(0xFF28b446),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      new IconButton(
                                          icon: new Icon(Icons.add),
                                          onPressed: () => setState(
                                              () => countControllerValue1++))

                                      /*    
                                      Container(
                                        width: 160,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          shape: BoxShape.rectangle,
                                          border: Border.all(
                                            color: Color(0x009E9E9E),
                                          ),
                                        ),
                                        child: 
                                        FlutterFlowCountController(
                                          decrementIconBuilder: (enabled) =>
                                              FaIcon(
                                            FontAwesomeIcons.minus,
                                            color: enabled
                                                ? Color(0xDD000000)
                                                : Color(0xFFEEEEEE),
                                            size: 20,
                                          ),
                                          incrementIconBuilder: (enabled) =>
                                              FaIcon(
                                            FontAwesomeIcons.plus,
                                            color: enabled
                                                ? Color(0xFF28B446)
                                                : Color(0xFFEEEEEE),
                                            size: 20,
                                          ),
                                          countBuilder: (count) => Text(
                                            count.toString(),
                                            style: GoogleFonts.getFont(
                                              'Roboto',
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          ),
                                          count: countControllerValue1 ??= 0,
                                          updateCount: (count) => setState(() =>
                                              countControllerValue1 = count),
                                          stepSize: 1,
                                        ),
                                      ),
                                    */
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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
                                      'Rs. 198',
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
                                      'Rs. 298',
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
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                                child: ElevatedButton(
                                  onPressed: () {
                                    print("Proceed to Checkout");
                                  },
                                  child: Text('Proceed to Checkout',
                                      style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500)),
                                  style: ElevatedButton.styleFrom(
                                      fixedSize: const Size(350, 60),
                                      primary: Color(0xFF28b446)),

                                  // options: FFButtonOptions(
                                  //   width: 320,
                                  //   height: 60,
                                  //   color: Color(0xFF28B446),
                                  //   textStyle:
                                  //   elevation: 3,
                                  //   borderSide: BorderSide(
                                  //     color: Colors.transparent,
                                  //     width: 1,
                                  //   ),
                                  //   borderRadius: 8,
                                  // ),
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
    );
  }
}
