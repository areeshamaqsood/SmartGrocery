// import 'package:ashiya_o_rasad/home.dart';
import 'package:ashiya_o_rasad/bottomnav.dart';
import 'package:ashiya_o_rasad/variables.dart';
// import '../main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ashwidgets.dart';

Map<String, List<String>> search(String searchf) {
  Map<String, List<String>> searchresults = {};
  List<String> typelist = Category.ProdMap.keys.toList();
  searchf = searchf.toLowerCase();
  // typelist = typelist.map((type) => type.toLowerCase()).toList();
  // print("Query = ${searchf}");
  for (var i = 0; i < typelist.length; i++) {
    // we use the toLowerCase() method to make it case-insensitive
    var checktype = typelist[i].toLowerCase();
    if (checktype.contains(searchf)) {
      // print("SearchIndex = ${Category.ProdMap[typelist[i]]}");
      searchresults[typelist[i]] = Category.ProdMap[typelist[i]];
    }
  }
  print("Search = ${searchresults}");
  return searchresults;
}

class SearchWidget extends StatefulWidget {
  const SearchWidget({Key key}) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  // TextEditingController searchcontroller;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final searchcontroller = TextEditingController();
  @override
  void initState() {
    super.initState();
    setState(() {
      print("HI");
    });
  }

  bool searchdone = false;
  // int changesearch() {
  //   setState(() {});
  //   return 1;
  // }

  String searchString = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFEFEFEF),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Top Bar
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.11,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Back Button
                          InkWell(
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainScreen()
                                    // NavBarPage(initialPage: 'Home'),
                                    ),
                              );
                            },
                            child: Icon(
                              Icons.arrow_back_rounded,
                              color: Colors.black,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Search Bar
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Material(
                          color: Colors.transparent,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.height * 0.06,
                            decoration: BoxDecoration(
                              color: Color(0xFFF4F5F9),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 2,
                                  color: Color(0x4E000000),
                                  offset: Offset(0, 4),
                                )
                              ],
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Color(0xFFEEEEEE),
                                width: 2,
                              ),
                            ),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  // TextField
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 0),
                                      child: TextFormField(
                                        controller: searchcontroller,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'Search products here...',
                                          labelStyle: GoogleFonts.poppins(
                                            color: Color(0xFF95A1AC),
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.never,
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 1,
                                            ),
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 1,
                                            ),
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          // Search Icon
                                          prefixIcon: Icon(
                                            Icons.search_rounded,
                                            color: Color(0xFF95A1AC),
                                          ),
                                          // Clear
                                          suffixIcon: IconButton(
                                            icon: Icon(Icons.clear),
                                            color: Colors.redAccent,
                                            // Clear the search field
                                            onPressed: () {
                                              setState(() {
                                                searchdone = false;
                                              });
                                              searchcontroller.clear();
                                            },
                                          ),
                                        ),
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        onFieldSubmitted: (value) {
                                          setState(() {
                                            searchdone = false;
                                          });

                                          Search.SearchMap.clear();
                                          Search.SearchMap =
                                              search(searchcontroller.text);
                                          setState(() {
                                            searchdone = true;
                                          });
                                        },
                                        // onChanged: (value) {
                                        //   setState(() {
                                        //     // searchString = value.toLowerCase();
                                        //   });
                                        // },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Health Issue
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15, 15, 0, 20),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  // Health Issue title
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Add Health Issue',
                        style: GoogleFonts.poppins(
                          fontSize: 20.0,
                          color: Colors.grey[800],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  // Health Issue Tags
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                          child: ElevatedButton(
                            onPressed: () {
                              print("Lactose Intolerent");
                            },
                            child: Text('Lactose Intolerent',
                                style: GoogleFonts.poppins(
                                    fontSize: 13, fontWeight: FontWeight.w500)),
                            style: ElevatedButton.styleFrom(
                                fixedSize: const Size(150, 40),
                                primary: Color(0x84000000)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                          child: ElevatedButton(
                            onPressed: () {
                              print("Pascatarian");
                            },
                            child: Text('Pascatarian',
                                style: GoogleFonts.poppins(
                                    fontSize: 13, fontWeight: FontWeight.w500)),
                            style: ElevatedButton.styleFrom(
                                fixedSize: const Size(150, 40),
                                primary: Color(0x84000000)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Urdu Speech
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                    child: Text(
                      'Search With Urdu Speech',
                      style: GoogleFonts.poppins(
                        fontSize: 20.0,
                        color: Colors.grey[800],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  // Button
                  ElevatedButton.icon(
                    onPressed: () {
                      print("Voice Search");
                    },
                    label: Text('Voice Search',
                        style: GoogleFonts.poppins(
                            fontSize: 15, fontWeight: FontWeight.w500)),
                    icon: Icon(
                      Icons.mic,
                      size: 20,
                    ),
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(350, 60),
                        primary: Color(0xFF28b446)),
                  ),
                ],
              ),
            ),
            searchdone
                ? Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              // Call an external widget that shows all product list
                              child: SearchProducts(),
                            ),
                            // Text(
                            //   (() {
                            //     setState(() {});
                            //     return "...";
                            //   }()),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
