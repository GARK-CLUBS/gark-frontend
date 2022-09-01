import 'package:custom_check_box/custom_check_box.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:garkproject/data/UsersStats.dart';
import 'package:garkproject/main.dart';
import 'package:garkproject/pages/Auth/ForgetPass.dart';
import 'package:garkproject/pages/Calendrier/Compos/AddCompos.dart';
import 'package:garkproject/pages/Calendrier/ParametresCalendrier.dart';
import 'package:garkproject/pages/Calendrier/Stats/Joueurs/ChooseStat.dart';
import 'package:garkproject/pages/Calendrier/Stats/Joueurs/Note.dart';
import 'package:garkproject/pages/Calendrier/Stats/Score/GeneralStats.dart';
import 'package:garkproject/pages/Calendrier/Tache/DisplayTaches.dart';
import 'package:garkproject/pages/Calendrier/HommeMatch.dart';
import 'package:garkproject/pages/Calendrier/Presence.dart';
import 'package:garkproject/pages/Calendrier/Tache/Tache.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class CalendrierDetail extends StatefulWidget {
  const CalendrierDetail({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  State<CalendrierDetail> createState() => _CalendrierDetailState();
}

String _baseUrl = "10.0.2.2:3000";
double _rating = 4.0;

class _CalendrierDetailState extends State<CalendrierDetail>
    with TickerProviderStateMixin {
  String description = "";
  String nomEvenement = "";
  String dateFin = "";
  String date = "";
  String dateDebut = "";
  bool tacheexiste = false;
  bool ismatch = false;
  bool hommematchexiste = false;
  bool ratingexiste = false;
  bool statsexiste = true;
  var _selected = "";
  bool shouldCheckDefault = false;
  bool shouldCheckDefault1 = false;
  bool shouldCheckDefault2 = false;
  bool shouldCheckDefault3 = false;
  var hommeDuMatchList = [];
  var noteDuMatchList = [];
  var liststat = [];
  late Future<bool> fetchedDocs;
  var data = [];
  var tachelist = [];
  int length_membre = 0;
  String referalcode = "";
  int tacheslength = 0;
  double percent = 0;
  int score1 = 0;
  int score2 = 0;
  String contre = "";
  String adves = "";
  bool composexiste = false;
  String nc = "";
  SharedPreferences? prefs;

  Future<bool> fetchDocs() async {
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8",
    };
    http.Response response = await http.get(
        Uri.parse("http://10.0.2.2:3000/api/evenements/" + '${widget.id}'),
        headers: headers);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(data);
      prefs = await SharedPreferences.getInstance();
      nc = prefs!.getString("nameClub")!;
      // compos existe
      if (data["composList"].length > 0) {
        composexiste = true;
      }
      // end compos
      //moyenne note
      // print(data);
      noteDuMatchList = (data["noteDuMatchList"]);

      for (var u in noteDuMatchList) {
        // print(u);
        if (u != 0) {
          setState(() {
            ratingexiste = true;
            _rating = double.parse(u);
          });
        }
      }
      // moyenne
      // choose homme du match
      hommeDuMatchList = (data["hommeDuMatchList"]);

      for (var u in hommeDuMatchList) {
        if (u != 0) {
          setState(() {
            hommematchexiste = true;
          });
        }
      }

      // tache
      tachelist = (data["taches"]);

      for (var u in tachelist) {
        if (u != 0) {
          setState(() {
            tacheexiste = true;
          });
        }
      }

      // end tache
      //score
          adves = data["nomAdversaire"];

      if (data["score1"] != null) {
        setState(() {
          shouldCheckDefault1 = true;
          percent = percent + 0.33;
          score1 = data["score1"];
          score2 = data["score2"];
        });
      }
      if (data["statistiques"].length != 0) {
        setState(() {
          shouldCheckDefault2 = true;
          shouldCheckDefault3 = true;
          percent = percent + 0.66;
        });
      }
      //endscore
      //nom des deux equipes
      // format
      contre = data["format"];
      // end format
      //date
      DateTime tempDatefin =
          new DateFormat("yyyy-MM-dd hh:mm:ss").parse(data["dateFin"]);

      final format = DateFormat('HH:mm ');
      final datef = format.format(tempDatefin);
      DateTime tempDatedebut =
          new DateFormat("yyyy-MM-dd hh:mm:ss").parse(data["dateDebut"]);

      final dated = format.format(tempDatedebut);

      DateTime tempDate = new DateFormat("yyyy-MM-dd").parse(data["dateDebut"]);
      DateFormat formatter = DateFormat('EEEE');
      DateFormat formatter1 = DateFormat('dd');
      String dayAbbr = formatter.format(tempDate);
      DateFormat formatter2 = DateFormat('MMMM');
      String dayAbbr2 = formatter2.format(tempDate);
      DateFormat formatter3 = DateFormat('yyyy');
      String dayAbbr3 = formatter3.format(tempDate);
      String dayAbbr1 = formatter1.format(tempDate);
      // print(dayAbbr2);
      setState(() {
        dateFin = datef;
        dateDebut = dated;
        date = dayAbbr + " " + dayAbbr1 + " " + dayAbbr2 + " " + dayAbbr3;
      });
      //end date
      // nombre des presents et des aabsents
      // description
      setState(() {
        description = data["description"];
      });
      // test if it s a simple event or a match
      if (data["type"] == "Match") {
        setState(() {
          ismatch = true;
        });
      } else {
        setState(() {
          nomEvenement = data["nomEvenement"];
        });
      }
    }

    return true;
  }

  var memberslist = [];
  Future<List> GetAllMembres() async {
    try {
      Map<String, String> headers = {
        "Content-Type": "application/json; charset=UTF-8",
      };
      var response = await http.get(
          Uri.parse(
              "http://10.0.2.2:3000/api/evenements/presence/" + '${widget.id}'),
          headers: headers);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        // if (data[0]["club"].length >0) {
        //   hasdata = true;
        //   print("bigger");
        // }
        // print(data[0]["evenement"].length);
        memberslist = [];
        //  print(data[0]["evenement"]);
        memberslist.add(data[0]["evenement"]);
        print(memberslist);
        return memberslist[0];
      } else {
        return Future.error("server error");
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<String> fetchDocs2(String id) async {
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8",
    };
    http.Response response = await http.get(
        Uri.parse("http://10.0.2.2:3000/api/membres/" + id),
        headers: headers);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      //  print(data );
      return data["nom"] + " " + data["prenom"];
    } else {
      return " ";
    }
  }

  Future<List> GetAllTaches() async {
    try {
      var response = await http.get(Uri.parse(
          "http://10.0.2.2:3000/api/evenements/tache/" + '${widget.id}'));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        // print("data");
        // print(data);
        // print(data[0]["evenement"]);
        setState(() {
          tacheslength = data[0]["evenement"].length;
        });
        return data[0]["evenement"];
      } else {
        return Future.error("server error");
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<int> GetTypes(String id) async {
    try {
      var response =
          await http.get(Uri.parse("http://10.0.2.2:3000/api/types/" + id));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        // print("data");
        // print(data["nomIcon"]);
        // print(data[0]["evenement"]);
        return data["nomIcon"];
      } else {
        return Future.error("server error");
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List> GetAllStats() async {
    try {
      var response = await http.get(Uri.parse(
          "http://10.0.2.2:3000/api/evenements/statistique/" + widget.id));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        liststat = data[0]["evenement"];
        print(liststat);
        return jsonDecode(response.body);
      } else {
        return Future.error("server error");
      }
    } catch (e) {
      return Future.error(e);
    }
  }

// everytime you modify you have to restart
  @override
  void initState() {
    GetAllMembres();
    GetAllStats();
    fetchedDocs = fetchDocs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          child: getAppBar(), preferredSize: const Size.fromHeight(50)),
      body: getBody(),
    );
  }

  Widget getAppBar() {
    return AppBar(
      centerTitle: true, // this is all you need

      elevation: 10,
      backgroundColor: const Color.fromARGB(255, 2, 0, 50),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Color.fromARGB(255, 255, 255, 255)),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        ).then((value) => setState(() {})),
      ),
      title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Align(
              alignment: Alignment.topLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Text(''),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                date,
                style: TextStyle(fontSize: 15),
              ),
            ),
            Spacer(),
            RawMaterialButton(
              constraints: BoxConstraints.tight(Size(26, 26)),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (c) => ParametresCalendrier(id: widget.id)));
              },
              child: IconTheme(
                data: IconThemeData(
                    color: Color.fromARGB(255, 255, 255, 255), size: 26),
                child: Icon(Icons.settings),
              ),
              shape: CircleBorder(),
            )
          ]),
    );
  }

  Widget getBody() {
    TabController _tabController = TabController(length: 4, vsync: this);
    int activeTabIndex = 1;
    return SingleChildScrollView(
        child: Column(children: [
      Column(children: <Widget>[
        Container(
            margin: EdgeInsets.only(left: 20, right: 10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  if (ismatch == true) ...[
                    Row(
                      children: [
                        Text(
                          nc,
                          style: TextStyle(
                              fontSize: 26,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.w500),
                        ),
                        Spacer(),
                        Text(
                          score1.toString(),
                          style: TextStyle(
                              fontSize: 26,
                              color: Color.fromARGB(255, 21, 255, 0),
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Row(
                      children: const [
                        Text(
                          "vs",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(255, 166, 166, 166),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Flexible(
                          child: Divider(
                            thickness: 0.5,
                            color: Color.fromARGB(255, 166, 166, 166),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          adves,
                          style: TextStyle(
                              fontSize: 26,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.w500),
                        ),
                        Spacer(),
                        Text(
                          score2.toString(),
                          style: TextStyle(
                              fontSize: 26,
                              color: Color.fromARGB(255, 21, 255, 0),
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ] else ...[
                    Row(
                      children: [
                        Text(
                          nomEvenement,
                          style: TextStyle(
                              fontSize: 26,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.w500),
                        ),
                        Spacer(),
                      ],
                    )
                  ],
                ])),
        TabBar(
            isScrollable: true, // new line

            controller: _tabController,
            labelColor: Color.fromARGB(255, 255, 255, 255),
            tabs: [
              Tab(
                child: Container(
                  width: 100,
                  height: 36,
                  child: Center(
                      child: Text("INFO",
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 12))),
                ),
              ),
              Tab(
                  child: Container(
                width: 110,
                height: 36,
                child: Center(
                    child: Text("JOUEURS",
                        style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 11))),
              )),
              Tab(
                  child: Container(
                width: 100,
                height: 36,
                child: Center(
                    child: Text("STATS",
                        style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 12))),
              )),
              Tab(
                  child: Container(
                width: 100,
                height: 36,
                child: Center(
                    child: Text("COMPO",
                        style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 12))),
              )),
            ]),
        Container(
            color: Color.fromARGB(255, 244, 244, 244),
            width: double.maxFinite,
            height: 530,
            child: TabBarView(controller: _tabController, children: [
              ListView.builder(
                  itemCount: 1,
                  itemBuilder: (_, index) {
                    return Container(
                        child: Column(children: [
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment(-0.9, 0),
                        child: Text(
                          "Joueur du match",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      // card
                      if (hommematchexiste == false) ...[
                        Container(
                            width: double.maxFinite,
                            height: 240,
                            margin: EdgeInsets.symmetric(vertical: 05),
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                child: Column(children: [
                                  Image.asset(
                                    "assets/yellowstar.png",
                                    height: (80),
                                    width: (80),
                                  ),
                                  Align(
                                    alignment: Alignment(-0.05, 0),
                                    child: Text(
                                      "Joueur du match",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Align(
                                    alignment: Alignment(-0.05, 0),
                                    child: Text(
                                      "Pour voir le résultat vous devez voter",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color:
                                            Color.fromARGB(255, 156, 156, 156),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                      width: 95,
                                      height: 40, // <-- Your width
                                      child: Container(
                                          child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HommeMatch(id: widget.id)),
                                          ).then((value) => setState(() {}));
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary:
                                              Color.fromARGB(199, 38, 208, 101),
                                        ),

                                        child: Text(
                                          "Voter",
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ), //label text,
                                      ))),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  new GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (c) => ForgetPass()));
                                    },
                                    child: new Text(
                                      "Voir le joueur du match",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color:
                                            Color.fromARGB(199, 38, 208, 101),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ]))),
                      ] else ...[
                        Container(
                          width: double.maxFinite,
                          margin: EdgeInsets.symmetric(vertical: 05),
                          padding: EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Column(children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 30.0,
                                  backgroundImage: NetworkImage(
                                      "https://www.simplilearn.com/ice9/free_resources_article_thumb/what_is_image_Processing.jpg"),
                                  backgroundColor: Colors.transparent,
                                ),
                                Positioned(
                                    bottom: -10,
                                    right: -10,
                                    child: RawMaterialButton(
                                      constraints:
                                          BoxConstraints.tight(Size(26, 26)),
                                      onPressed: () {},
                                      fillColor:
                                          Color.fromARGB(255, 255, 238, 57),
                                      child: IconTheme(
                                        data: IconThemeData(
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            size: 16),
                                        child: Icon(Icons.star),
                                      ),
                                      shape: CircleBorder(),
                                    )),
                              ],
                            ),
                            /*
                            "fetchDocs2(hommeDuMatchList[0].substring(
                                        0, hommeDuMatchList.indexOf(':'))).toString()",
                            */
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 7),
                              child: Column(
                                children: [
                                  FutureBuilder<String>(
                                      future: fetchDocs2(hommeDuMatchList[0]),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasError) {
                                          // print(snapshot);
                                        }
                                        if (!snapshot.hasData) {
                                          // still waiting for data to come
                                          return CircularProgressIndicator();
                                        } else if (snapshot.data == null) {
                                          // got data from snapshot but it is empty

                                          return Text("");
                                        } else {
                                          return Text(
                                            snapshot.data!,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          );
                                        }
                                      }),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    "1 voix sur 1 votants",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color:
                                            Color.fromARGB(255, 122, 122, 122)),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                        )
                      ],
                      // end of card
                      Align(
                        alignment: Alignment(-0.9, 0),
                        child: Text(
                          "Note du match",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      SizedBox(height: 3),
                      // card note begin
                      Container(
                          width: double.maxFinite,
                          height: ratingexiste ? 120 : 180,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Container(
                              padding: const EdgeInsets.only(
                                top: 20,
                              ),
                              child: Column(children: [
                                if (ratingexiste == false) ...[
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Align(
                                          alignment: Alignment.center,
                                          child: RatingBar.builder(
                                            initialRating: 4,
                                            ignoreGestures: true,
                                            minRating: 1,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemSize: 26,
                                            itemBuilder: (context, _) =>
                                                const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            onRatingUpdate: (rating) {},
                                          ),
                                        ),
                                      ]),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Align(
                                    alignment: Alignment(-0.05, 0),
                                    child: Text(
                                      "Note du match",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Align(
                                    alignment: Alignment(-0.05, 0),
                                    child: Text(
                                      "Pour voir le résultat vous devez voter",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color:
                                            Color.fromARGB(255, 156, 156, 156),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                      width: 95,
                                      height: 40, // <-- Your width
                                      child: Container(
                                          // padding: EdgeInsets.only(top: 30),
                                          child: ElevatedButton(
                                        onPressed: () {
                                          _displayDialogRating(context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary:
                                              Color.fromARGB(199, 38, 208, 101),
                                        ),

                                        child: Text(
                                          "Noter",
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ), //label text,
                                      ))),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  new GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (c) => ForgetPass()));
                                    },
                                    child: new Text(
                                      "Voir la note du match",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color:
                                            Color.fromARGB(199, 38, 208, 101),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ] else ...[
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Align(
                                          alignment: Alignment.center,
                                          child: RatingBar.builder(
                                            initialRating: _rating,
                                            minRating: 1,
                                            ignoreGestures: true,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemSize: 26,
                                            itemBuilder: (context, _) =>
                                                const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            onRatingUpdate: (rating) {
                                              print(rating);
                                            },
                                          ),
                                        ),
                                      ]),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Align(
                                    alignment: Alignment(-0.05, 0),
                                    child: Text(
                                      _rating.toString(),
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Align(
                                    alignment: Alignment(-0.05, 0),
                                    child: Text(
                                      _rating == 5
                                          ? "Match exceptionnel"
                                          : _rating == 4
                                              ? "Bon match"
                                              : _rating == 3
                                                  ? "Moyen match"
                                                  : "Mauvais match",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color:
                                            Color.fromARGB(255, 169, 169, 169),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ]
                              ]))),
                      // end of  card note
                      SizedBox(
                        height: 6,
                      ),
                      Align(
                        alignment: Alignment(-0.9, 0),
                        child: Text(
                          "Match",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      // card match
                      Container(
                          width: double.maxFinite,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Container(
                              padding: const EdgeInsets.only(
                                top: 20,
                              ),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(children: const [
                                      SizedBox(
                                        width: 6,
                                      ),
                                      IconTheme(
                                        data: IconThemeData(
                                            color: Color.fromARGB(
                                                255, 187, 187, 187),
                                            size: 18),
                                        child: Icon(Icons.info_outline),
                                      ),
                                      Text(
                                        "Tunisienne - ",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color.fromARGB(
                                              255, 201, 201, 201),
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Text(
                                        " J25",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color.fromARGB(
                                              255, 201, 201, 201),
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ]),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 6,
                                        ),
                                        Text(
                                          "Début à :",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        Text(
                                          dateDebut,
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 6,
                                        ),
                                        Text(
                                          "Fin à :",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontSize: 17,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        Text(
                                          dateFin,
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontSize: 17,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    )
                                  ]))),
                      // end of card match
                      SizedBox(
                        height: 6,
                      ),
                      /*
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Align(
                              alignment: Alignment(-0.9, 0),
                              child: Text(
                                "Taches assignées (" +
                                    tacheslength.toString() +
                                    ")",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Spacer(),
                            if (tacheexiste == true) ...[
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DisplayTaches(id: widget.id)),
                                  ).then((value) => setState(() {}));
                                },
                                child: new Text(
                                  "Voir tout",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(198, 167, 167, 167),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ]
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      // begin card tache
                      Container(
                          width: double.maxFinite,
                          height: tacheexiste ? 100 : 220,
                          margin: EdgeInsets.symmetric(vertical: 10),
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: Column(children: [
                                if (tacheexiste == false) ...[
                                  Stack(
                                    children: [
                                      Image.asset(
                                        "assets/tasksicon.jpg",
                                        height: (60),
                                        width: (60),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Align(
                                    alignment: Alignment(-0.05, 0),
                                    child: Text(
                                      "Assigner une tache",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Align(
                                    alignment: Alignment(-0.05, 0),
                                    child: Text(
                                      "Assigner une tache à une ou plusieurs personnes pour cet événement",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color:
                                            Color.fromARGB(255, 156, 156, 156),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                      width: 110,
                                      height: 40,
                                      child: Container(
                                          child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Tache(
                                                      text: "",
                                                      id: widget.id,
                                                      idtype: "",
                                                    )),
                                          ).then((value) => setState(() {}));
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary:
                                              Color.fromARGB(199, 38, 208, 101),
                                        ),

                                        child: Text(
                                          "C'est parti",
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ), //label text,
                                      ))),
                                ] else ...[
                                  Container(
                                      height: 76.0,
                                      child: FutureBuilder<List>(
                                          future: GetAllTaches(),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasError) {}
                                            if (!snapshot.hasData) {
                                              return CircularProgressIndicator();
                                            } else if (snapshot.data == null) {
                                              return SizedBox();
                                            } else {
                                              return ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  shrinkWrap: true,
                                                  itemCount:
                                                      snapshot.data!.length,
                                                  itemBuilder:
                                                      (BuildContext ctxt,
                                                          int i) {
                                                    return SingleChildScrollView(
                                                      child: Row(
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Stack(
                                                                children: [
                                                                  CircleAvatar(
                                                                    radius:
                                                                        30.0,
                                                                    backgroundImage:
                                                                        NetworkImage(
                                                                            "https://www.simplilearn.com/ice9/free_resources_article_thumb/what_is_image_Processing.jpg"),
                                                                    backgroundColor:
                                                                        Colors
                                                                            .transparent,
                                                                  ),
                                                                  Container(
                                                                    child: FutureBuilder<
                                                                            int>(
                                                                        future: GetTypes(snapshot.data![i]
                                                                            [
                                                                            "type"]),
                                                                        builder:
                                                                            (context,
                                                                                snapshot1) {
                                                                          if (snapshot1
                                                                              .hasError) {}
                                                                          if (!snapshot1
                                                                              .hasData) {
                                                                            return CircularProgressIndicator();
                                                                          } else if (snapshot1.data ==
                                                                              null) {
                                                                            // got data from snapshot but it is empty

                                                                            return SizedBox();
                                                                          } else {
                                                                            return Positioned(
                                                                                bottom: -10,
                                                                                right: -35,
                                                                                child: RawMaterialButton(
                                                                                  onPressed: () {},
                                                                                  // elevation: 2.0,
                                                                                  fillColor: Color.fromARGB(255, 255, 255, 255),
                                                                                  child: Icon(IconData(snapshot1.data!, fontFamily: 'MaterialIcons')),
                                                                                  padding: EdgeInsets.all(1.0),
                                                                                  shape: CircleBorder(),
                                                                                ));
                                                                          }
                                                                        }),
                                                                  ),
                                                                ],
                                                              ),
                                                              FutureBuilder<
                                                                      String>(
                                                                  future: fetchDocs2(
                                                                      snapshot.data![i]
                                                                              [
                                                                              "membres1"]
                                                                          [0]),
                                                                  builder: (context,
                                                                      snapshot1) {
                                                                    if (snapshot1
                                                                        .hasError) {
                                                                      // print(snapshot);
                                                                    }
                                                                    if (!snapshot1
                                                                        .hasData) {
                                                                      return CircularProgressIndicator();
                                                                    } else if (snapshot1
                                                                            .data ==
                                                                        null) {
                                                                      return SizedBox();
                                                                    } else {
                                                                      return Text(
                                                                        snapshot1
                                                                            .data!,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                14),
                                                                      );
                                                                    }
                                                                  }),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  });
                                            }
                                          })),
                                ]
                              ]))),
                      SizedBox(
                        height: 6,
                      ),
                      Align(
                        alignment: Alignment(-0.9, 0),
                        child: Text(
                          "Description",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                          width: double.maxFinite,
                          margin: EdgeInsets.symmetric(vertical: 10),
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: Column(children: [
                                Align(
                                  alignment: Alignment(-1, 0),
                                  child: Text(
                                    description,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                ),
                              ]))),
                      // end card
                      SizedBox(
                        height: 6,
                      ),
                      Align(
                        alignment: Alignment(-0.9, 0),
                        child: Text(
                          "Participants",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      // begin card description
                      Container(
                          width: double.maxFinite,
                          margin: EdgeInsets.symmetric(vertical: 10),
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: Column(children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        Align(
                                          alignment: Alignment(-1, 0),
                                          child: Text(
                                            "0",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Color.fromARGB(
                                                  255, 148, 148, 148),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment(-1, 0),
                                          child: Text(
                                            "Présent",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Color.fromARGB(
                                                  255, 148, 148, 148),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Align(
                                          alignment: Alignment(-1, 0),
                                          child: Text(
                                            "1",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Color.fromARGB(
                                                  255, 148, 148, 148),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment(-1, 0),
                                          child: Text(
                                            "Absent",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Color.fromARGB(
                                                  255, 148, 148, 148),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ]))),*/
                    ]));
                  }),
              ListView.builder(
                  itemCount: 1,
                  itemBuilder: (_, index) {
                    return Column(children: [
                      SizedBox(
                        height: 10,
                      ),
                      //  gerer les presences
                      Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: Column(children: [
                                Row(
                                  children: [
                                    IconTheme(
                                      data: IconThemeData(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          size: 22),
                                      child: Icon(
                                          Icons.supervised_user_circle_rounded),
                                    ),
                                    Spacer(),
                                    Align(
                                      child: Text(
                                        "Gérer les présences",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                        alignment: Alignment(0, 1),
                                        child: SizedBox.fromSize(
                                          child: ClipOval(
                                            child: Material(
                                              color: Color.fromARGB(
                                                      255, 142, 142, 142)
                                                  .withOpacity(0.0),
                                              child: InkWell(
                                                splashColor: Color.fromARGB(
                                                    255, 248, 248, 248),
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Presence(
                                                                id: widget.id)),
                                                  ).then((value) =>
                                                      setState(() {}));
                                                },
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    IconTheme(
                                                      data: IconThemeData(
                                                          color: Color.fromARGB(
                                                              255,
                                                              187,
                                                              187,
                                                              187),
                                                          size: 18),
                                                      child: Icon(Icons
                                                          .arrow_forward_ios),
                                                    ),
                                                    // <-- Icon
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
                              ]))),
                      Column(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Align(
                            alignment: Alignment(-0.9, 0),
                            child: Text(
                              "Absent(1)",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          //  gerer les presences
                          FutureBuilder<List>(
                              future: GetAllMembres(),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {}
                                if (!snapshot.hasData) {
                                  return CircularProgressIndicator();
                                } else if (snapshot.data == null) {
                                  return Text("context");
                                } else {
                                  return ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, i) {
                                        String name = snapshot.data![i]
                                            .substring(
                                                snapshot.data![i].indexOf(':') +
                                                    1);
                                        return Container(
                                            width: double.maxFinite,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                            ),
                                            child: Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10),
                                                child: Column(children: [
                                                  Row(
                                                    children: [
                                                      CircleAvatar(
                                                        radius: 30.0,
                                                        backgroundImage:
                                                            NetworkImage(
                                                                "https://www.simplilearn.com/ice9/free_resources_article_thumb/what_is_image_Processing.jpg"),
                                                        backgroundColor:
                                                            Colors.transparent,
                                                      ),
                                                      SizedBox(
                                                        width: 15,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          FutureBuilder<String>(
                                                              future: fetchDocs2(snapshot
                                                                  .data![i]
                                                                  .substring(
                                                                      0,
                                                                      snapshot
                                                                          .data![
                                                                              i]
                                                                          .indexOf(
                                                                              ':'))),
                                                              builder: (context,
                                                                  snapshot) {
                                                                if (snapshot
                                                                    .hasError) {
                                                                  // print(snapshot);
                                                                }
                                                                if (!snapshot
                                                                    .hasData) {
                                                                  return CircularProgressIndicator();
                                                                } else if (snapshot
                                                                        .data ==
                                                                    null) {
                                                                  return Text(
                                                                      "context");
                                                                } else {
                                                                  return Align(
                                                                    child: Text(
                                                                      snapshot
                                                                          .data!,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                          fontWeight:
                                                                              FontWeight.w400),
                                                                    ),
                                                                  );
                                                                }
                                                              }),
                                                          Align(
                                                            child: Text(
                                                              name,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                color: name ==
                                                                        "A l'heure"
                                                                    ? Color
                                                                        .fromARGB(
                                                                            199,
                                                                            38,
                                                                            208,
                                                                            101)
                                                                    : name ==
                                                                            "Retard"
                                                                        ? Color.fromARGB(
                                                                            255,
                                                                            255,
                                                                            162,
                                                                            0)
                                                                        : name ==
                                                                                "excusé"
                                                                            ? Color.fromARGB(
                                                                                255,
                                                                                255,
                                                                                0,
                                                                                0)
                                                                            : name == "Non excusé"
                                                                                ? Color.fromARGB(255, 255, 0, 0)
                                                                                : name == "Blessé"
                                                                                    ? Color.fromARGB(198, 218, 218, 218)
                                                                                    : Color.fromARGB(198, 218, 218, 218),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Spacer(),
                                                      Container(
                                                          alignment:
                                                              Alignment(0, 1),
                                                          child:
                                                              SizedBox.fromSize(
                                                            child: ClipOval(
                                                              child: Material(
                                                                color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            142,
                                                                            142,
                                                                            142)
                                                                    .withOpacity(
                                                                        0.0),
                                                                child: InkWell(
                                                                  splashColor: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          248,
                                                                          248,
                                                                          248),
                                                                  onTap: () {
                                                                    showModalBottomSheet(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return Wrap(
                                                                            children: [
                                                                              Container(
                                                                                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                                                                  child: Column(
                                                                                    children: [
                                                                                      Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly, // use whichever suits your need
                                                                                        children: [
                                                                                          SizedBox(
                                                                                              width: 155,
                                                                                              height: 40, // <-- Your width
                                                                                              child: Container(
                                                                                                  child: ElevatedButton(
                                                                                                onPressed: () {
                                                                                                  UpdateMembre(snapshot, i, "A l'heure");
                                                                                                  Navigator.of(context).pop();
                                                                                                },
                                                                                                style: ElevatedButton.styleFrom(
                                                                                                  primary: Color.fromARGB(199, 38, 208, 101),
                                                                                                ),

                                                                                                child: Text(
                                                                                                  "A l'heure",
                                                                                                  style: TextStyle(
                                                                                                    fontSize: 15,
                                                                                                    color: Color.fromARGB(255, 255, 255, 255),
                                                                                                    fontWeight: FontWeight.w400,
                                                                                                  ),
                                                                                                ), //label text,
                                                                                              ))),
                                                                                          SizedBox(
                                                                                              width: 155,
                                                                                              height: 40,
                                                                                              child: Container(
                                                                                                  child: ElevatedButton(
                                                                                                onPressed: () {
                                                                                                  UpdateMembre(snapshot, i, "Retard");
                                                                                                  Navigator.of(context).pop();
                                                                                                },
                                                                                                style: ElevatedButton.styleFrom(
                                                                                                  primary: Color.fromARGB(255, 255, 162, 0),
                                                                                                ),
                                                                                                child: Text(
                                                                                                  "Retard",
                                                                                                  style: TextStyle(
                                                                                                    fontSize: 15,
                                                                                                    color: Color.fromARGB(255, 255, 255, 255),
                                                                                                    fontWeight: FontWeight.w400,
                                                                                                  ),
                                                                                                ),
                                                                                              ))),
                                                                                        ],
                                                                                      ),
                                                                                      SizedBox(
                                                                                        height: 10,
                                                                                      ),
                                                                                      Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly, // use whichever suits your need
                                                                                        children: [
                                                                                          SizedBox(
                                                                                              width: 155,
                                                                                              height: 40,
                                                                                              child: Container(
                                                                                                  child: ElevatedButton(
                                                                                                onPressed: () {
                                                                                                  UpdateMembre(snapshot, i, "Excusé");
                                                                                                  Navigator.of(context).pop();
                                                                                                },
                                                                                                style: ElevatedButton.styleFrom(
                                                                                                  primary: Color.fromARGB(198, 255, 0, 0),
                                                                                                ),
                                                                                                child: Text(
                                                                                                  "Excusé",
                                                                                                  style: TextStyle(
                                                                                                    fontSize: 15,
                                                                                                    color: Color.fromARGB(255, 255, 255, 255),
                                                                                                    fontWeight: FontWeight.w400,
                                                                                                  ),
                                                                                                ),
                                                                                              ))),
                                                                                          SizedBox(
                                                                                              width: 155,
                                                                                              height: 40,
                                                                                              child: Container(
                                                                                                  child: ElevatedButton(
                                                                                                onPressed: () {
                                                                                                  UpdateMembre(snapshot, i, "Non excusé");
                                                                                                  Navigator.of(context).pop();
                                                                                                },
                                                                                                style: ElevatedButton.styleFrom(
                                                                                                  primary: Color.fromARGB(198, 255, 0, 0),
                                                                                                ),
                                                                                                child: Text(
                                                                                                  "Non excusé",
                                                                                                  style: TextStyle(
                                                                                                    fontSize: 15,
                                                                                                    color: Color.fromARGB(255, 255, 255, 255),
                                                                                                    fontWeight: FontWeight.w400,
                                                                                                  ),
                                                                                                ),
                                                                                              ))),
                                                                                        ],
                                                                                      ),
                                                                                      SizedBox(
                                                                                        height: 10,
                                                                                      ),
                                                                                      Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly, // use whichever suits your need
                                                                                        children: [
                                                                                          SizedBox(
                                                                                              width: 155,
                                                                                              height: 40,
                                                                                              child: Container(
                                                                                                  child: ElevatedButton(
                                                                                                onPressed: () {
                                                                                                  UpdateMembre(snapshot, i, "Blessé");
                                                                                                  Navigator.of(context).pop();
                                                                                                },
                                                                                                style: ElevatedButton.styleFrom(
                                                                                                  primary: Color.fromARGB(198, 218, 218, 218),
                                                                                                ),
                                                                                                child: Text(
                                                                                                  "Blessé",
                                                                                                  style: TextStyle(
                                                                                                    fontSize: 15,
                                                                                                    color: Color.fromARGB(255, 255, 255, 255),
                                                                                                    fontWeight: FontWeight.w400,
                                                                                                  ),
                                                                                                ),
                                                                                              ))),
                                                                                          StatefulBuilder(builder: (BuildContext context, StateSetter state) {
                                                                                            return SizedBox(
                                                                                                width: 155,
                                                                                                height: 40, // <-- Your width
                                                                                                child: Container(
                                                                                                    child: ElevatedButton(
                                                                                                  onPressed: () {
                                                                                                    UpdateMembre(snapshot, i, "Non convoqué");
                                                                                                    Navigator.of(context).pop();
                                                                                                  },
                                                                                                  style: ElevatedButton.styleFrom(
                                                                                                    primary: Color.fromARGB(198, 218, 218, 218),
                                                                                                  ),

                                                                                                  child: Text(
                                                                                                    "Non convoqué",
                                                                                                    style: TextStyle(
                                                                                                      fontSize: 15,
                                                                                                      color: Color.fromARGB(255, 255, 255, 255),
                                                                                                      fontWeight: FontWeight.w400,
                                                                                                    ),
                                                                                                  ), //label text,
                                                                                                )));
                                                                                          }),
                                                                                        ],
                                                                                      )
                                                                                    ],
                                                                                  ))
                                                                            ]);
                                                                      },
                                                                    );
                                                                  },
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: <
                                                                        Widget>[
                                                                      IconTheme(
                                                                        data: IconThemeData(
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                0,
                                                                                0,
                                                                                0),
                                                                            size:
                                                                                28),
                                                                        child: Icon(
                                                                            Icons.more_vert),
                                                                      ),
                                                                      // <-- Icon
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          )),
                                                    ],
                                                  ),
                                                ])));
                                      });
                                }
                              })
                        ],
                      ),
                      // end gestion
                      SizedBox(height: 20),
                    ]);
                  }),
              ListView.builder(
                  itemCount: 1,
                  itemBuilder: (_, index) {
                    return Container(
                        color: Colors.white,
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        child: Column(children: [
                          if (statsexiste == false) ...[
                            Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 55),
                                child: Column(children: [
                                  Image.asset(
                                    "assets/stats-icon.png",
                                    height: (80),
                                    width: (80),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Align(
                                    alignment: Alignment(-0.05, 0),
                                    child: Text(
                                      "Aucun Joueur trouvé",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                ]))
                          ] else ...[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment(-1, 0),
                                child: Text(
                                  "Renseignez les stats",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Align(
                                alignment: Alignment(-1, 0),
                                child: Text(
                                  "Renseignez le score du match et les principales actions des participants",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color.fromARGB(255, 175, 175, 175),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  child: LinearPercentIndicator(
                                    width: 330,
                                    animation: true,
                                    percent: percent,
                                    animationDuration: 1,
                                    lineHeight: 5,
                                    backgroundColor:
                                        Color.fromARGB(255, 218, 218, 218),
                                    progressColor: const Color.fromARGB(
                                        255, 130, 240, 134),
                                    barRadius: const Radius.circular(16),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                children: [
                                  CustomCheckBox(
                                    checkBoxSize: 20,
                                    value: shouldCheckDefault1,
                                    splashColor: Color.fromARGB(255, 12, 248, 0)
                                        .withOpacity(0.4),
                                    tooltip: 'Custom Check Box',
                                    splashRadius: 40,
                                    onChanged: (bool value) {},
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Score",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        "Editez le score final",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color.fromARGB(
                                              255, 180, 180, 180),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  RawMaterialButton(
                                    constraints:
                                        BoxConstraints.tight(Size(26, 26)),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (c) =>
                                                  GeneralStats(id: widget.id)))
                                          .then((value) => setState(() {}));
                                    },
                                    child: IconTheme(
                                      data: IconThemeData(
                                          color: Color.fromARGB(
                                              255, 197, 197, 197),
                                          size: 16),
                                      child: Icon(Icons.arrow_forward_ios),
                                    ),
                                    shape: CircleBorder(),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                children: [
                                  CustomCheckBox(
                                    checkBoxSize: 20,
                                    value: shouldCheckDefault2,
                                    splashColor: Color.fromARGB(255, 12, 248, 0)
                                        .withOpacity(0.4),
                                    tooltip: 'Custom Check Box',
                                    splashRadius: 40,
                                    onChanged: (bool value) {},
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Stats des joueurs",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        "Editez les stats des joueurs",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color.fromARGB(
                                              255, 180, 180, 180),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  RawMaterialButton(
                                    constraints:
                                        BoxConstraints.tight(Size(26, 26)),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (c) =>
                                                  ChooseStat(id: widget.id)));
                                    },
                                    child: IconTheme(
                                      data: IconThemeData(
                                          color: Color.fromARGB(
                                              255, 197, 197, 197),
                                          size: 16),
                                      child: Icon(Icons.arrow_forward_ios),
                                    ),
                                    shape: CircleBorder(),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                children: [
                                  CustomCheckBox(
                                    checkBoxSize: 20,
                                    value: shouldCheckDefault3,
                                    splashColor: Color.fromARGB(255, 12, 248, 0)
                                        .withOpacity(0.4),
                                    tooltip: 'Custom Check Box',
                                    splashRadius: 40,
                                    onChanged: (bool value) {},
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Notes des joueurs",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        "Notez chaque joueurs",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color.fromARGB(
                                              255, 180, 180, 180),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  RawMaterialButton(
                                    constraints:
                                        BoxConstraints.tight(Size(26, 26)),
                                    onPressed: () {
                                      ///working here
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Note(id: widget.id)),
                                      ).then((value) => setState(() {}));
                                    },
                                    child: IconTheme(
                                      data: IconThemeData(
                                          color: Color.fromARGB(
                                              255, 197, 197, 197),
                                          size: 16),
                                      child: Icon(Icons.arrow_forward_ios),
                                    ),
                                    shape: CircleBorder(),
                                  )
                                ],
                              ),
                            ),
                            CreateTable(),
                          ],
                        ]));
                  }),
              ListView.builder(
                  itemCount: 1,
                  itemBuilder: (_, index) {
                    return Container(
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        child: Column(children: [
                          Container(
                              margin: const EdgeInsets.symmetric(vertical: 55),
                              child: Column(children: [
                                Image.asset(
                                  "assets/squad.PNG",
                                  height: (150),
                                  width: (150),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Align(
                                  alignment: Alignment(-0.05, 0),
                                  child: Text(
                                    composexiste
                                        ? "Tapez pour voir le compo"
                                        : "Pas de composition",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Align(
                                  alignment: Alignment(-0.05, 0),
                                  child: Text(
                                    composexiste
                                        ? "Tapez pour voir le compo"
                                        : "Aucun compo n'est actuellement disponible",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 155, 155, 155),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Align(
                                  alignment: Alignment(-0.05, 0),
                                  child: Text(
                                    "Note  : une composition s'effectue avec les joueurs marqués comme présent. En considérant le format du match, il manque actuellement 11 joueur(s)(sur 11) pour réaliser une compo complète",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 248, 112, 0),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                SizedBox(
                                    width: 165,
                                    height: 40, // <-- Your width
                                    child: Container(
                                        // padding: EdgeInsets.only(top: 30),
                                        child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (c) => AddCompos(
                                                    number: contre,
                                                    id: widget.id)));
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary:
                                            Color.fromARGB(199, 38, 208, 101),
                                      ),
                                      child: Text(
                                        composexiste
                                            ? "Voir le compo"
                                            : "Créer une compo",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ))),
                              ]))
                        ]));
                  }),
            ]))
      ])
    ]));
  }

  void UpdateMembre(AsyncSnapshot<List<dynamic>> snapshot, int i, String name) {
    for (int J = 0; J < memberslist[0].length; J++) {
      if (memberslist[0][J] == snapshot.data![i]) {
        setState(() {
          memberslist[0][J] =
              snapshot.data![i].substring(0, snapshot.data![i].indexOf(':')) +
                  ":" +
                  name;
          Map<String, dynamic> userData = {"presenceList": memberslist[0]};

          Map<String, String> headers = {
            "Content-Type": "application/json; charset=UTF-8"
          };

          http
              .put(Uri.http(_baseUrl, "/api/evenements/" + '${widget.id}'),
                  headers: headers, body: json.encode(userData))
              .then((http.Response response) async {
            // print(userData);
            if (response.statusCode == 200) {
              //    Navigator.of(context).pop();
            } else if (response.statusCode == 401) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const AlertDialog(
                      title: Text("Information"),
                      content: Text("Username et/ou mot de passe incorrect"),
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
        });
      }
    }
  }

  _displayDialogRating(BuildContext context) async {
    _selected = await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter state) {
          return Container(
            child: Column(
              children: [
                Expanded(
                  child: SimpleDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0))),
                    title: Align(
                      alignment: Alignment(0, 0),
                      child: Text(
                        "Note du match",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    children: [
                      Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                          ),
                          child: Column(children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: RatingBar.builder(
                                      initialRating: 5,
                                      minRating: 1,
                                      itemCount: 5,
                                      itemSize: 16,
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating) {
                                        state(() {
                                          _rating = rating;
                                        });
                                      },
                                    ),
                                  ),
                                ]),
                            SizedBox(
                              height: 16,
                            ),
                            Align(
                              alignment: Alignment(0, 0),
                              child: Text(
                                _rating.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 176, 176, 176),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 180, top: 20),
                              child: GestureDetector(
                                onTap: () async {
                                  Map<String, dynamic> userData = {
                                    "noteDuMatchList": _rating
                                  };

                                  Map<String, String> headers = {
                                    "Content-Type":
                                        "application/json; charset=UTF-8"
                                  };

                                  http
                                      .put(
                                          Uri.http(
                                              _baseUrl,
                                              "/api/evenements/" +
                                                  '${widget.id}'),
                                          headers: headers,
                                          body: json.encode(userData))
                                      .then((http.Response response) async {
                                    if (response.statusCode == 200) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CalendrierDetail(
                                                    id: widget.id)),
                                      ).then((value) => setState(() {}));
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
                                },
                                child: Align(
                                  alignment: Alignment(0, 0),
                                  child: new Text(
                                    "Valider",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Color.fromARGB(255, 104, 199, 87),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ]))
                    ],
                    elevation: 10,
                  ),
                ),
              ],
            ),
          );
        });
      },
    );

    if (_selected != null) {
      setState(() {
        _selected = _selected;
      });
    }
  }

  Widget CreateTable() {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 75.0,
          columns: [
            DataColumn(label: Text('')),
            DataColumn(label: Text('Note')),
            DataColumn(label: Text('But')),
            DataColumn(label: Text('assists')),
            DataColumn(label: Text('tempsJouee')),
            DataColumn(label: Text('cartonJaune')),
            DataColumn(label: Text('cartonRouge')),
          ],
          rows: liststat
              .map((e) => DataRow(cells: [
                    DataCell(Container(
                        child: Center(
                      child: Row(children: [
                        CircleAvatar(
                          radius: 20.0,
                          backgroundImage: NetworkImage(
                              "https://www.simplilearn.com/ice9/free_resources_article_thumb/what_is_image_Processing.jpg"),
                          backgroundColor: Colors.transparent,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        // Text(e["name"]),
                        FutureBuilder<String>(
                            future: fetchDocs2(e["membre"]),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                // print(snapshot);
                              }
                              if (!snapshot.hasData) {
                                // still waiting for data to come
                                return CircularProgressIndicator();
                              } else if (snapshot.data == null) {
                                // got data from snapshot but it is empty

                                return Text("context");
                              } else {
                                // print("snap");
                                // print(snapshot
                                //     .data);
                                return Align(
                                  child: Text(
                                    snapshot.data!,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontWeight: FontWeight.w400),
                                  ),
                                );
                              }
                            }),
                      ]),
                    ))),
                    DataCell(Container(
                      child: Text(e["note"]),
                    )),
                    DataCell(Container(
                      child: Text(e["buts"]),
                    )),
                    DataCell(Container(
                      child: Text(e["assists"]),
                    )),
                    DataCell(Container(
                      child: Text(e["tempsJouee"]),
                    )),
                    DataCell(Container(
                      child: Text(e["cartonJaune"]),
                    )),
                    DataCell(Container(
                      child: Text(e["cartonRouge"]),
                    )),
                  ]))
              .toList(),
        ));
  }
}
