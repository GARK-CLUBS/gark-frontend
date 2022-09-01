import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:garkproject/pages/Calendrier/CalendrierDetail.dart';
import 'package:garkproject/pages/Calendrier/CompleteProgess.dart';
import 'package:garkproject/pages/Calendrier/ParamsEvent.dart';
import 'package:garkproject/pages/Dashboard/Home.dart';
import 'package:garkproject/pages/Splash/splash_screen.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class Calendrier extends StatefulWidget {
  const Calendrier({Key? key}) : super(key: key);

  @override
  _CalendrierState createState() => _CalendrierState();
}

GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
String _baseUrl = "10.0.2.2:3000";
bool progressdone = true;
bool hasdata = false;
bool _valueevenement = false;
bool _valueentrainement = false;
bool _valuematch = false;

var age = 25;
SharedPreferences? prefs;

String cn = "";
String nc = "";

Future<List> GetAllEvent() async {
  try {
    prefs = await SharedPreferences.getInstance();
    cn = prefs!.getString("participantClub")!;
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8",
    };
    var response = await http.get(
        Uri.parse("http://10.0.2.2:3000/api/clubs/allevent/" + cn),
        headers: headers);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      // if (data[0]["club"].length >0) {
      //   hasdata = true;
      //   print("bigger");
      // }
      // print(data);
      // print(data[0]["club"]);
      return data[0]["club"];
    } else {
      return Future.error("server error");
    }
  } catch (e) {
    return Future.error(e);
  }
}

class _CalendrierState extends State<Calendrier> with TickerProviderStateMixin {
  double total = 1;
  bool status4match = false;
  bool status3match = false;
  bool status2match = false;
  bool status1match = false;
  bool status4entrainement = false;
  bool status3entrainement = false;
  bool status2entrainement = false;
  bool status1entrainement = false;
  bool status4evenement = false;
  bool status3evenement = false;
  bool status2evenement = false;
  bool status1evenement = false;
  DateTime date = DateTime.now();
  final TextEditingController _descmatch = TextEditingController();

  final TextEditingController _datedebmatch = TextEditingController();
  final TextEditingController _datefinmatch = TextEditingController();
  final TextEditingController _heurerdvmatch = TextEditingController();
  final TextEditingController _lieumatch = TextEditingController();
  final TextEditingController _lieurdvmatch = TextEditingController();
  final TextEditingController _nommatch = TextEditingController();
  final TextEditingController _nomchampionnat = TextEditingController();
//** */
  final TextEditingController _descentrainement = TextEditingController();

  final TextEditingController _datedebentrainement = TextEditingController();
  final TextEditingController _datefinentrainement = TextEditingController();
  final TextEditingController _heurerdventrainement = TextEditingController();
  final TextEditingController _lieuentrainement = TextEditingController();
  final TextEditingController _lieurdventrainement = TextEditingController();
  final TextEditingController _nomentrainement = TextEditingController();
//** */
  final TextEditingController _descevenement = TextEditingController();

  final TextEditingController _datedebevenement = TextEditingController();
  final TextEditingController _datefinevenement = TextEditingController();
  final TextEditingController _heurerdvevenement = TextEditingController();
  final TextEditingController _lieuevenement = TextEditingController();
  final TextEditingController _lieurdvevenement = TextEditingController();

// match amical , tunisienne , nv championnat , nv coupe
  final TextEditingController _nomadv = TextEditingController();
// tournoi , nv championnat
  final TextEditingController _nomevent = TextEditingController();

// tunisienne , nv championnat
  final TextEditingController _numjournee = TextEditingController();

  String? dropdownSport;
  String? dropdowncontre;
  String? dropdowncoupee;
  String? dropdownJoursmatch = 'Mardi';
  String? dropdownJoursevent = 'Mardi';
  String? dropdownJourstraining = 'Mardi';
  var membrelength = [];
  var itemsSport = [
    'Match entre nous',
    'Match amical',
    'Tournoi',
    'Championnat(s)',
    'Tunisienne',
    'Nouveau championnat',
    'Coupe(s)',
    'Nouvelle coupe',
  ];
  var itemsJours = [
    'Lundi',
    'Mardi',
    'Mercredi',
    'Jeudi',
    'Vendredi',
    'Samedi',
    'Dimache',
  ];
  var itemsContre = [
    '11 contre 11',
    '10 contre 10',
    '9 contre 9',
    '8 contre 8',
    '7 contre 7',
    '6 contre 6',
    '5 contre 5',
    '4 contre 4',
    '3 contre 3',
    '2 contre 2',
    '1 contre 1',
  ];
  var itemsCoupe = [
    'Finale',
    'Demi-finale',
    'Match pour la 3ème place',
    '1/4 de finale',
    '1/8 de finale',
    '1/16 de finale',
    '1/32 de finale',
    '1/64 de finale',
    'Phase de poules',
    'Tour préliminaire',
    'Phase éliminatoire',
    '1er tour',
    '2e tour',
    '3e tour',
    '4e tour',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          child: getAppBar(), preferredSize: const Size.fromHeight(0)),
      body: getBody(),
      floatingActionButton: _getFAB(),
    );
  }

  Future<int?> dialogpickernumber() {
    return showMaterialNumberPicker(
      context: context,
      title: 'Pick Your Age',
      maxNumber: 100,
      minNumber: 14,
      selectedNumber: age,
      onChanged: (value) => setState(() => age = value),
    );
  }

  late Future<bool> fetchedDocs;
  Future<List> GetAllEquipe() async {
    try {
      prefs = await SharedPreferences.getInstance();
      cn = prefs!.getString("participantClub")!;
      var response = await http
          .get(Uri.parse("http://10.0.2.2:3000/api/clubs/alleq/" + cn));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return Future.error("server error");
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<bool> fetchDocs() async {
    prefs = await SharedPreferences.getInstance();
    cn = prefs!.getString("participantClub")!;
    nc = prefs!.getString("nameClub")!;
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8",
    };
    http.Response response = await http.get(
        Uri.parse("http://10.0.2.2:3000/api/clubs/allevent/" + cn),
        headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data[0]["club"].length > 0) {
        membrelength = [];
        setState(() {
          hasdata = true;
          //  print(data[0]["club"][0]["presenceList"].length);
          print(data[0]["club"]);
          // for (var item in data[0]["club"]) {
          //   //  print(item["presenceList"].length);
          //   membrelength.add(item["presenceList"].length);
          // }
          // print(membrelength);
        });
        // print("bigger");
      }
    }

    return true;
  }

  @override
  void initState() {
    fetchedDocs = fetchDocs();

    super.initState();
  }

  Widget _getFAB() {
    if (hasdata == false) {
      return Container();
    } else {
      return FloatingActionButton(
          backgroundColor: Colors.green,
          child: const Icon(Icons.add),
          onPressed: () {
            Editaddevent(context).then((value) => setState(() {}));
          });
    }
  }

  Future<void> Editaddevent(BuildContext context) {
    TabController _tabController = TabController(length: 3, vsync: this);
    int activeTabIndex = 0;
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter state) {
            return Form(
              key: _keyForm,
              child: FractionallySizedBox(
                  heightFactor: 0.91,
                  child: Wrap(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 2, 0, 50),
                        ),
                        child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 10),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    "Annuler",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                const Align(
                                  alignment: Alignment(-0.8, 0),
                                  child: Text(
                                    "Créer un événement",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                ElevatedButton(
                                  onPressed: () {
                                    if (activeTabIndex == 0) {
                                      if (_keyForm.currentState!.validate()) {
                                        setState(() {
                                          AddData(
                                              context,
                                              "Match",
                                              dropdownSport!,
                                              _descmatch.text,
                                              dropdowncontre!,
                                              _nommatch.text,
                                              _datedebmatch.text,
                                              _datefinmatch.text,
                                              _heurerdvmatch.text,
                                              _lieumatch.text,
                                              _lieurdvmatch.text,
                                              status1match,
                                              status2match,
                                              status3match,
                                              status4match,
                                              _nomadv.text,
                                              _numjournee.text,
                                              dropdowncoupee ?? "",
                                              _nomchampionnat.text,
                                              dropdownJoursmatch ?? "");
                                        });
                                      }

                                      status4entrainement = false;
                                      status3entrainement = false;
                                      status2entrainement = false;
                                      status1entrainement = false;
                                      status4evenement = false;
                                      status3evenement = false;
                                      status2evenement = false;
                                      status1evenement = false;
                                    }
                                    if (activeTabIndex == 1) {
                                      if (_keyForm.currentState!.validate()) {
                                        AddData(
                                            context,
                                            "Entrainement",
                                            _nomentrainement.text,
                                            _descentrainement.text,
                                            "",
                                            _nomevent.text,
                                            _datedebentrainement.text,
                                            _datefinentrainement.text,
                                            _heurerdventrainement.text,
                                            _lieuentrainement.text,
                                            _lieurdventrainement.text,
                                            status1entrainement,
                                            status2entrainement,
                                            status3entrainement,
                                            status4entrainement,
                                            "",
                                            "",
                                            "",
                                            _nomchampionnat.text,
                                            dropdownJourstraining ?? "");
                                      }
                                      status4match = false;
                                      status3match = false;
                                      status2match = false;
                                      status1match = false;
                                      status4evenement = false;
                                      status3evenement = false;
                                      status2evenement = false;
                                      status1evenement = false;
                                    }
                                    if (activeTabIndex == 2) {
                                      if (_keyForm.currentState!.validate()) {
                                        setState(() {
                                          AddData(
                                              context,
                                              "événement",
                                              _nommatch.text,
                                              _descevenement.text,
                                              "",
                                              //jour recurrence
                                              _nomevent.text,
                                              _datedebevenement.text,
                                              _datefinevenement.text,
                                              _heurerdvevenement.text,
                                              _lieuevenement.text,
                                              _lieurdvevenement.text,
                                              status1evenement,
                                              // avant levenemnt
                                              status2evenement,
                                              status3evenement,
                                              status4evenement,
                                              "",
                                              "",
                                              "",
                                              _nomchampionnat.text,
                                              dropdownJoursevent ?? "");
                                        });
                                      }
                                      status4match = false;
                                      status3match = false;
                                      status2match = false;
                                      status1match = false;
                                      status4entrainement = false;
                                      status3entrainement = false;
                                      status2entrainement = false;
                                      status1entrainement = false;
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary:
                                        const Color.fromARGB(255, 2, 0, 50),
                                  ),
                                  child: Align(
                                    alignment: Alignment(-0.8, 0),
                                    child: Text(
                                      "Créer",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color:
                                            Color.fromARGB(255, 173, 173, 173),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 14, 0, 0),
                        height:
                            90, // change it to 140 idha nheb nrejaaha kima kenet
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 2, 0, 50),
                        ),
                        child: TabBar(
                            onTap: (index) {
                              activeTabIndex = index;
                            },
                            controller: _tabController,
                            labelColor:
                                const Color.fromARGB(255, 255, 255, 255),
                            tabs: [
                              Tab(
                                icon: const Icon(Icons.emoji_events, size: 20),
                                child: SizedBox(
                                    width: 100,
                                    height: 40,
                                    child: const Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                                      child: Center(
                                          child: Text("Match",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255)))),
                                    )),
                              ),
                              Tab(
                                icon: const Icon(Icons.app_registration,
                                    size: 20),
                                child: SizedBox(
                                    width: 100,
                                    height: 40,
                                    child: const Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: Center(
                                          child: Text("Entrainement",
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255)))),
                                    )),
                              ),
                              Tab(
                                icon: const Icon(Icons.nightlife, size: 20),
                                child: SizedBox(
                                    width: 100,
                                    height: 40,
                                    child: const Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: Center(
                                          child: Text("événement",
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255)))),
                                    )),
                              ),
                            ]),
                      ),
                      Container(
                        width: double.maxFinite,
                        height: 550,
                        child:
                            TabBarView(controller: _tabController, children: [
                          // to stop list view from infinity looop
                          // all you have to do is to add item count =1
                          ListView.builder(
                              physics:
                                  const AlwaysScrollableScrollPhysics(), // new

                              itemCount: 1,
                              itemBuilder: (_, index) {
                                return Container(
                                    padding: const EdgeInsets.only(
                                      left: 20,
                                      right: 20,
                                    ),
                                    child: Column(children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Align(
                                        alignment: Alignment(-1, 0),
                                        child: Text(
                                          "Type",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      // working here now
                                      DropdownButtonFormField<String>(
                                        value: dropdownSport,
                                        hint: Text("Type of Sport"),
                                        onChanged: (String? newValue) {
                                          state(() => dropdownSport = newValue);
                                        },
                                        validator: (String? value) {
                                          if (value?.isEmpty ?? true) {
                                            return 'Please enter a valid type of sport';
                                          }
                                        },
                                        items: itemsSport
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),

                                      // beginning

                                      if (dropdownSport ==
                                          "Match entre nous") ...[
                                        const SizedBox(height: 10),
                                        EventComponent(
                                            state,
                                            context,
                                            "Match entre nous",
                                            _descmatch,
                                            itemsContre,
                                            _datedebmatch,
                                            _datefinmatch,
                                            _heurerdvmatch,
                                            _lieumatch,
                                            _lieurdvmatch,
                                            status1match,
                                            status2match,
                                            status3match,
                                            status4match,
                                            _nomadv,
                                            _nomevent,
                                            _numjournee,
                                            itemsCoupe,
                                            _valuematch),
                                      ] else if (dropdownSport ==
                                          "Match amical") ...[
                                        const SizedBox(height: 10),
                                        EventComponent(
                                            state,
                                            context,
                                            "Match amical",
                                            _descmatch,
                                            itemsContre,
                                            _datedebmatch,
                                            _datefinmatch,
                                            _heurerdvmatch,
                                            _lieumatch,
                                            _lieurdvmatch,
                                            status1match,
                                            status2match,
                                            status3match,
                                            status4match,
                                            _nomadv,
                                            _nomevent,
                                            _numjournee,
                                            itemsCoupe,
                                            _valuematch),
                                        // nzidouha nom de l'adversaire
                                      ] else if (dropdownSport ==
                                          "Tournoi") ...[
                                        EventComponent(
                                            state,
                                            context,
                                            "Tournoi",
                                            _descmatch,
                                            itemsContre,
                                            _datedebmatch,
                                            _datefinmatch,
                                            _heurerdvmatch,
                                            _lieumatch,
                                            _lieurdvmatch,
                                            status1match,
                                            status2match,
                                            status3match,
                                            status4match,
                                            _nomadv,
                                            _nomevent,
                                            _numjournee,
                                            itemsCoupe,
                                            _valuematch),

                                        // nzidouha nom de l'adversaire
                                      ] else if (dropdownSport ==
                                          "Tunisienne") ...[
                                        EventComponent(
                                            state,
                                            context,
                                            "Tunisienne",
                                            _descmatch,
                                            itemsContre,
                                            _datedebmatch,
                                            _datefinmatch,
                                            _heurerdvmatch,
                                            _lieumatch,
                                            _lieurdvmatch,
                                            status1match,
                                            status2match,
                                            status3match,
                                            status4match,
                                            _nomadv,
                                            _nomevent,
                                            _numjournee,
                                            itemsCoupe,
                                            _valuematch),

                                        // nzidouha nom de l'adversaire + numero de la journee
                                      ] else if (dropdownSport ==
                                          "Nouveau championnat") ...[
                                        EventComponent(
                                            state,
                                            context,
                                            "Nouveau championnat",
                                            _descmatch,
                                            itemsContre,
                                            _datedebmatch,
                                            _datefinmatch,
                                            _heurerdvmatch,
                                            _lieumatch,
                                            _lieurdvmatch,
                                            status1match,
                                            status2match,
                                            status3match,
                                            status4match,
                                            _nomadv,
                                            _nomevent,
                                            _numjournee,
                                            itemsCoupe,
                                            _valuematch),

                                        // nzidouha nom de l'adversaire + numero de la journee + nom du championnat
                                      ] else if (dropdownSport ==
                                          "Nouvelle coupe") ...[
                                        EventComponent(
                                            state,
                                            context,
                                            "Nouvelle coupe",
                                            _descmatch,
                                            itemsContre,
                                            _datedebmatch,
                                            _datefinmatch,
                                            _heurerdvmatch,
                                            _lieumatch,
                                            _lieurdvmatch,
                                            status1match,
                                            status2match,
                                            status3match,
                                            status4match,
                                            _nomadv,
                                            _nomevent,
                                            _numjournee,
                                            itemsCoupe,
                                            _valuematch),
                                      ]
                                    ]));
                              }),
                          //2222222222222222

                          ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: 1,
                              itemBuilder: (_, index) {
                                return Container(
                                    padding: const EdgeInsets.only(
                                      left: 20,
                                      right: 20,
                                    ),
                                    child: Column(children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const Align(
                                        alignment: Alignment(-1, 0),
                                        child: Text(
                                          "Type",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      EventComponent(
                                          state,
                                          context,
                                          "entrainement",
                                          _descentrainement,
                                          itemsContre,
                                          _datedebentrainement,
                                          _datefinentrainement,
                                          _heurerdventrainement,
                                          _lieuentrainement,
                                          _lieurdventrainement,
                                          status1entrainement,
                                          status2entrainement,
                                          status3entrainement,
                                          status4entrainement,
                                          _nomadv,
                                          _nomentrainement,
                                          _numjournee,
                                          itemsCoupe,
                                          _valueentrainement),

                                      // enhotou ken nom event w desc
                                    ]));
                              }),
                          ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: 1,
                              itemBuilder: (_, index) {
                                return Container(
                                    padding: const EdgeInsets.only(
                                      left: 20,
                                      right: 20,
                                    ),
                                    child: Column(children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const Align(
                                        alignment: Alignment(-1, 0),
                                        child: Text(
                                          "Type",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      EventComponent(
                                          state,
                                          context,
                                          "evenement",
                                          _descevenement,
                                          itemsContre,
                                          _datedebevenement,
                                          _datefinevenement,
                                          _heurerdvevenement,
                                          _lieuevenement,
                                          _lieurdvevenement,
                                          status1evenement,
                                          status2evenement,
                                          status3evenement,
                                          status4evenement,
                                          _nomadv,
                                          _nomevent,
                                          _numjournee,
                                          itemsCoupe,
                                          _valueevenement),

                                      // enhotou ken nom event w desc
                                    ]));
                              }),
                        ]),
                      ),
                    ],
                  )),
            );
          },
        );
      },
    );
  }

  Future<void> AddData(
      BuildContext context,
      String type,
      String dropdowntype,
      String _desc,
      String dropdowncontre,
      String nomevent,
      String _datedeb,
      String _datefin,
      String _heurerdv,
      String _lieu,
      String _lieurdv,
      bool status11,
      bool status22,
      bool status33,
      bool status44,
      String nomadv,
      String numjournee,
      String dropdowncoupe,
      String nomchampionnat,
      String Jours) async {
    String? _clubid;
    prefs = await SharedPreferences.getInstance();
    _clubid = prefs!.getString("participantClub");
    if (_keyForm.currentState!.validate()) {
      // debugPrint(Jours);
      // debugPrint(status11.toString());
      // debugPrint(status22.toString());
      // debugPrint(status33.toString());
      // debugPrint(status44.toString());
      // debugPrint(_desc);
      // debugPrint(dropdowncontre);
      // debugPrint(_datedeb);
      // debugPrint(_datefin);
      // debugPrint(_heurerdv);
      // debugPrint(_lieu);
      // debugPrint(_lieurdv);
      // debugPrint(_nomadv);
      // debugPrint(_numjournee);
      // debugPrint(dropdowncoupe);
      // print(_clubid);
      Map<String, dynamic> userData1 = {
        "_id": _clubid,
      };
      Map<String, dynamic> userData2 = {
        "_id": "62e7296ac9fe267f7c44647d",
      };
      Map<String, dynamic> userDataEvent = {
        "type": type,
        "nomEvenement": dropdowntype,
        "description": _desc,
        "format": dropdowncontre,
        "dateDebut": _datedeb,
        "dateFin": _datefin,
        "heureRDV": _heurerdv,
        "lieuEvenement": _lieu,
        "lieuRDV": _lieurdv,
        "convocationAutomatique": status11,
        "appEventFuturs": status22,
        "relanceAutomatique": status33,
        "listeAttente": status44,
        "nomAdversaire": nomadv,
        "numeroJourne": numjournee,
        "tourCoupe": dropdowncoupe,
        "nomCoupe": nomevent,
        "nomChampionnat": nomchampionnat,
        "club": userData1,
        "jourRecurrence": Jours,
        "equipe": userData2,
      };
      Map<String, String> headers = {
        "Content-Type": "application/json; charset=UTF-8"
      };
      http
          .post(Uri.http(_baseUrl, "/api/evenements/"),
              headers: headers, body: json.encode(userDataEvent))
          .then((http.Response response) async {
        print(userDataEvent);
        if (response.statusCode == 201) {
          _keyForm.currentState?.reset();
          _descmatch.clear();
          _datedebmatch.clear();
          _datefinmatch.clear();
          _heurerdvmatch.clear();
          _lieumatch.clear();
          _lieurdvmatch.clear();
          _nommatch.clear();
          _nomchampionnat.clear();
          _descentrainement.clear();
          _datedebentrainement.clear();
          _datefinentrainement.clear();
          _heurerdventrainement.clear();
          _lieuentrainement.clear();
          _lieurdventrainement.clear();
          _nomentrainement.clear();
          _descevenement.clear();
          _datedebevenement.clear();
          _datefinevenement.clear();
          _heurerdvevenement.clear();
          _lieuevenement.clear();
          _nomadv.clear();
          _nomevent.clear();
          _numjournee.clear();
          status4match = false;
          status3match = false;
          status2match = false;
          status1match = false;
          status4entrainement = false;
          status3entrainement = false;
          status2entrainement = false;
          status1entrainement = false;
          status4evenement = false;
          status3evenement = false;
          status2evenement = false;
          status1evenement = false;
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => HomePage()),
          // ).then((value) => setState(() {}));
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => super.widget));
          Navigator.pop(context);
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
                  content:
                      Text("Une erreur s'est produite. Veuillez réessayer !"),
                );
              });
        }
      });
    }
  }

  StatefulBuilder EventComponent(
      StateSetter state,
      BuildContext context,
      String etat,
      TextEditingController _desc,
      var _itemcontre,
      TextEditingController _datedeb,
      TextEditingController _datefin,
      TextEditingController _heurerdv,
      TextEditingController _lieu,
      TextEditingController _lieurdv,
      bool status11,
      bool status22,
      bool status33,
      bool status44,
      TextEditingController _nomadv,
      TextEditingController _nomevent,
      TextEditingController _numjournee,
      var itemsCoupe,
      bool valuecheckbox) {
    return StatefulBuilder(builder: (BuildContext context, StateSetter state) {
      return Column(
        children: [
          if (etat == "Tournoi" ||
              etat == "Nouveau championnat" ||
              etat == "Nouvelle coupe" ||
              etat == "evenement" ||
              etat == "entrainement") ...[
            TextFormField(
              controller: etat == "entrainement"
                  ? _nomentrainement
                  : etat == "Nouveau championnat"
                      ? _nomchampionnat
                      : _nommatch,
              decoration: InputDecoration(
                labelText: etat == "Nouveau championnat"
                    ? "Nom du championnat"
                    : etat == "Tournoi" ||
                            etat == "evenement" ||
                            etat == "entrainement"
                        ? "Nom de l'évènement :"
                        : "Nom de la coupe",
                labelStyle: TextStyle(
                    color: Colors.black87,
                    fontSize: 17,
                    fontFamily: 'AvenirLight'),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                ),
              ),
              style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 17,
                  fontFamily: 'AvenirLight'),
            ),
          ],

          TextFormField(
            controller: _desc,
            decoration: const InputDecoration(
              labelText: "Description de l'événement :",
              labelStyle: TextStyle(
                  color: Colors.black87,
                  fontSize: 17,
                  fontFamily: 'AvenirLight'),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
              ),
            ),
            style: const TextStyle(
                color: Colors.black87, fontSize: 17, fontFamily: 'AvenirLight'),
          ),
          if (etat != "evenement" && etat != "entrainement")
            DropdownButtonFormField<String>(
              value: dropdowncontre,
              hint: Text("5 contre 5"),
              onChanged: (String? newValue) {
                setState(() {
                  dropdowncontre = newValue;
                });
              },
              validator: (String? value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter a valid type of sport';
                }
              },
              items: itemsContre.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          // here should be the cupertino picker*
          // DropdownButtonFormField<String>(
          //             value: dropdownequipe,
          //             hint: Text("equipe : "),
          //             onChanged: (String? newValue) {
          //               setState(() {
          //                 dropdownequipe = newValue;
          //               });
          //             },
          //             validator: (String? value) {
          //               if (value?.isEmpty ?? true) {
          //                 return 'Please enter a valid type of sport';
          //               }
          //             },
          //             items: itemsequipe.map<DropdownMenuItem<String>>((String value) {
          //               return DropdownMenuItem<String>(
          //                 value: value,
          //                 child: Text(value),
          //               );
          //             }).toList(),
          //           ),
          if (etat == "Tunisienne" ||
              etat == "Nouveau championnat" ||
              etat == "Nouvelle coupe" ||
              etat == "Match amical") ...[
            TextFormField(
              controller: _nomadv,
              decoration: const InputDecoration(
                labelText: "Nom de l'adversaire",
                labelStyle: TextStyle(
                    color: Colors.black87,
                    fontSize: 17,
                    fontFamily: 'AvenirLight'),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                ),
              ),
              style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 17,
                  fontFamily: 'AvenirLight'),
            ),
          ],
          if (etat == "Tunisienne" || etat == "Nouveau championnat") ...[
            TextFormField(
              controller: _numjournee,
              decoration: const InputDecoration(
                labelText: "Numéro de la journée",
                labelStyle: TextStyle(
                    color: Colors.black87,
                    fontSize: 17,
                    fontFamily: 'AvenirLight'),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                ),
              ),
              style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 17,
                  fontFamily: 'AvenirLight'),
            ),
          ],
          if (etat == "Nouvelle coupe") ...[
            DropdownButtonFormField<String>(
              value: dropdowncoupee,
              hint: Text("Tour de coupe"),
              onChanged: (String? newValue) {
                state(() => dropdowncoupee = newValue);
              },
              validator: (String? value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter a valid type of sport';
                }
              },
              items: itemsCoupe.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],

          Row(
            children: [
              const Align(
                alignment: Alignment(-1, 0),
                child: Text(
                  "Date",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
              const Spacer(),
              const Align(
                alignment: Alignment(-1, 0),
                child: Text(
                  "Evénement récurrent",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(255, 146, 146, 146),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Checkbox(
                value: etat == "evenement"
                    ? _valueevenement
                    : etat == "entrainement"
                        ? _valueentrainement
                        : _valuematch,
                onChanged: (bool? newValue) {
                  state(() => {
                        if (etat == "evenement") {_valueevenement = newValue!},
                        if (etat == "entrainement")
                          {_valueentrainement = newValue!}
                        else
                          {_valuematch = newValue!}
                      });

                  // setState(() {
                  //   _value = newValue!;
                  // });
                },
              )
            ],
          ),
          // if ((etat == "evenement" && _valueevenement == true) ||
          //     (etat == "entrainement" && _valueentrainement == true) ||
          //     (etat != "entrainement" &&
          //         etat != "evenement" &&
          //         _valuematch == true)) ...[
          //   DropdownButtonFormField<String>(
          //     value: etat == "evenement"
          //         ? dropdownJoursevent
          //         : etat == "entrainement"
          //             ? dropdownJourstraining
          //             : dropdownJoursmatch,
          //     hint: Text("Jours de récurrence *"),
          //     onChanged: (String? newValue) {
          //       state(() => dropdownSport = newValue);
          //     },
          //     validator: (String? value) {
          //       if (value?.isEmpty ?? true) {
          //         return 'Please enter a valid day';
          //       }
          //     },
          //     items: itemsJours.map<DropdownMenuItem<String>>((String value) {
          //       return DropdownMenuItem<String>(
          //         value: value,
          //         child: Text(value),
          //       );
          //     }).toList(),
          //   ),
          // ],
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Debut",
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
              ),
            ),
            controller: _datedeb,
            readOnly: true,
            onTap: () {
              DatePicker.showDateTimePicker(context,
                  showTitleActions: true,
                  onChanged: (date) {}, onConfirm: (datee) {
                setState(() {
                  _datedeb.text = datee.toString();
                });
              },
                  currentTime: DateTime(2022, 12, 31, 23, 12, 34),
                  locale: LocaleType.en);
            },
            validator: (value) {
              if (value!.isEmpty) {
                return "Veuillez renseigner la date de debut .";
              } else {
                return null;
              }
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Fin",
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
              ),
            ),
            controller: _datefin,
            readOnly: true,
            onTap: () {
              DatePicker.showDateTimePicker(context,
                  showTitleActions: true,
                  onChanged: (date) {}, onConfirm: (datee) {
                setState(() {
                  _datefin.text = datee.toString();
                });
              },
                  currentTime: DateTime(2022, 12, 31, 23, 12, 34),
                  locale: LocaleType.en);
            },
            validator: (value) {
              if (value!.isEmpty) {
                return "Veuillez renseigner la  date de fin  .";
              } else {
                return null;
              }
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Heure de RDV",
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
              ),
            ),
            controller: _heurerdv,
            readOnly: true,
            onTap: () {
              DatePicker.showTime12hPicker(context,
                  showTitleActions: true,
                  onChanged: (date) {}, onConfirm: (date) {
                setState(() {
                  List<String> tokens = date.toString().split(' ');
                  String retVal = tokens[1];
                  _heurerdv.text = retVal;
                });
              }, currentTime: DateTime.now());
            },
            validator: (value) {
              if (value!.isEmpty) {
                return "Veuillez renseigner la  date de fin  .";
              } else {
                return null;
              }
            },
          ),
          const SizedBox(
            height: 15,
          ),
          const Align(
            alignment: Alignment(-1, 0),
            child: Text(
              "Lieu",
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextFormField(
            controller: _lieu,
            decoration: const InputDecoration(
              labelText: "Lieu de l'événement",
              labelStyle: TextStyle(
                  color: Colors.black87,
                  fontSize: 17,
                  fontFamily: 'AvenirLight'),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
              ),
            ),
            style: const TextStyle(
                color: Colors.black87, fontSize: 17, fontFamily: 'AvenirLight'),
          ),
          TextFormField(
            controller: _lieurdv,
            decoration: const InputDecoration(
              labelText: 'Lieu de rendez-vous :',
              labelStyle: TextStyle(
                  color: Colors.black87,
                  fontSize: 17,
                  fontFamily: 'AvenirLight'),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
              ),
            ),
            style: const TextStyle(
                color: Colors.black87, fontSize: 17, fontFamily: 'AvenirLight'),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: const [
              Align(
                alignment: Alignment(-1, 0),
                child: Text(
                  "Paramètres de convocation",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Spacer(),
              IconTheme(
                data: IconThemeData(
                    color: Color.fromARGB(255, 187, 187, 187), size: 28),
                child: Icon(Icons.info_outline),
              ),
            ],
          ),
          // working on convocation
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const Align(
                alignment: Alignment(-1, 0),
                child: Text(
                  "Convocation automatique",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Spacer(),
              //working here
              FlutterSwitch(
                width: 55.0,
                height: 25.0,
                value: etat == "entrainement"
                    ? status1entrainement
                    : etat == "evenement"
                        ? status1evenement
                        : status1match,
                onToggle: (val) {
                  if (etat == "entrainement") {
                    state(() => status1entrainement = val);
                  }
                  if (etat == "evenement") {
                    state(() => status1evenement = val);
                  } else {
                    state(() => status1match = val);
                  }
                },
                activeColor: Color.fromARGB(200, 0, 249, 93),
              ),
            ],
          ),

          if ((status1entrainement == true && etat == "entrainement") ||
              (status1evenement == true && etat == "evenement") ||
              (status1match == true &&
                  etat != "entrainement" &&
                  etat != "evenement")) ...[
            SizedBox(
              height: 10,
            ),

            // Align(
            //   alignment:
            //       Alignment(-1, 0),
            //   child: Text(
            //     "Avant l'événement",
            //     textAlign:
            //         TextAlign.right,
            //     style: TextStyle(
            //       fontSize: 14,
            //       color: Color
            //           .fromARGB(255,
            //               0, 0, 0),
            //       fontWeight:
            //           FontWeight
            //               .w400,
            //     ),
            //   ),
            // ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Fin",
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                ),
              ),
              controller: datearriveInput,
              readOnly: true,
              onTap: () {
                DatePicker.showDateTimePicker(context,
                    showTitleActions: true,
                    onChanged: (date) {}, onConfirm: (datee) {
                  setState(() {
                    datearriveInput.text = datee.toString();
                  });
                },
                    currentTime: DateTime(2022, 12, 31, 23, 12, 34),
                    locale: LocaleType.en);
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return "Veuillez renseigner la  date de fin  .";
                } else {
                  return null;
                }
              },
            ),
          ],
          SizedBox(
            height: 10,
          ),
          Row(children: [
            const Align(
              alignment: Alignment(-1, 0),
              child: Text(
                "Relance automatique",
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 14,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Spacer(),
            FlutterSwitch(
              width: 55.0,
              height: 25.0,
              value: etat == "entrainement"
                  ? status2entrainement
                  : etat == "evenement"
                      ? status2evenement
                      : status2match,
              onToggle: (val) {
                if (etat == "entrainement") {
                  state(() => {status2entrainement = val});
                }
                if (etat == "evenement") {
                  state(() => status2evenement = val);
                } else {
                  state(() => status2match = val);
                }
              },
              activeColor: Color.fromARGB(200, 0, 249, 93),
            ),
          ]),
          SizedBox(
            height: 10,
          ),
          Row(children: [
            const Align(
              alignment: Alignment(-1, 0),
              child: Text(
                "Liste d'attente",
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 14,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Spacer(),
            FlutterSwitch(
              width: 55.0,
              height: 25.0,
              value: etat == "entrainement"
                  ? status3entrainement
                  : etat == "evenement"
                      ? status3evenement
                      : status3match,
              onToggle: (val) {
                if (etat == "entrainement") {
                  state(() => status3entrainement = val);
                }
                if (etat == "evenement") {
                  state(() => status3evenement = val);
                } else {
                  state(() => status3match = val);
                }
              },
              activeColor: Color.fromARGB(200, 0, 249, 93),
            ),
          ]),

          if ((status3entrainement == true && etat == "entrainement") ||
              (status3evenement == true && etat == "evenement") ||
              (status3match == true &&
                  etat != "entrainement" &&
                  etat != "evenement")) ...[
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "NB de participant",
                    labelStyle: TextStyle(
                        color: Colors.black87,
                        fontSize: 17,
                        fontFamily: 'AvenirLight'),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ),
                  style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 17,
                      fontFamily: 'AvenirLight'),
                ),
              ],
            ),
          ],
          SizedBox(
            height: 10,
          ),
          Row(children: [
            const Align(
              alignment: Alignment(-1, 0),
              child: Text(
                "Appliquer aux événement futurs",
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 14,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Spacer(),
            FlutterSwitch(
              width: 55.0,
              height: 25.0,
              value: etat == "entrainement"
                  ? status4entrainement
                  : etat == "evenement"
                      ? status4evenement
                      : status4match,
              onToggle: (val) {
                if (etat == "entrainement") {
                  state(() => status4entrainement = val);
                }
                if (etat == "evenement") {
                  state(() => status4evenement = val);
                } else {
                  state(() => status4match = val);
                }
              },
              activeColor: Color.fromARGB(200, 0, 249, 93),
            ),
          ]),
        ],
      );
    });
  }

  Widget getAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: const Color.fromARGB(255, 2, 0, 50),
    );
  }

  Widget getBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: <Widget>[
              Container(
                  child: Stack(children: <Widget>[
                Container(
                  // 160
                  height: progressdone ? 80 : 160,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 2, 0, 50),
                      borderRadius: BorderRadius.only(
                        bottomLeft: progressdone
                            ? const Radius.circular(0)
                            : const Radius.circular(36),
                        bottomRight: progressdone
                            ? const Radius.circular(0)
                            : const Radius.circular(36),
                      )),
                ),
                Positioned(
                  bottom: progressdone ? 20 : 100,
                  left: 30,
                  right: 0,
                  child: Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                        const Text(
                          //display club
                          "Calendrier",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w600),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (c) => const ParamsEvent()));
                          },
                          child: const Text(
                            "Modifier les paramètres",
                            style: TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(197, 58, 200, 110),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ])),
                ),
                if (progressdone == false) ...[
                  Positioned(
                    bottom: 5,
                    left: 0,
                    right: 0,
                    child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 80,
                        child: Column(
                          children: [
                            const Text(
                              "Finaliser la creation de l'équipe",
                              style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(223, 252, 252, 252),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  child: LinearPercentIndicator(
                                    width: 300,
                                    animation: true,
                                    percent: 60 / 100,
                                    animationDuration: 1,
                                    lineHeight: 10,
                                    // fillColor: Color.fromARGB(255, 255, 255, 255),
                                    backgroundColor: const Color.fromARGB(
                                        255, 255, 255, 255),

                                    progressColor: const Color.fromARGB(
                                        255, 130, 240, 134),
                                    barRadius: const Radius.circular(16),
                                  ),
                                ),
                                const Text(
                                  "50%",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 252, 252, 252),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 110),
                      child: Center(
                        child: IconButton(
                            icon: IconTheme(
                              data: IconThemeData(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  size: 38),
                              child: Icon(Icons.arrow_drop_down_outlined),
                            ),
                            onPressed: () {
                              // Navigator.push(context, PageTransition(type: PageTransitionType.leftToRight, child: CompleteProgress()));

                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      child: CompleteProgress()));
                            }),
                      ))
                ]
              ])),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          // btn creer Calendrier
          FutureBuilder<List>(
              future: GetAllEvent(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  // print(snapshot);
                }
                if (!snapshot.hasData) {
                  // still waiting for data to come
                  return CircularProgressIndicator();
                } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                  // got data from snapshot but it is empty

                  return showwhennodata(context);
                } else {
                  return FetchData();
                }
              }),
        ],
      ),
    );
  }

  SizedBox showwhennodata(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width - 10,
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(children: [
              const SizedBox(
                height: 30,
              ),
              Image.asset(
                "assets/calendarwhite.PNG",
                height: (165),
                width: (235),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Aucun événement en cours",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 14, 14, 14),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Cette fonctionnalité vous permet d'accéder a l'organisation de tous vos matchs , entrainements,3ème mi-temps ...",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Color.fromARGB(255, 159, 159, 159),
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                width: 250,
                height: 45, // <-- Your width
                child: Container(
                  // padding: EdgeInsets.only(top: 30),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        Editaddevent(context).then((value) => setState(() {}));
                        // progressdone = true;
                        // hasdata = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(
                            255, 19, 209, 143) //elevated btton background color
                        ),
                    child: const Text(
                      "Créer un événement",
                      style: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ])));
  }

  Column FetchData() {
    return Column(
      children: [
        const Align(
          alignment: Alignment(-0.8, 0.5),
          child: Text(
            "Terminés",
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 19,
              color: Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        FutureBuilder<List>(
            future: GetAllEvent(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                // print(snapshot);
              }
              if (!snapshot.hasData) {
                // still waiting for data to come
                return CircularProgressIndicator();
              } else if (snapshot.data == null) {
                // got data from snapshot but it is empty

                return showwhennodata(context);
              } else {
                return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(), //<--here

                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, i) {
                      //date
                      DateTime tempDate = new DateFormat("yyyy-MM-dd hh:mm:ss")
                          .parse(snapshot.data![i]["dateFin"]);

                      final format = DateFormat('HH:mm ');
                      final clockString = format.format(tempDate);

                      DateFormat formatter = DateFormat('MMM');
                      String monthAbbr = formatter.format(tempDate);
                      DateFormat formatter2 = DateFormat('EEEE');
                      DateFormat formatter3 = DateFormat('dd');
                      String dayAbbr2 = formatter3.format(tempDate);
                      String dayAbbr1 = formatter2.format(tempDate);
                      String dayAbbr = dayAbbr1.substring(0, 3);
                      // end date
                      // print(tempDate.isAfter(date));
                      if (tempDate.isBefore(date)) {
                        // print("in the first if");

                        return card(context, snapshot, i, dayAbbr, dayAbbr2,
                            monthAbbr, clockString);
                      }
                      return SizedBox();
                    });
              }
            }),
// yelzem nkasamhom !!
        const SizedBox(
          height: 20,
        ),
        const Align(
          alignment: Alignment(-0.8, 0.5),
          child: Text(
            "À venir",
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 19,
              color: Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),

        FutureBuilder<List>(
          future: GetAllEvent(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              // print(snapshot);
            }
            if (!snapshot.hasData) {
              // still waiting for data to come
              return CircularProgressIndicator();
            } else if (snapshot.data == null) {
              // got data from snapshot but it is empty

              return showwhennodata(context);
            } else {
              return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(), //<--here

                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, i) {
                    DateTime tempDate = new DateFormat("yyyy-MM-dd hh:mm:ss")
                        .parse(snapshot.data![i]["dateFin"]);

                    final format = DateFormat('HH:mm ');
                    final clockString = format.format(tempDate);

                    DateFormat formatter = DateFormat('MMM');
                    String monthAbbr = formatter.format(tempDate);
                    DateFormat formatter2 = DateFormat('EEEE');
                    DateFormat formatter3 = DateFormat('dd');
                    String dayAbbr2 = formatter3.format(tempDate);
                    String dayAbbr1 = formatter2.format(tempDate);
                    String dayAbbr = dayAbbr1.substring(0, 3);
                    if (tempDate.isAfter(date)) {
                      if (snapshot.data![i]["nomAdversaire"].length == 0) {
                        return card(context, snapshot, i, dayAbbr, dayAbbr2,
                            monthAbbr, clockString);
                      } else {
                        return Column(children: [
                          InkWell(
                            onTap: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CalendrierDetail(
                                          id: snapshot.data![i]["_id"],
                                        )),
                              ).then((value) => setState(() {}))
                            },
                            child: Container(
                                height: 130,
                                width: MediaQuery.of(context).size.width - 40,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 10,
                                          spreadRadius: 3)
                                    ]),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 90,
                                      alignment: Alignment.center,
                                      width: 60,
                                      child: Column(
                                        children: [
                                          Text(
                                            dayAbbr +
                                                "\n" +
                                                dayAbbr2 +
                                                "\n" +
                                                monthAbbr +
                                                "\n" +
                                                clockString +
                                                "\n",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 15.5,
                                              color: Color.fromARGB(
                                                  255, 129, 129, 129),
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                        height: 80,
                                        child: const VerticalDivider(
                                            color:
                                                Color.fromARGB(255, 0, 0, 0))),
                                    Container(
                                        width: 250,
                                        height: 200,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                IconTheme(
                                                  data: IconThemeData(
                                                      color: Color.fromARGB(
                                                          255, 200, 200, 200),
                                                      size: 28),
                                                  child: Icon(
                                                      Icons.device_hub_sharp),
                                                ),
                                                Text(
                                                  snapshot.data![i]
                                                      ["nomEvenement"],
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color.fromARGB(
                                                        255, 163, 163, 163),
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            if (snapshot
                                                    .data![i]["nomAdversaire"]
                                                    .length >
                                                0) ...[
                                              Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    new Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Container(
                                                          child: Text(
                                                            nc,
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: TextStyle(
                                                              fontSize: 19,
                                                              color: Color
                                                                  .fromARGB(255,
                                                                      0, 0, 0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            ),
                                                          ),
                                                        )),
                                                    const SizedBox(
                                                      width: 20,
                                                    )
                                                  ]),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                            ],
                                            if (snapshot
                                                    .data![i]["nomAdversaire"]
                                                    .length >
                                                0) ...[
                                              Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Container(
                                                          child: Text(
                                                            snapshot.data![i][
                                                                "nomAdversaire"],
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: TextStyle(
                                                              fontSize: 19,
                                                              color: Color
                                                                  .fromARGB(255,
                                                                      0, 0, 0),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            ),
                                                          ),
                                                        )),
                                                    const SizedBox(
                                                      width: 20,
                                                    )
                                                  ]),
                                            ],
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Row(children: [
                                              Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Container(
                                                    child: Text(
                                                      snapshot.data![i]
                                                          ["lieuEvenement"],
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontSize: 19,
                                                        color: Color.fromARGB(
                                                            255, 167, 167, 167),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  )),
                                              const Spacer(),
                                              // const IconTheme(
                                              //   data: IconThemeData(
                                              //       color: Color.fromARGB(
                                              //           255, 244, 215, 0),
                                              //       size: 18),
                                              //   child: Icon(
                                              //       Icons.people_alt_outlined),
                                              // ),
                                              // Align(
                                              //     alignment:
                                              //         Alignment.centerLeft,
                                              //     child: Container(
                                              //       // working here
                                              //       child: Text(
                                              //         membrelength[i]
                                              //             .toString(),
                                              //         textAlign: TextAlign.left,
                                              //         style: TextStyle(
                                              //           fontSize: 19,
                                              //           color: Color.fromARGB(
                                              //               255, 244, 215, 0),
                                              //           fontWeight:
                                              //               FontWeight.w500,
                                              //         ),
                                              //       ),
                                              //     )),
                                            ]),
                                          ],
                                        ))
                                  ],
                                )),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ]);
                      }
                    }
                    return SizedBox();
                  });
            }
          },
        ),
      ],
    );
  }

  Column card(
      BuildContext context,
      AsyncSnapshot<List<dynamic>> snapshot,
      int i,
      String dayAbbr,
      String dayAbbr2,
      String monthAbbr,
      String clockString) {
    return Column(children: [
      InkWell(
          onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CalendrierDetail(
                            id: snapshot.data![i]["_id"],
                          )),
                ).then((value) => setState(() {}))
              },
          child: Container(
              height: 110,
              width: MediaQuery.of(context).size.width - 40,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 3)
                  ]),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          dayAbbr +
                              "\n" +
                              dayAbbr2 +
                              "\n" +
                              monthAbbr +
                              "\n" +
                              clockString +
                              "\n",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15.5,
                            color: Color.fromARGB(255, 129, 129, 129),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      height: 80,
                      child: const VerticalDivider(
                          color: Color.fromARGB(255, 0, 0, 0))),
                  Text(
                    snapshot.data![i]["nomEvenement"],
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 19,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ))),
      SizedBox(
        height: 10,
      ),
    ]);
  }
}
