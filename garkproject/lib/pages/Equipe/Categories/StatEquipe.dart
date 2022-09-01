import 'dart:convert';

import 'package:d_chart/d_chart.dart';
import 'package:dynamic_icons/dynamic_icons.dart';
import 'package:flutter/material.dart';
import 'package:garkproject/data/TacheAssigneddata.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class StatEquipe extends StatefulWidget {
  const StatEquipe({Key? key, required this.idequipe}) : super(key: key);
  final String idequipe;
  @override
  State<StatEquipe> createState() => _StatEquipeState();
}

var _selected = "";
var itemsevent = [
  'Tous les evenements',
  'Nouveau championnat',
  'Match entre nous',
  'Match amical',
];
String? dropdownevent;
String cn = "";
SharedPreferences? prefs;

class _StatEquipeState extends State<StatEquipe> {
  num nbv = 0;
  num nbe = 0;
  num nbd = 0;
  num bm = 0;
  num be = 0;
  var lister = [];
  var liste = [];
  Future<List> GetAllEvent() async {
    try {
      prefs = await SharedPreferences.getInstance();
      cn = prefs!.getString("participantClub")!;
      Map<String, String> headers = {
        "Content-Type": "application/json; charset=UTF-8",
      };
      var response = await http.get(
          Uri.parse(
              "http://10.0.2.2:3000/api/equipes/event/" + widget.idequipe),
          headers: headers);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        nbv = 0;
        nbe = 0;
        nbd = 0;
        bm = 0;
        be = 0;
        liste = [];
        lister = [];
        liste = data[0]["equipe"];
        print("za");
        print(liste.length);
        for (int i = 0; i < liste.length; i++) {
          if ((liste[i]["score1"] > liste[i]["score2"]) &&
              (liste[i]["nomEvenement"] == dropdownevent ||
                  dropdownevent == null)) {
            setState(() {
              nbv++;
              bm = bm + liste[i]["score1"];
              be = be + liste[i]["score2"];
              lister.add("V");
            });
          }
          if (liste[i]["score1"] == liste[i]["score2"] &&
              (liste[i]["nomEvenement"] == dropdownevent ||
                  dropdownevent == null)) {
            setState(() {
              nbe++;
              bm = bm + liste[i]["score1"];
              be = be + liste[i]["score2"];

              lister.add("E");
            });
          }
          if (liste[i]["score1"] < liste[i]["score2"] &&
              (liste[i]["nomEvenement"] == dropdownevent ||
                  dropdownevent == null)) {
            setState(() {
              nbd++;
              bm = bm + liste[i]["score1"];
              be = be + liste[i]["score2"];

              lister.add("D");
            });
          }
        }
        return data[0]["equipe"];
      } else {
        return Future.error("server error");
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  void initState() {
    super.initState();
    GetAllEvent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 235, 235, 235),
      appBar: PreferredSize(
          child: getAppBar(), preferredSize: const Size.fromHeight(50)),
      body: getBody(),
    );
  }

  Widget getAppBar() {
    return AppBar(
      elevation: 10,
      centerTitle: true, // this is all you need

      backgroundColor: const Color.fromARGB(255, 2, 0, 50),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Color.fromARGB(255, 255, 255, 255)),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Spacer(),
            Text(
              "Stats équipe",
              style: TextStyle(),
            ),
            Spacer(),
            RawMaterialButton(
              constraints: BoxConstraints.tight(Size(26, 26)),
              onPressed: () {
                _displayDialog(context);
              },
              child: IconTheme(
                data: IconThemeData(
                    color: Color.fromARGB(255, 218, 218, 218), size: 26),
                child: Icon(Icons.filter_alt_outlined),
              ),
            ),
          ]),
    );
  }

  Widget getBody() {
    return SingleChildScrollView(
        child: Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Center(
          child: Image.asset(
            "assets/tshirt.PNG",
            height: (60),
            width: (60),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Center(
            child: Text(
          dropdownevent ?? "Tous les évènements",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
        )),
        Center(child: Text("Saison 2021-2022")),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "Résultats",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
          ),
        ),
        if (dropdownevent == null) ...[
          Container(
              height: 180,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment(0, -0.5),
                    child: Text(
                      liste.length.toString(),
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 34,
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(0, -0.5),
                    child: Text(
                      "match joué",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 139, 139, 139),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Row(
                    children: [
                      Spacer(),
                      SizedBox(
                        height: 70,
                        width: 70,
                        child: Stack(fit: StackFit.expand, children: [
                          CircularProgressIndicator(
                            value: liste.length == 0 ? 0 : (nbv) / liste.length,
                            backgroundColor: Colors.grey,
                            color: Colors.green,
                            strokeWidth: 8,
                          ),
                          Center(
                              child: Text(
                            nbv.toString() + "\nvictoires",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                        ]),
                      ),
                      Spacer(),
                      SizedBox(
                        height: 70,
                        width: 70,
                        child: Stack(fit: StackFit.expand, children: [
                          CircularProgressIndicator(
                            value: liste.length == 0 ? 0 : (nbe) / liste.length,
                            backgroundColor: Colors.grey,
                            color: Colors.black,
                            strokeWidth: 8,
                          ),
                          Center(
                              child: Text(
                            nbe.toString() + "\nnull",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                        ]),
                      ),
                      Spacer(),
                      SizedBox(
                        height: 70,
                        width: 70,
                        child: Stack(fit: StackFit.expand, children: [
                          CircularProgressIndicator(
                            value: liste.length == 0 ? 0 : (nbd) / liste.length,
                            backgroundColor: Colors.grey,
                            color: Colors.red,
                            strokeWidth: 8,
                          ),
                          Center(
                              child: Text(
                            nbd.toString() + "\ndefaites",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                        ]),
                      ),
                      Spacer(),
                    ],
                  )
                ],
              )),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Résultats",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
            ),
          ),
          Container(
              height: 130,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 32.0),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment(0, -0.5),
                          child: Text(
                            bm.toString(),
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 34,
                              color: Color.fromARGB(255, 0, 255, 136),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment(0, -0.5),
                          child: Text(
                            "buts marqués",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 139, 139, 139),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: ClipOval(
                      child: Container(
                        //color: Colors.green,
                        height: 60.0, // height of the button
                        width: 60.0, // width of the button
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 255, 255, 255),
                            border: Border.all(
                                color: bm > be
                                    ? Colors.green
                                    : bm < be
                                        ? Colors.red
                                        : Colors.grey,
                                width: 15.0,
                                style: BorderStyle.solid),
                            shape: BoxShape.circle),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 32.0),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment(0, -0.5),
                          child: Text(
                            be.toString(),
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 34,
                              color: Color.fromARGB(255, 255, 0, 0),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment(0, -0.5),
                          child: Text(
                            "buts encaissés",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 139, 139, 139),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Derniers matchs",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
            ),
          ),
          Container(
              height: 76,
              width: MediaQuery.of(context).size.width,
              // margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 3)
              ]),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 18.0, horizontal: 10),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: lister.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return InkWell(
                          onTap: () {
                            print("edit tache");
                          },
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Stack(
                                    children: [
                                      CircleAvatar(
                                        radius: 20.0,
                                        child: Text(lister[index],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18)),
                                        backgroundColor: lister[index] == "V"
                                            ? Colors.green
                                            : lister[index] == "D"
                                                ? Colors.red
                                                : Colors.grey,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          ));
                    }),
              )),
        ] else ...[
          Container(
              width: double.maxFinite,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(children: [
                    Text(
                      lister.length.toString(),
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "matchs joués",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 128, 127, 127)),
                      textAlign: TextAlign.center,
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceEvenly, // use whichever suits your need

                            children: [
                              Row(
                                children: [
                                  Text(
                                    bm.toString(),
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "buts",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey),
                                        textAlign: TextAlign.left,
                                      ),
                                      Text(
                                        "marqués",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              VerticalDivider(
                                thickness: 2,
                                width: 20,
                                color: Color.fromARGB(255, 153, 153, 153),
                              ),
                              Row(
                                children: [
                                  Text(
                                    lister.length > 0
                                        ? (bm / lister.length).toString()
                                        : "0",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "buts marqués",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey),
                                        textAlign: TextAlign.left,
                                      ),
                                      Text(
                                        "/match",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ]))),
          SizedBox(
            height: 7,
          ),
        ],
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "Score moyen",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          color: Colors.white,
          height: 150,
          width: 450,
          child: DChartBar(
            data: [
              {
                'id': 'Bar',
                'data': [
                  {
                    'domain': 'Buts marqués',
                    'measure': lister.length > 0 ? (bm / lister.length) : 0
                  },
                  {
                    'domain': 'Buts encaissés',
                    'measure': lister.length > 0 ? (be / lister.length) : 0
                  },
                ],
              },
            ],
            barColor: (barData, index, id) {
              switch (barData['domain']) {
                case 'Buts marqués':
                  return Colors.green;

                default:
                  return Colors.red;
              }
            },
            domainLabelPaddingToAxisLine: 16,
            axisLineTick: 2,
            axisLinePointTick: 2,
            axisLinePointWidth: 10,
            axisLineColor: Colors.green,
            measureLabelPaddingToAxisLine: 16,
            //   barColor: (barData, index, id) => Colors.green,
            showBarValue: true,
            animate: true,
            showMeasureLine: true,
            showDomainLine: true,
          ),
        ),
        SizedBox(
          height: 7,
        ),
        // Padding(
        //   padding: const EdgeInsets.all(10.0),
        //   child: Text(
        //     "Nombre de matchs selon l'écart de score",
        //     style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
        //   ),
        // ),
        // Container(
        //   padding: EdgeInsets.symmetric(horizontal: 20),
        //   color: Colors.white,
        //   height: 150,
        //   width: 450,
        //   child: DChartBar(
        //     data: [
        //       {
        //         'id': 'Bar',
        //         'data': [
        //           {'domain': '0', 'measure': 3},
        //           {'domain': '+1', 'measure': 4},
        //           {'domain': '+2', 'measure': 4},
        //           {'domain': '+3', 'measure': 4},
        //           {'domain': '+4', 'measure': 4},
        //           {'domain': '+5', 'measure': 4},
        //         ],
        //       },
        //     ],
        //     barColor: (barData, index, id) {
        //       switch (barData['domain']) {
        //         case '0':
        //           return Colors.green;

        //         default:
        //           return Colors.red;
        //       }
        //     },
        //     domainLabelPaddingToAxisLine: 16,
        //     axisLineTick: 2,
        //     axisLinePointTick: 2,
        //     axisLinePointWidth: 10,
        //     axisLineColor: Colors.green,
        //     measureLabelPaddingToAxisLine: 16,
        //     //   barColor: (barData, index, id) => Colors.green,
        //     showBarValue: true,
        //     animate: true,
        //     showMeasureLine: true,
        //   ),
        // ),
      ]),
    ));
  }

  _displayDialog(BuildContext context) async {
    _selected = await showDialog(
      context: context,
      builder: (BuildContext context) {
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
                      "filtrer",
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
                            vertical: 5, horizontal: 10),
                        child: Column(children: [
                          DropdownButtonFormField<String>(
                            value: dropdownevent,
                            hint: Text("Type of Sport"),
                            onChanged: (String? newValue) {
                              setState(() {
                                if (newValue == 'Tous les evenements') {
                                  dropdownevent = null;
                                } else {
                                  dropdownevent = newValue;
                                }
                              });
                            },
                            validator: (String? value) {
                              if (value?.isEmpty ?? true) {
                                return 'Please enter a valid type of sport';
                              }
                            },
                            items: itemsevent
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 180, top: 20),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  Navigator.of(context).pop();
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              super.widget));
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
                  //backgroundColor: Colors.green,
                ),
              ),
            ],
          ),
        );
      },
    );

    if (_selected != null) {
      setState(() {
        _selected = _selected;
      });
    }
  }
}
