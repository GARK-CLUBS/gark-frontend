import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:garkproject/pages/Calendrier/Calendrier.dart';

class ParamsEvent extends StatefulWidget {
  const ParamsEvent({Key? key}) : super(key: key);

  @override
  State<ParamsEvent> createState() => _ParamsEventState();
}

List<String> menu = [
  "Notes et votes",
  "Convocations",
];
var itemsevent = [
  'Tous les evenements',
  'Tunisienne',
  'match entre nous',
  'Match amical',
];
var itemsrole = [
  'Coachs',
  'Coachs + participants',
];
String? dropdownevent;
var _selected = "";
var selected = 0;
bool _note = true;
bool _convocation = false;
final TextEditingController datearriveInput = TextEditingController();
bool status1 = false;
bool status2 = false;
bool status3 = false;
bool status4 = false;
bool status5 = false;
bool status6 = false;

class _ParamsEventState extends State<ParamsEvent> {
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
      title: Row(children: <Widget>[
        Spacer(),
        Text(
          "Paramètres d'événements",
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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        height: 50.0,
        color: const Color.fromARGB(255, 2, 0, 50),
        child: Center(
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
                        if (menu[index] == "Notes et votes") {
                          _note = true;
                          print("here");
                        } else {
                          _note = false;
                          _convocation = true;
                          print("here");
                        }
                      }),
                    },
                    child: Container(
                        width: (MediaQuery.of(context).size.width) / 2 - 20,
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
      SizedBox(
        height: 10,
      ),
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
        "Match entre nous",
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
      )),
      Center(child: Text("Saison 2021-2022")),
      SizedBox(
        height: 10,
      ),
      if (_note == true) ...[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "Note du match",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
          ),
        ),
        Column(
          children: [
            Container(color: Colors.white, child: ParamComponent(status1))
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "Homme du match",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
          ),
        ),
        Column(
          children: [
            Container(color: Colors.white, child: ParamComponent(status2))
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "Note des joueurs",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
          ),
        ),
        Column(
          children: [
            Container(color: Colors.white, child: ParamComponent(status3))
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            "Les paramètres s'appliqueront sur tous les évènements de la catégorie d'évènement sélectionnée ",
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w700, color: Colors.grey),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Center(
            child: SizedBox(
                width: 115,
                height: 40,
                child: Container(
                    child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(199, 38, 208, 101),
                  ),

                  child: Text(
                    "Enregistrer",
                    style: TextStyle(
                      fontSize: 15,
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.w400,
                    ),
                  ), //label text,
                ))),
          ),
        ),
      ] else ...[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "Paramètres de convocation",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
          ),
        ),
        ConvocationComponent()
      ]
    ])));
  }
// end of body

  StatefulBuilder ConvocationComponent() {
    return StatefulBuilder(builder: (BuildContext context, StateSetter state) {
      return Container(
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0, right: 8, left: 8),
                child: Row(
                  children: [
                    Text(
                      "Convocation automatique ",
                      style: TextStyle(fontSize: 16),
                    ),
                    Spacer(),
                    FlutterSwitch(
                      width: 55.0,
                      height: 25.0,
                      value: status4,
                      onToggle: (val) {
                        // setState(() {
                        //   status4 = val;
                        // });
                        state(() => status4 = val);
                        print(val);
                        print("working");
                      },
                      activeColor: Color.fromARGB(200, 0, 249, 93),
                    ),
                  ],
                ),
              ),
              if (status4 == true) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Avant l'évènement",
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                    ),
                    controller: datearriveInput,
                    readOnly: true,
                    onTap: () {
                      status4 = true;
                      state(() => status4 = true);

                      DatePicker.showDateTimePicker(context,
                          showTitleActions: true, onChanged: (date) {
                        print('change $date in time zone ' +
                            date.timeZoneOffset.inHours.toString());
                      }, onConfirm: (datee) {
                        status4 = true;
                        state(() => status4 = true);

                        setState(() {
                          status4 = true;

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
                ),
              ],
              Padding(
                padding: const EdgeInsets.only(
                    top: 18.0, left: 8, right: 8, bottom: 8),
                child: Row(
                  children: [
                    Text(
                      "Relance automatique ",
                      style: TextStyle(fontSize: 16),
                    ),
                    Spacer(),
                    FlutterSwitch(
                      width: 55.0,
                      height: 25.0,
                      value: status5,
                      onToggle: (val) {
                        // setState(() {
                        //   status5 = val;
                        // });
                        state(() => status5 = val);
                        print(val);
                        print("working");
                      },
                      activeColor: Color.fromARGB(200, 0, 249, 93),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      "Liste d'attente ",
                      style: TextStyle(fontSize: 16),
                    ),
                    Spacer(),
                    FlutterSwitch(
                      width: 55.0,
                      height: 25.0,
                      value: status6,
                      onToggle: (val) {
                        // setState(() {
                        //   status6 = val;
                        // });
                        state(() => status6 = val);
                        print(val);
                        print("working");
                      },
                      activeColor: Color.fromARGB(200, 0, 249, 93),
                    ),
                  ],
                ),
              ),
              if (status6 == true) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
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
                ),
              ],
              Container(
                color: Color.fromARGB(255, 245, 245, 245),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "Les paramètres s'appliqueront sur tous les évènements de la catégorie d'évènement sélectionnée ",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Center(
                        child: SizedBox(
                            width: 115,
                            height: 40,
                            child: Container(
                                child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Color.fromARGB(199, 38, 208, 101),
                              ),

                              child: Text(
                                "Enregistrer",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontWeight: FontWeight.w400,
                                ),
                              ), //label text,
                            ))),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ));
    });
  }

  StatefulBuilder ParamComponent(bool status) {
    return StatefulBuilder(builder: (BuildContext context, StateSetter state) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  "Activer ? ",
                  style: TextStyle(fontSize: 16),
                ),
                Spacer(),
                FlutterSwitch(
                  width: 55.0,
                  height: 25.0,
                  value: status,
                  onToggle: (val) {
                    // setState(() {
                    //   status  = val;
                    // });
                    state(() => status = val);
                    print(val);
                    print("working");
                  },
                  activeColor: Color.fromARGB(200, 0, 249, 93),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  "Qui peut noter/voter ? ",
                  style: TextStyle(fontSize: 16),
                ),
                Spacer(),
                InkWell(
                  onTap: (() async => _displayDialog(context)),
                  child: Text(
                    "Coachs + participants",
                    style: TextStyle(fontSize: 16),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  "Visibilité ",
                  style: TextStyle(fontSize: 16),
                ),
                Spacer(),
                InkWell(
                  onTap: (() async => _displayDialog(context)),
                  child: Text(
                    "Tous les membres de l'équipe",
                    style: TextStyle(fontSize: 16),
                  ),
                )
              ],
            ),
          ),
        ],
      );
    });
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
                                dropdownevent = newValue;
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
                                Navigator.of(context).pop();
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
