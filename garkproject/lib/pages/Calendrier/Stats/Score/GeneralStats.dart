import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:garkproject/pages/Calendrier/Stats/Score/StatsPeriode.dart';
import 'package:garkproject/pages/Calendrier/Stats/Score/StatsSecondaire.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class GeneralStats extends StatefulWidget {
  const GeneralStats({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  State<GeneralStats> createState() => _GeneralStatsState();
}

String _baseUrl = "10.0.2.2:3000";

int nb1 = 0;
int nb2 = 0;
String nomadv = "";
String nc = "";
late Future<bool> fetchedDocs;
SharedPreferences? prefs;

class _GeneralStatsState extends State<GeneralStats> {
  Future<bool> fetchDocs() async {
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8",
    };
    http.Response response = await http.get(
        Uri.parse("http://10.0.2.2:3000/api/evenements/" + '${widget.id}'),
        headers: headers);
    prefs = await SharedPreferences.getInstance();
    nc = prefs!.getString("nameClub")!;
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      setState(() {
        nomadv = data["nomAdversaire"];
      });
      if (data["score1"] != null || data["score2"] != null) {
        setState(() {
          nb1 = data["score1"];
          nb2 = data["score2"];
        });
      }
      // print(data);
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    nb1 = 0;
    nb2 = 0;
    fetchedDocs = fetchDocs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 245, 245),
      appBar:
          PreferredSize(child: getAppBar(), preferredSize: Size.fromHeight(40)),
      body: getBody(),
    );
  }

  Widget getAppBar() {
    return AppBar(
      elevation: 10,
      centerTitle: true, // this is all you need

      backgroundColor: const Color.fromARGB(255, 2, 0, 50),
      title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Spacer(),
            Text(
              'Score',
              textAlign: TextAlign.center,
              style: TextStyle(),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 0),
              child: IconButton(
                  icon: new Icon(Icons.save_as_outlined),
                  onPressed: () {
                    Map<String, dynamic> userData = {
                      "score1": nb1,
                      "score2": nb2
                    };

                    Map<String, String> headers = {
                      "Content-Type": "application/json; charset=UTF-8"
                    };

                    http
                        .put(
                            Uri.http(
                                _baseUrl, "/api/evenements/" + '${widget.id}'),
                            headers: headers,
                            body: json.encode(userData))
                        .then((http.Response response) async {
                      // print(userData);
                      if (response.statusCode == 200) {
                        Navigator.of(context).pop();
                      } else if (response.statusCode == 401) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const AlertDialog(
                                title: Text("Information"),
                                content: Text(
                                    "Username et/ou mot de passe incorrect"),
                              );
                            });
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const AlertDialog(
                                title: Text("Information"),
                                content: Text(
                                    "Une erreur s'est produite. Veuillez réessayer !"),
                              );
                            });
                      }
                    });
                  }),
            )
          ]),
    );
  }

  Widget getBody() {
    return SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
        height: 20,
      ),
      Align(
        alignment: Alignment(-0.8, 0),
        child: Text(
          "Stats générales",
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: 18,
            color: Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Container(
          margin: EdgeInsets.only(top: 10),
          width: double.maxFinite,
          height: 180,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Container(
              padding: const EdgeInsets.only(
                top: 20,
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceEvenly, // use whichever suits your need
                  children: [
                    Column(
                      children: [
                        Align(
                          alignment: Alignment(0, 0),
                          child: Text(
                            nc,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 28.0),
                          child: Align(
                            alignment: Alignment(0, 0),
                            child: Text(
                              nb1.toString(),
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 42,
                                color: nb1 > nb2
                                    ? Color.fromARGB(255, 0, 255, 110)
                                    : nb1 < nb2
                                        ? Color.fromARGB(255, 255, 0, 0)
                                        : Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                        new SizedBox(
                          width: 100,
                          height: 5.0,
                          child: new Center(
                            child: new Container(
                              margin: new EdgeInsetsDirectional.only(
                                  start: 1.0, end: 1.0),
                              height: 2.0,
                              color: Color.fromARGB(255, 208, 208, 208),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              InkWell(
                                child: Container(
                                  width: 40,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      border: Border.all(
                                          width: 1,
                                          color: Color.fromARGB(
                                              255, 97, 204, 35))),
                                  child: Icon(
                                    FontAwesomeIcons.minus,
                                    color: Color.fromARGB(255, 97, 204, 35),
                                    size: 24,
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    if (nb1 <= 0) {
                                      nb1 = 0;
                                    } else {
                                      nb1--;
                                    }
                                  });
                                },
                              ),
                              InkWell(
                                child: Container(
                                  width: 40,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      border: Border.all(
                                          width: 1,
                                          color: Color.fromARGB(
                                              255, 97, 204, 35))),
                                  child: Icon(Icons.add,
                                      color: Color.fromARGB(255, 97, 204, 35)),
                                ),
                                onTap: () {
                                  setState(() {
                                    if (nb1 <= 0) {
                                      nb1 = 0;
                                    }
                                    nb1++;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "SCORE",
                      style: TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 182, 182, 182)),
                    ),
                    Column(
                      children: [
                        Align(
                          alignment: Alignment(0, 0),
                          child: Text(
                            nomadv,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 28.0),
                          child: Align(
                            alignment: Alignment(0, 0),
                            child: Text(
                              nb2.toString(),
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 42,
                                color: nb2 > nb1
                                    ? Color.fromARGB(255, 0, 255, 110)
                                    : nb2 < nb1
                                        ? Color.fromARGB(255, 255, 0, 0)
                                        : Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                        new SizedBox(
                          width: 100,
                          height: 5.0,
                          child: new Center(
                            child: new Container(
                              margin: new EdgeInsetsDirectional.only(
                                  start: 1.0, end: 1.0),
                              height: 2.0,
                              color: Color.fromARGB(255, 208, 208, 208),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              InkWell(
                                child: Container(
                                  width: 40,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      border: Border.all(
                                          width: 1,
                                          color: Color.fromARGB(
                                              255, 97, 204, 35))),
                                  child: Icon(
                                    FontAwesomeIcons.minus,
                                    color: Color.fromARGB(255, 97, 204, 35),
                                    size: 24,
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    if (nb2 <= 0) {
                                      nb2 = 0;
                                    } else {
                                      nb2--;
                                    }
                                  });
                                },
                              ),
                              InkWell(
                                child: Container(
                                  width: 40,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      border: Border.all(
                                          width: 1,
                                          color: Color.fromARGB(
                                              255, 97, 204, 35))),
                                  child: Icon(Icons.add,
                                      color: Color.fromARGB(255, 97, 204, 35)),
                                ),
                                onTap: () {
                                  setState(() {
                                    if (nb2 <= 0) {
                                      nb2 = 0;
                                    }
                                    nb2++;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ]))),
      Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Align(
          alignment: Alignment(-0.8, 0),
          child: Text(
            "Autres stats",
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 18,
              color: Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      InkWell(
        onTap: (() => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => StatsPeriode(id: widget.id)),
            ).then((value) => setState(() {}))),
        child: Container(
            width: double.maxFinite,
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Column(children: [
                  Align(
                    alignment: Alignment(-0.8, 0),
                    child: Text(
                      "Stats de périodes",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ]))),
      ),
      // uncomment to get stat secondaire
      // InkWell(
      //   onTap: (() => Navigator.push(
      //         context,
      //         MaterialPageRoute(builder: (context) => StatsSecondaire()),
      //       ).then((value) => setState(() {}))),
      //   child: Container(
      //       width: double.maxFinite,
      //       margin: EdgeInsets.symmetric(vertical: 2),
      //       padding: EdgeInsets.symmetric(horizontal: 20),
      //       decoration: BoxDecoration(
      //         color: Colors.white,
      //       ),
      //       child: Container(
      //           margin: const EdgeInsets.symmetric(vertical: 10),
      //           child: Column(children: [
      //             Align(
      //               alignment: Alignment(-0.8, 0),
      //               child: Text(
      //                 "Stats secondaires",
      //                 textAlign: TextAlign.left,
      //                 style: TextStyle(
      //                     fontSize: 15,
      //                     color: Color.fromARGB(255, 0, 0, 0),
      //                     fontWeight: FontWeight.w500),
      //               ),
      //             ),
      //           ]))),
      // ),
    ]));
  }
}
