import 'package:flutter/material.dart';
import 'package:garkproject/data/UsersStats.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StatJoueurs extends StatefulWidget {
  const StatJoueurs({Key? key, required this.idequipe}) : super(key: key);
  final String idequipe;
  @override
  State<StatJoueurs> createState() => _StatJoueursState();
}

bool _complet = true;
bool _but = false;
bool _notes = false;
bool _assist = false;
bool _hdm = false;
bool _cartons = false;
bool _particip = false;
var liststat = [];
var occlist = [];

List<String> menu = [
  "Complet",
  "Buts",
  "Passes",
  "Notes",
  "Cartons",
  "Particip"
];
var _selected = "";
var itemsevent = [
  'Tous les evenements',
  'Nouveau championnat',
  'Match entre nous',
  'Match amical',
];
String? dropdownevent;
int? selected = 0;

class _StatJoueursState extends State<StatJoueurs> {
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

  Future<String> fetchDocs(String id) async {
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8",
    };
    http.Response response = await http.get(
        Uri.parse("http://10.0.2.2:3000/api/evenements/" + id),
        headers: headers);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      //  print(data );
      return data["nomEvenement"];
    } else {
      return " ";
    }
  }

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

  Future<List> GetAllStats() async {
    try {
      var response = await http.get(Uri.parse(
          "http://10.0.2.2:3000/api/equipes/statistique/"+widget.idequipe));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        liststat = [];

        var list = [];
        list = await GetMembers();
        print(list);
        for (int i = 0; i < list.length; i++) {
          int k = 0;
          print(list[i]["_id"]);
          for (var u in data[0]["equipe"]) {
            print(dropdownevent);
            if (u["membre"] == list[i]["_id"] &&
                ((await fetchDocs(u["evenement"]) == dropdownevent) ||
                    dropdownevent == null)) {
              if (k == 0) {
                setState(() {
                  liststat.add(u);
                  liststat[i]["buts"] = (int.parse(u["buts"])).toString();
                  liststat[i]["assists"] = (int.parse(u["assists"])).toString();
                  liststat[i]["tempsJouee"] =
                      (int.parse(u["tempsJouee"])).toString();
                  liststat[i]["cartonJaune"] =
                      (int.parse(u["cartonJaune"])).toString();
                  liststat[i]["cartonRouge"] =
                      (int.parse(u["cartonRouge"])).toString();
                });
                k++;
              } else {
                setState(() {
                  liststat[i]["buts"] =
                      (int.parse(liststat[i]["buts"]) + int.parse(u["buts"]))
                          .toString();
                  liststat[i]["assists"] = (int.parse(liststat[i]["assists"]) +
                          int.parse(u["assists"]))
                      .toString();
                  liststat[i]["tempsJouee"] =
                      (int.parse(liststat[i]["tempsJouee"]) +
                              int.parse(u["tempsJouee"]))
                          .toString();
                  liststat[i]["cartonJaune"] =
                      (int.parse(liststat[i]["cartonJaune"]) +
                              int.parse(u["cartonJaune"]))
                          .toString();
                  liststat[i]["cartonRouge"] =
                      (int.parse(liststat[i]["cartonRouge"]) +
                              int.parse(u["cartonRouge"]))
                          .toString();
                });
                k++;
              }
            }
          }
        }
        // print(liststat);
        return jsonDecode(response.body);
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

    GetAllStats();
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
      centerTitle: true, // this is all you need

      elevation: 10,
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
              "Stats joueurs",
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
          padding: const EdgeInsets.only(top: 18.0),
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
                          if (menu[index] == "Complet") {
                            _complet = true;
                            _but = false;
                            _assist = false;
                            _hdm = false;
                            _notes = false;
                            _cartons = false;
                            _particip = false;
                          }
                          ;
                          if (menu[index] == "Buts") {
                            _but = true;
                            _complet = false;
                            _assist = false;
                            _hdm = false;
                            _notes = false;
                            _cartons = false;
                            _particip = false;
                          }
                          ;
                          if (menu[index] == "Passes") {
                            _assist = true;
                            _complet = false;
                            _but = false;
                            _hdm = false;
                            _notes = false;
                            _cartons = false;
                            _particip = false;
                          }
                          ;

                          if (menu[index] == "Notes") {
                            _notes = true;
                            _complet = false;
                            _but = false;
                            _assist = false;
                            _hdm = false;
                            _cartons = false;
                            _particip = false;
                          }
                          if (menu[index] == "Cartons") {
                            _cartons = true;
                            _particip = false;
                            _notes = false;
                            _complet = false;
                            _but = false;
                            _assist = false;
                            _hdm = false;
                          }
                          if (menu[index] == "Particip") {
                            _cartons = false;
                            _particip = true;
                            _notes = false;
                            _complet = false;
                            _but = false;
                            _assist = false;
                            _hdm = false;
                          }
                        }),
                      },
                      child: Container(
                          width: 70,
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
      if (_complet == true)
        ...o(
          "J : Nombre de matchs joués",
          "ABS : Nombre de matchs auxquels le joueur ne s'est meme pas rendu alors qu'il était convoqué",
          "Dés : Nombre de fois que le joueur s'est dit indisponible alors qu'il etait deja convoqué",
          CreateTable(""),
        ),
      if (_but == true)
        ...o(
          "Buts : Nombre de buts marqués",
          "J : Nombre de matchs joués",
          "Buts/match : Nombre de buts par match",
          CreateTable("buts"),
        ),
      if (_notes == true)
        ...o(
          "Moy : Moyenne des notes obtenues sur toutes la saison",
          "Max : Note maximale obtenue sur un match",
          "Min : Note minimale obtenue sur un match",
          CreateTable("notes"),
        ),
      if (_assist == true)
        ...o(
          "PD : Nombre de passes décisives",
          "J : Nombre de matchs joués",
          "PD/m : Nombre de passes décisives par match",
          CreateTable("assists"),
        ),
      if (_hdm == true)
        ...o(
          "HDM : Nombre de fois homme du match",
          "J :  Nombre de matchs joués",
          "HDM/m : Homme du match par match",
          CreateTable("hdm"),
        ),
      if (_cartons == true)
        ...o(
          "J :  Nombre de matchs joués",
          " ",
          " ",
          CreateTable("cartons"),
        ),
      if (_particip == true)
        ...o(
          "J : Nombre de matchs joués",
          "ABS : Nombre de matchs auxquels le joueur ne s'est meme pas rendu alors qu'il était convoqué",
          "Dés : Nombre de fois que le joueur s'est dit indisponible alors qu'il etait deja convoqué",
          CreateTable("particip"),
        ),
    ])));
  }

  late List<Widget> Function;
  o(String first, String second, String third, Widget a) {
    return [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 20, top: 15, bottom: 15),
            child: Text(
              dropdownevent ?? "Tous les évènements",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          a,
          Container(
            margin: EdgeInsets.only(left: 10, top: 25, bottom: 15, right: 10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                first,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 173, 173, 173)),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                second,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 173, 173, 173)),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                third,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 173, 173, 173)),
              ),
            ]),
          )
        ],
      ),
    ];
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

  Widget CreateTable(String type) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 75.0,
          columns: [
            if (type == "") ...[
              DataColumn(label: Text('')),
              DataColumn(label: Text('Note')),
              DataColumn(label: Text('But')),
              DataColumn(label: Text('assists')),
              DataColumn(label: Text('tempsJouee')),
              DataColumn(label: Text('cartonJaune')),
              DataColumn(label: Text('cartonRouge')),
            ],
            if (type == "buts") ...[
              DataColumn(label: Text('')),
              DataColumn(label: Text('But')),
            ],
            if (type == "notes") ...[
              DataColumn(label: Text('')),
              DataColumn(label: Text('Note')),
            ],
            if (type == "assists") ...[
              DataColumn(label: Text('')),
              DataColumn(label: Text('assists')),
            ],
            if (type == "hdm") ...[
              DataColumn(label: Text('')),
              DataColumn(label: Text('assists')),
            ],
            if (type == "cartons") ...[
              DataColumn(label: Text('')),
              DataColumn(label: Text('cartonJaune')),
              DataColumn(label: Text('cartonRouge')),
            ],
            if (type == "particip") ...[
              DataColumn(label: Text('')),
              DataColumn(label: Text('tempsJouee')),
            ],
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
                    if (type == "") ...[
                      DataCell(Container(
                        child: Text(e["note"]),
                      )),
                      DataCell(Container(
                        child: Text(e["buts"].toString()),
                      )),
                      DataCell(Container(
                        child: Text(e["assists"].toString()),
                      )),
                      DataCell(Container(
                        child: Text(e["tempsJouee"].toString()),
                      )),
                      DataCell(Container(
                        child: Text(e["cartonJaune"].toString()),
                      )),
                      DataCell(Container(
                        child: Text(e["cartonRouge"].toString()),
                      )),
                    ],
                    if (type == "buts") ...[
                      DataCell(Container(
                        child: Text(e["buts"].toString()),
                      )),
                    ],
                    if (type == "notes") ...[
                      DataCell(Container(
                        child: Text(e["note"]),
                      )),
                    ],
                    if (type == "assists") ...[
                      DataCell(Container(
                        child: Text(e["assists"].toString()),
                      )),
                    ],
                    if (type == "hdm") ...[
                      DataCell(Container(
                        child: Text(e["notemin"].toString()),
                      )),
                    ],
                    if (type == "cartons") ...[
                      DataCell(Container(
                        child: Text(e["cartonJaune"].toString()),
                      )),
                      DataCell(Container(
                        child: Text(e["cartonRouge"].toString()),
                      )),
                    ],
                    if (type == "particip") ...[
                      DataCell(Container(
                        child: Text(e["tempsJouee"].toString()),
                      )),
                    ],
                  ]))
              .toList(),
        ));
  }
}
