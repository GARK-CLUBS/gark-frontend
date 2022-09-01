import 'dart:convert';

import 'package:custom_check_box/custom_check_box.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddDepenses extends StatefulWidget {
  const AddDepenses({Key? key, required this.type}) : super(key: key);
  final String type;
  @override
  State<AddDepenses> createState() => _AddDepensesState();
}

GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

TextEditingController namepersons = TextEditingController();
TextEditingController namepersons2 = TextEditingController();
TextEditingController _pack = TextEditingController();
TextEditingController _frais = TextEditingController();
TextEditingController _amount = TextEditingController();
bool shouldCheckDefault = false;
bool _isButtonDisabled = true;
String? dropdownAbonnement;
var itemsAbonnement = [
  'Annuel',
  'Trimestriel',
  'Semestriel',
  'Mensuel',
];
final TextEditingController birthInput = TextEditingController();

class _AddDepensesState extends State<AddDepenses> {
  String _baseUrl = "10.0.2.2:3000";

  var userStatus = <bool>[];
  var memberslist = [];
  var membersselected = [];
  var membersname = [];
  var membersselectedname = [];
  var memberstopost = [];
  String cn = "";
  SharedPreferences? prefs;
  Future<List> GetAllMembres() async {
    try {
      Map<String, String> headers = {
        "Content-Type": "application/json; charset=UTF-8",
      };
      prefs = await SharedPreferences.getInstance();
      cn = prefs!.getString("participantClub")!;
      var response = await http.get(
          Uri.parse(
              "http://10.0.2.2:3000/api/evenements/presence/62f3def0bbf1a12e96403830"),
          headers: headers);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        // if (data[0]["club"].length >0) {
        //   hasdata = true;
        //   print("bigger");
        // }
        // print(data[0]["evenement"].length);
        memberslist = [];
        membersselectedname = [];
        membersname = [];
        membersselected = [];
        //  print(data[0]["evenement"]);
        memberslist.add(data[0]["evenement"]);
        userStatus = [];
        for (var u in data[0]["evenement"]) {
          userStatus.add(false);
        }

        print(userStatus);
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
    // print("his");
    // print(id);
    http.Response response = await http.get(
        Uri.parse("http://10.0.2.2:3000/api/membres/" + id),
        headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      // print("data");
      // print(data);
      // membersname = [];

      // print(data["nom"]);
      return data["nom"];
    } else {
      return " ";
    }
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
      centerTitle: true, // this is all you need

      elevation: 10,
      backgroundColor: const Color.fromARGB(255, 2, 0, 50),
      title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Payment',
              textAlign: TextAlign.center,
              style: TextStyle(),
            ),
          ]),
    );
  }

  Widget getBody() {
    return Form(
      key: _keyForm,
      child: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        color: Colors.white,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 20,
          ),
          Text(
            "Ajouter un paiement",
            style: TextStyle(
              fontSize: 16,
              color: Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 30),
          TextFormField(
            controller: namepersons,
            decoration: const InputDecoration(
              labelText: "Type ",
              labelStyle: TextStyle(
                  color: Color.fromARGB(221, 179, 179, 179),
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
          TextFormField(
            keyboardType: TextInputType.number,
            controller: _amount,
            decoration: const InputDecoration(
              labelText: 'Amount:',
              labelStyle: TextStyle(
                  color: Colors.black87,
                  fontSize: 17,
                  fontFamily: 'AvenirLight'),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
              ),
            ),
            style: TextStyle(
                color: Colors.black87, fontSize: 17, fontFamily: 'AvenirLight'),
            validator: (value) {
              if (value!.isEmpty) {
                return "Veuillez renseigner votre somme .";
              } else {
                return null;
              }
            },
          ),
          Container(
            margin: EdgeInsets.only(top: 100, bottom: 50),
            alignment: Alignment.center,
            child: SizedBox(
              width: 250,
              height: 45, // <-- Your width
              child: ElevatedButton(
                onPressed: () async {
                  if (_keyForm.currentState!.validate()) {
                    //   _keyForm.currentState!.save();
                    prefs = await SharedPreferences.getInstance();
                    cn = prefs!.getString("participantClub")!;
                    Map<String, dynamic> ClubData = {
                      "_id": cn,
                    };
                    print(memberstopost);
                    Map<String, dynamic> membreData = {
                      "_id": memberstopost,
                    };
                    Map<String, dynamic> userData = {
                      "type": widget.type,
                      "sousType": namepersons.text,
                      "montant": _amount.text,
                      "club": ClubData,
                    };

                    Map<String, String> headers = {
                      "Content-Type": "application/json; charset=UTF-8"
                    };

                    http
                        .post(Uri.http(_baseUrl, "/api/depanses/"),
                            headers: headers, body: json.encode(userData))
                        .then((http.Response response) async {
                      print(userData);
                      if (response.statusCode == 201) {
                        _keyForm.currentState?.reset();
                        namepersons.clear();
                        namepersons2.clear();
                        _pack.clear();
                        _frais.clear();
                        _amount.clear();
                        Navigator.pop(context);
                    
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
                  }
                },
                style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(
                        255, 14, 178, 120) //elevated btton background color
                    ),
                child: Text(
                  "Valider",
                  style: TextStyle(
                    fontSize: 15,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ]),
      )),
    );
  }

  Future<dynamic> bottomsheet(TextEditingController a) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter state) {
            return FractionallySizedBox(
                heightFactor: 0.91,
                child: Wrap(children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 2, 0, 50),
                    ),
                    child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 10),
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.arrow_back,
                                  color: Color.fromARGB(255, 255, 255, 255)),
                              onPressed: () => Navigator.pop(context),
                            ),
                            Align(
                              alignment: Alignment(-1, 0),
                              child: Text(
                                "Choisir une ou plusieurs personnes ",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              child: GestureDetector(
                                onTap: () {
                                  state(() => {
                                        memberstopost.addAll(membersselected),
                                        a.text = "",
                                        for (int i = 0;
                                            i < membersselectedname.length;
                                            i++)
                                          {
                                            a.text = a.text +
                                                membersselectedname[i] +
                                                " , ",
                                          },
                                      });
                                  print(memberstopost);
                                  _isButtonDisabled = false;
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "Valider",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(197, 215, 215, 215),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                  Container(
                      width: double.maxFinite,
                      height: 750,
                      child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(), // new
                          shrinkWrap: true,
                          itemCount: 1,
                          itemBuilder: (_, index) {
                            return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    children: <Widget>[
                                      Container(
                                          child: Stack(children: <Widget>[
                                        Container(
                                          height:
                                              80, // change it to 140 idha nheb nrejaaha kima kenet
                                          decoration: const BoxDecoration(
                                            color:
                                                Color.fromARGB(255, 2, 0, 50),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 20,
                                          left: 0,
                                          right: 0,
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            height: 44,
                                            child: Container(
                                              width: double.infinity,
                                              height: 38,
                                              decoration: BoxDecoration(
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.3),
                                                        blurRadius: 15,
                                                        spreadRadius: 5)
                                                  ]),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  IconButton(
                                                      onPressed: () {},
                                                      icon: Icon(
                                                        Icons.search,
                                                        color: Colors.black,
                                                      )),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Flexible(
                                                    child: TextField(
                                                      cursorColor: Colors.black,
                                                      decoration: InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          hintText:
                                                              "Search for contacts"),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ])),
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 20, left: 15),
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Align(
                                              alignment: Alignment(-0.5, 0),
                                              child: IconTheme(
                                                data: IconThemeData(
                                                    color: Color.fromARGB(
                                                        255, 0, 0, 0),
                                                    size: 22),
                                                child:
                                                    Icon(Icons.arrow_drop_down),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment(-0.8, 0),
                                              child: Text(
                                                "Présent",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                                child: Divider(
                                              height: 20,
                                              thickness: 1,
                                            )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  // from here
                                  FutureBuilder<List>(
                                      future: GetAllMembres(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasError) {
                                          // print(snapshot);
                                        }
                                        if (!snapshot.hasData) {
                                          // still waiting for data to come
                                          return CircularProgressIndicator();
                                        } else if (snapshot.data == null) {
                                          // got data from snapshot but it is empty

                                          return SizedBox();
                                        } else {
                                          // print(
                                          //     snapshot.data);
                                          return ListView.builder(
                                              physics:
                                                  const NeverScrollableScrollPhysics(), //<--here

                                              shrinkWrap: true,
                                              itemCount: snapshot.data?.length,
                                              itemBuilder: (context, i) {
                                                // membersname.add(
                                                //     snapshot.data![i]["nom"]);

                                                return Container(
                                                    width: double.maxFinite,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                    ),
                                                    child: Container(
                                                        margin: const EdgeInsets
                                                                .symmetric(
                                                            vertical: 10),
                                                        child: Column(
                                                            children: [
                                                              Row(
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
                                                                  SizedBox(
                                                                    width: 15,
                                                                  ),

                                                                  FutureBuilder<
                                                                          String>(
                                                                      future: fetchDocs2(snapshot
                                                                          .data![
                                                                              i]
                                                                          .substring(
                                                                              0,
                                                                              snapshot.data![i].indexOf(
                                                                                  ':'))),
                                                                      builder:
                                                                          (context,
                                                                              snapshot) {
                                                                        if (snapshot
                                                                            .hasError) {
                                                                          // print(snapshot);
                                                                        }
                                                                        if (!snapshot
                                                                            .hasData) {
                                                                          // still waiting for data to come
                                                                          return CircularProgressIndicator();
                                                                        } else if (snapshot.data ==
                                                                            null) {
                                                                          // got data from snapshot but it is empty

                                                                          return Text(
                                                                              "context");
                                                                        } else {
                                                                          membersname
                                                                              .add(snapshot.data);
                                                                          // print("snap");
                                                                          // print(snapshot
                                                                          //     .data);
                                                                          return Align(
                                                                            child:
                                                                                Text(
                                                                              //   fetchDocs2(snapshot.data![i].substring(0,snapshot.data![i].indexOf(':'))) ,
                                                                              snapshot.data!,
                                                                              textAlign: TextAlign.left,
                                                                              style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.w400),
                                                                            ),
                                                                          );
                                                                        }
                                                                      }),

                                                                  // if (userStatus[i] == false) {userStatus[i] = true, membersselected.add(snapshot.data!)} else {userStatus[i] = false, membersselected.remove(i)} ,print(membersselected)
                                                                  // when clicked yelzem bottom bar fiha update
                                                                  Spacer(),
                                                                  StatefulBuilder(builder: (BuildContext
                                                                          context,
                                                                      StateSetter
                                                                          state) {
                                                                    return CustomCheckBox(
                                                                      checkedFillColor:
                                                                          const Color.fromARGB(
                                                                              255,
                                                                              2,
                                                                              0,
                                                                              50),
                                                                      borderColor:
                                                                          Colors
                                                                              .grey,
                                                                      checkBoxSize:
                                                                          20,
                                                                      value:
                                                                          userStatus[
                                                                              i],
                                                                      tooltip:
                                                                          ' Check Box',
                                                                      onChanged:
                                                                          (val) {
                                                                        state(() =>
                                                                            {
                                                                              if (userStatus[i] == false)
                                                                                {
                                                                                  userStatus[i] = true,
                                                                                  membersselected.add(
                                                                                    snapshot.data![i].substring(0, snapshot.data![i].indexOf(':')),
                                                                                  ),
                                                                                  membersselectedname.add(membersname[i]),
                                                                                  // print("les membres selectionnes "),
                                                                                  // print(membersselected),
                                                                                  // print(userStatus),
                                                                                  // print("les noms membres   "),
                                                                                  // print(membersname),
                                                                                  // print("les noms membres selectionnes "),
                                                                                  // print(membersselectedname)
                                                                                }
                                                                              else
                                                                                {
                                                                                  userStatus[i] = false,
                                                                                  membersselected.remove(
                                                                                    snapshot.data![i].substring(0, snapshot.data![i].indexOf(':')),
                                                                                  ),
                                                                                  membersselectedname.remove(membersname[i]),
                                                                                  // print(membersselected),
                                                                                  // print(membersselectedname),
                                                                                  // print(userStatus)
                                                                                }
                                                                            });
                                                                      },
                                                                    );
                                                                  }),
                                                                ],
                                                              ),
                                                            ])));
                                              });
                                          // to here
                                        }
                                      })
                                ]);
                          }))
                ]));
          });
        });
  }
}
