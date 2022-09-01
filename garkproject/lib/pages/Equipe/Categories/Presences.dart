import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:garkproject/data/UsersStats.dart';
import 'package:garkproject/pages/Calendrier/ParametresCalendrier.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class BilanPresence extends StatefulWidget {
  const BilanPresence({Key? key, required this.idequipe}) : super(key: key);
  final String idequipe;
  @override
  State<BilanPresence> createState() => _BilanPresenceState();
}

var _selected = "";
var itemsevent = [
  'Tous les evenements',
  'Nouveau championnat',
  'Match entre nous',
  'Match amical',
];
String? dropdownevent;
int? selected = 0;
String cn = "";

class _BilanPresenceState extends State<BilanPresence> {
  SharedPreferences? prefs;

  Future<List> GetMembers() async {
    try {
      Map<String, String> headers = {
        "Content-Type": "application/json; charset=UTF-8",
      };
      http.Response response = await http.get(
          Uri.parse(
              "http://10.0.2.2:3000/api/equipes/allmembre/" + widget.idequipe),
          headers: headers);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        return data[0]["membre"];
      } else {
        return Future.error("server error");
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  var listpresence = [];
  Future<List> GetAllEvent() async {
    try {
      prefs = await SharedPreferences.getInstance();
      cn = prefs!.getString("participantClub")!;
      Map<String, String> headers = {
        "Content-Type": "application/json; charset=UTF-8",
      };
      var response = await http.get(
          Uri.parse("http://10.0.2.2:3000/api/equipes/event/" +widget.idequipe),
          headers: headers);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(data);
        var list = [];
        listpresence = [];
        list = await GetMembers();
        for (int i = 0; i < list.length; i++) {
          setState(() {
            listpresence.add(list[i]);
            listpresence[i]["A l'heure"] = 0;
            listpresence[i]["Retard"] = 0;
            listpresence[i]["excusé"] = 0;
            listpresence[i]["Non excusé"] = 0;
            listpresence[i]["Non Blessé"] = 0;
            listpresence[i]["Blessé"] = 0;
            listpresence[i]["Non convoqué"] = 0;
          });
        }
        for (var u in data[0]["equipe"]) {
          // print(u["presenceList"]);
          for (var v in u["presenceList"]) {
            print(v);
            for (int i = 0; i < listpresence.length; i++) {
              //          listpresence[i][v.substring(v.indexOf(':'))] = 0;
              if (v.substring(0, v.indexOf(':')) == listpresence[i]["_id"] &&
                  (u["nomEvenement"] == dropdownevent ||
                      dropdownevent == null)) {
                // print(v.substring(v.indexOf(':')+1));
                setState(() {
                  listpresence[i][v.substring(v.indexOf(':') + 1)] += 1;
                });
              }
            }
          }
        }
        print(listpresence);
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
    //  (context as Element).reassemble();
    super.initState();

    GetAllEvent();
  }

  bool _bilan = true;
  bool _event = false;
  bool _taches = false;
  List<String> menu = [
    "Bilan",
    // "Par évènements",
    // "Par taches",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 245, 245),
      appBar: PreferredSize(
          child: getAppBar(), preferredSize: const Size.fromHeight(50)),
      body: getBody(),
    );
  }

  Widget getAppBar() {
    return AppBar(
      elevation: 10,
      backgroundColor: const Color.fromARGB(255, 2, 0, 50),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Color.fromARGB(255, 255, 255, 255)),
        onPressed: () => Navigator.of(context).pop(),
      ),
      centerTitle: true, // this is all you need

      title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
        children: <Widget>[
        Spacer(),
        Text(
          "Présences",
          style: TextStyle(),
        ),
        Spacer(),
        RawMaterialButton(
          constraints: BoxConstraints.tight(Size(26, 26)),
          onPressed: () {
            _displayDialog(context).then((value) => setState(() {}));
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
            child: Column(children: [
      Container(
        color: const Color.fromARGB(255, 2, 0, 50),
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Container(
            height: 50.0,
            child: ListView.builder(
              itemCount: menu.length,
              itemBuilder: (context, index) {
                return Container(
                    margin: EdgeInsets.all(10),
                    child: InkWell(
                      onTap: () => {
                        setState(() {
                          selected = index;
                          print(menu[index]);

                          if (menu[index] == "Bilan") {
                            _event = false;
                            _bilan = true;
                            _taches = false;
                          }
                          ;
                          // if (menu[index] == "Par évènements") {
                          //   _bilan = false;
                          //   _event = true;
                          //   _taches = false;
                          // }
                          // ;
                          // if (menu[index] == "Par taches") {
                          //   _bilan = false;
                          //   _event = false;
                          //   _taches = true;
                          // }
                          ;
                        }),
                      },
                      child: Container(
                          width: menu[index] == "Bilan"
                              ? 70
                              : menu[index] == "Par taches"
                                  ? 90
                                  : 150,
                          decoration: BoxDecoration(
                              border: Border.all(),
                              color: index == selected
                                  ? Color.fromARGB(255, 25, 186, 0)
                                  : Color.fromARGB(255, 107, 107, 147),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Center(
                            child: Text(
                              menu[index],
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          )),
                    ));
              },
              scrollDirection: Axis.horizontal,
            ),
          ),
        ),
      ),
      // if (_taches == true) ...[
      //   Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      //     Row(
      //       children: [
      //         Container(
      //           margin: EdgeInsets.only(left: 20, top: 15, bottom: 15),
      //           child: Text(
      //             "1 membre",
      //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      //           ),
      //         ),
      //         Spacer(),
      //         RawMaterialButton(
      //           constraints: BoxConstraints.tight(Size(26, 26)),
      //           onPressed: () {
      //             showmodalbottom();
      //           },
      //           child: IconTheme(
      //             data: IconThemeData(
      //                 color: Color.fromARGB(255, 218, 218, 218), size: 26),
      //             child: Icon(Icons.info_outline),
      //           ),
      //           shape: CircleBorder(),
      //         )
      //       ],
      //     ),
      //     CreateTable2(),
      //   ]),
      // ],
      // if (_event == true) ...[
      //   Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      //     Row(
      //       children: [
      //         Container(
      //           margin: EdgeInsets.only(left: 20, top: 15, bottom: 15),
      //           child: Text(
      //             "1 évènements",
      //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      //           ),
      //         ),
      //         Spacer(),
      //         RawMaterialButton(
      //           constraints: BoxConstraints.tight(Size(26, 26)),
      //           onPressed: () {
      //             showmodalbottom();
      //           },
      //           child: IconTheme(
      //             data: IconThemeData(
      //                 color: Color.fromARGB(255, 218, 218, 218), size: 26),
      //             child: Icon(Icons.info_outline),
      //           ),
      //           shape: CircleBorder(),
      //         )
      //       ],
      //     ),
      //     CreateTable3(),
      //   ]),
      // ],
      if (_bilan == true) ...[
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 20, top: 15, bottom: 15),
                child: Text(
                  dropdownevent ?? "Tous les évènements",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              Spacer(),
              RawMaterialButton(
                constraints: BoxConstraints.tight(Size(26, 26)),
                onPressed: () {
                  showmodalbottom();
                },
                child: IconTheme(
                  data: IconThemeData(
                      color: Color.fromARGB(255, 218, 218, 218), size: 26),
                  child: Icon(Icons.info_outline),
                ),
                shape: CircleBorder(),
              )
            ],
          ),
          CreateTable(),
        ]),
      ]
    ])));
  }

  Future<dynamic> showmodalbottom() {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      context: context,
      builder: (context) {
        return Wrap(children: [
          Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Statuts",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                    ),
                    // use whichever suits your need
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.verified,
                                  color: Colors.green,
                                ),
                                Text("A l'heure",
                                    style: TextStyle(fontSize: 18)),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.timer,
                                  color: Colors.yellow,
                                ),
                                Text("Retard", style: TextStyle(fontSize: 18)),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.warning_outlined,
                                  color: Colors.orange,
                                ),
                                Text("Excusé", style: TextStyle(fontSize: 18)),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.dangerous_sharp,
                                  color: Colors.red,
                                ),
                                Text(
                                  "Non excusé",
                                  style: TextStyle(fontSize: 18),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Icon(Icons.design_services),
                                Text("Blessé", style: TextStyle(fontSize: 18))
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Icon(Icons.block),
                                Text("Non convoqué",
                                    style: TextStyle(fontSize: 18)),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        )
                      ],
                    ),
                  ])),
          SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 70,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(197, 58, 200, 110),
                ),

                child: Text(
                  "Fermer",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.w400,
                  ),
                ), //label text,
              )),
        ]);
      },
    );
  }

  Widget CreateTable() {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            sortAscending: true,
            sortColumnIndex: 2,
            columnSpacing: 35.0,
            columns: [
              DataColumn(label: Text('')),
              DataColumn(label: Text('Convoc')),
              DataColumn(
                  label: Icon(
                Icons.verified,
                color: Colors.green,
              )),
              DataColumn(
                  label: Icon(
                Icons.timer,
                color: Colors.yellow,
              )),
              DataColumn(
                  label: Icon(
                Icons.warning_outlined,
                color: Colors.orange,
              )),
              DataColumn(
                  label: Icon(
                Icons.dangerous_sharp,
                color: Colors.red,
              )),
              DataColumn(label: Icon(Icons.design_services)),
              DataColumn(label: Icon(Icons.block)),
            ],
            rows: listpresence
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
                          Text(e["nom"] + " " + e["prenom"]),
                        ]),
                      ))),
                      DataCell(Container(
                        child: Text(""),
                      )),
                      DataCell(Container(
                        child: Text(e["A l'heure"].toString()),
                      )),
                      DataCell(Container(
                        child: Text(e["Retard"].toString()),
                      )),
                      DataCell(Container(
                        child: Text(e["excusé"].toString()),
                      )),
                      DataCell(Container(
                        child: Text(e["Non excusé"].toString()),
                      )),
                      DataCell(Container(
                        child: Text(e["Blessé"].toString()),
                      )),
                      DataCell(Container(
                        child: Text(e["Non convoqué"].toString()),
                      )),
                      // DataCell(Container(
                      //   child: Text(e["Non convoqué"].toString()),
                      // )),
                    ]))
                .toList(),
          )),
    );
  }

  Widget CreateTable2() {
    return Container(
      width: double.maxFinite,
      color: Colors.white,
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            showBottomBorder: true,
            sortColumnIndex: 2,
            columnSpacing: 35.0,
            columns: [
              DataColumn(
                label: Text(''),
              ),
              DataColumn(label: Text('T')),
              DataColumn(label: Icon(Icons.flag_outlined)),
              DataColumn(
                label: Text(''),
              ),
              DataColumn(label: Text('T')),
              DataColumn(label: Icon(Icons.flag_outlined)),
              DataColumn(label: Icon(Icons.flag_outlined)),
            ],
            rows: userstatList
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
                          Text(e["name"]),
                        ]),
                      ))),
                      DataCell(Container(
                        child: Text(e["note"]),
                      )),
                      DataCell(Container(
                        child: Text(e["but"]),
                      )),
                      DataCell(Container(
                        child: Text(e["note"]),
                      )),
                      DataCell(Container(
                        child: Text(e["but"]),
                      )),
                      DataCell(Container(
                        child: Text(e["but"]),
                      )),
                      DataCell(Container(
                        child: Text(e["but"]),
                      )),
                    ]))
                .toList(),
          )),
    );
  }

  Widget CreateTable3() {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            sortAscending: true,
            sortColumnIndex: 2,
            columnSpacing: 35.0,
            columns: [
              DataColumn(label: Text('')),
              DataColumn(label: Text('Convoc')),
              DataColumn(
                  label: Icon(
                Icons.verified,
                color: Colors.green,
              )),
              DataColumn(
                  label: Icon(
                Icons.timer,
                color: Colors.yellow,
              )),
              DataColumn(label: Text('T')),
              DataColumn(label: Icon(Icons.hourglass_empty)),
              DataColumn(
                  label: Icon(
                Icons.warning_outlined,
                color: Colors.orange,
              )),
              DataColumn(
                  label: Icon(
                Icons.dangerous_sharp,
                color: Colors.red,
              )),
              DataColumn(label: Icon(Icons.block)),
              DataColumn(label: Icon(Icons.design_services)),
            ],
            rows: userstatList
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
                          Text(e["name"]),
                        ]),
                      ))),
                      DataCell(Container(
                        child: Text(e["note"]),
                      )),
                      DataCell(Container(
                        child: Text(e["but"]),
                      )),
                      DataCell(Container(
                        child: Text(e["but"]),
                      )),
                      DataCell(Container(
                        child: Text(e["but"]),
                      )),
                      DataCell(Container(
                        child: Text(e["but"]),
                      )),
                      DataCell(Container(
                        child: Text(e["but"]),
                      )),
                      DataCell(Container(
                        child: Text(e["but"]),
                      )),
                      DataCell(Container(
                        child: Text(e["but"]),
                      )),
                    ]))
                .toList(),
          )),
    );
  }

  _displayDialog(BuildContext context) async {
    _selected = (await showDialog(
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
    ));

    if (_selected != null) {
      setState(() {
        _selected = _selected;
      });
    }
  }
}
