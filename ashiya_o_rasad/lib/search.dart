// import 'package:ashiya_o_rasad/home.dart';
import 'package:ashiya_o_rasad/bottomnav.dart';
import 'package:ashiya_o_rasad/variables.dart';
// import '../main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ashwidgets.dart';

import 'dart:async';
import 'dart:io' as io;
import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:flutter_audio_recorder2/flutter_audio_recorder2.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

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
  // const SearchWidget({Key key}) : super(key: key);

  LocalFileSystem localFileSystem;
  SearchWidget({Key key, localFileSystem}) :localFileSystem = localFileSystem ?? const LocalFileSystem(), super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  // TextEditingController searchcontroller;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // Initialize Recorder Object and Current Status
  FlutterAudioRecorder2 _recorder;
  Recording _current;
  RecordingStatus _currentStatus = RecordingStatus.Unset;
  // String outputText = "Test Output";

  final searchcontroller = TextEditingController();
  @override
  void initState() {
    super.initState();
    setState(() {
      print("HI");
    });
  }

  bool searchdone = false;

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
                                            print(Category.ProdMap);
                                          });

                                          Search.SearchMap.clear();
                                          Search.SearchMap =
                                              search(searchcontroller.text);
                                          setState(() {
                                            searchdone = true;
                                          });
                                        },
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
                      print("Hello World :)");

                      switch (_currentStatus) {
                        case RecordingStatus.Unset: {
                          _start();
                          setState(() {
                            searchdone = false;
                            Search.SearchMap.clear();
                          });
                          // searchcontroller.clear();
                          break;
                        }
                        case RecordingStatus.Initialized: {
                          _start();
                          setState(() {
                            searchdone = false;
                            Search.SearchMap.clear();
                          });
                          // searchcontroller.clear();
                          break;
                        }
                        case RecordingStatus.Recording: {
                          _stop();
                          setState(() {
                            searchdone = false;
                            Search.SearchMap.clear();
                          });
                          break;
                        }
                        case RecordingStatus.Stopped: {
                          _start();
                          break;
                        }
                        default:
                          print("Nothing happens");
                          break;
                      }
                    },
                    label: _buildText(_currentStatus),
                    // Text('Voice Search',
                    //     style: GoogleFonts.poppins(
                    //         fontSize: 15, fontWeight: FontWeight.w500)),
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



//  KAMAL CODE
//  Recorder Application
  _start() async {

    //Initialize state
    try {
      bool hasPermission = await FlutterAudioRecorder2.hasPermissions ?? false;

      if (hasPermission) {
        String customPath = '/flutter_audio_recorder_';
        io.Directory appDocDirectory;
//        io.Directory appDocDirectory = await getApplicationDocumentsDirectory();
        if (io.Platform.isIOS) {
          appDocDirectory = await getApplicationDocumentsDirectory();
        } else {
          appDocDirectory = (await getExternalStorageDirectory());
        }

        // can add extension like ".mp4" ".wav" ".m4a" ".aac"
        customPath = appDocDirectory.path +
            customPath +
            DateTime.now().millisecondsSinceEpoch.toString();
        // customPath = 'assets/flutter_audio_recorder_' + DateTime.now().millisecondsSinceEpoch.toString();

        // .wav <---> AudioFormat.WAV
        // .mp4 .m4a .aac <---> AudioFormat.AAC
        // AudioFormat is optional, if given value, will overwrite path extension when there is conflicts.
        _recorder =
            FlutterAudioRecorder2(customPath, audioFormat: AudioFormat.WAV);

        await _recorder.initialized;
        // after initialization
        var current = await _recorder.current(channel: 0);
        print(current);
        // should be "Initialized", if all working fine
        setState(() {
          _current = current;
          _currentStatus = current.status;
          print(_currentStatus);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("You must accept permissions")));
      }
    } catch (e) {
      print(e);
    }



    try {
      await _recorder.start();
      var recording = await _recorder.current(channel: 0);
      setState(() {
        _current = recording;
      });

      const tick = Duration(milliseconds: 50);
      Timer.periodic(tick, (Timer t) async {
        if (_currentStatus == RecordingStatus.Stopped) {
          t.cancel();
        }

        var current = await _recorder.current(channel: 0);
        setState(() {
          _current = current;
          _currentStatus = _current.status;
        });
      });
    } catch (e) {
      print(e);
    }
  }


  _stop() async {
    var result = await _recorder.stop();
    print("Stop recording: ${result.path}");
    print("Stop recording: ${result.duration}");
    File file = widget.localFileSystem.file(result.path);
    print("File length: ${await file.length()}");
    setState(() {
      _current = result;
      _currentStatus = _current.status;
    });

    // Read file from the storage
    print(_current?.path);
    var pathToAudio = _current?.path;
    io.File audio = io.File(pathToAudio);
    print(audio);


    // Upload local file to FireStorage (Server)
    UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('FYP-audio_1')
          .putFile(audio);
    } catch (e) {
      print('Not Working! :(');
    }

    // Get Download Link
    String downloadURL = await firebase_storage.FirebaseStorage.instance.ref('FYP-audio_1').getDownloadURL();
    print(downloadURL);

    // Send the link over to Flask Server
    try {
      var response = await http.post(Uri.parse('http://10.0.2.2:5000/api'),
          body: {'downloadLink': downloadURL, 'ref': 'FYP-audio_1'});
      // String output_word = JsonDecoder(response.body);
      // setState(() {
      //   outputText = response.body;
      // });
      print(response.body);
      Search.searchQuery = response.body;

      setState(() {
        searchdone = false;
        print(Category.ProdMap);
      });

      Search.SearchMap.clear();
      Search.SearchMap =
          search(Search.searchQuery);
      setState(() {
        searchdone = true;
      });

    } catch(e) {
      print(e);
    }

  }

  Widget _buildText(RecordingStatus status) {
    var text = "";
    switch (_currentStatus) {
      case RecordingStatus.Initialized:
        {
          text = 'Start Recording';
          break;
        }
      case RecordingStatus.Recording:
        {
          text = 'Stop Recording';
          break;
        }
      case RecordingStatus.Stopped:
        {
          text = 'Start Recording';
          break;
        }
      default:
        text = 'Start Recording';
        break;
    }
    return Text(text, style: TextStyle(color: Colors.white));
  }
}
