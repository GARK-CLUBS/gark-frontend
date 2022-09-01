import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:garkproject/pages/Equipe/Categories/Stades/AddStade.dart';
import 'package:garkproject/pages/Equipe/Categories/Stades/UpdateStade.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Stade extends StatefulWidget {
  const Stade({Key? key, required this.equipeid}) : super(key: key);
  final String equipeid;
  @override
  State<Stade> createState() => _StadeState();
}

bool _nodata = false;
SharedPreferences? prefs;
String cn = "";
int nb = 0;

enum _MenuValues { modifier, supprimer }

class _StadeState extends State<Stade> {
  Future<List> GetAllStade() async {
    try {
      prefs = await SharedPreferences.getInstance();
      cn = prefs!.getString("participantClub")!;
      var response = await http.get(Uri.parse(
          "http://10.0.2.2:3000/api/equipes/allstades/" +
              '${widget.equipeid}'));
      if (response.statusCode == 200) {
        // nb = response.body["equipe"].length;
        var data = json.decode(response.body);
        setState(() {
          nb = data[0]["equipe"].length;
        });
     //   print(data[0]["equipe"].length);
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
    GetAllStade();
    super.initState();
  }

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
          "Liste des stades",
          style: TextStyle(),
        ),
        Spacer(),
        Container(
            alignment: Alignment(0, 1),
            child: SizedBox.fromSize(
              size: Size(56, 56),
              child: ClipOval(
                child: Material(
                  color: Colors.grey.withOpacity(0.0),
                  child: InkWell(
                    splashColor: Color.fromARGB(255, 248, 248, 248),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AddStade(equipeid: widget.equipeid)),
                      ).then((value) => setState(() {}));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.add), // <-- Icon
                      ],
                    ),
                  ),
                ),
              ),
            )),
      ]),
    );
  }

  Widget getBody() {
    return SingleChildScrollView(
        child: Column(children: [
      Column(children: <Widget>[
        SizedBox(
          height: 30,
        ),
     
        FutureBuilder<List>(
            future: GetAllStade(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                // print(snapshot);
              }
              if (!snapshot.hasData) {
                // still waiting for data to come
                return CircularProgressIndicator();
              } else if (snapshot.data!.isEmpty) {
                // got data from snapshot but it is empty

                return Container(
                  color: Color.fromARGB(255, 245, 245, 245),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 7),
                        child: Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Image.asset("assets/stade.PNG", width: 100),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            "Stades ",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Retrouvez ici l'ensemble des stades de votre équipe",
                            style: TextStyle(
                                color: Color.fromARGB(255, 134, 134, 134)),
                          ),
                          // btn
                          Container(
                            margin: EdgeInsets.only(top: 30),
                            width: 250,
                            height: 45, // <-- Your width
                            child: Container(
                              // padding: EdgeInsets.only(top: 30),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddStade(
                                            equipeid: widget.equipeid)),
                                  ).then((value) => setState(() {}));
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Color.fromARGB(199, 23, 187, 83),
                                ),
                                child: Text(
                                  "Ajouter un stade ",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              } else {
                return Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Align(
                          alignment: Alignment(-0.5, 0),
                          child: Text(
                            nb > 1
                                ? nb.toString() + " stades "
                                : nb.toString() + " stade",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                     SizedBox(
                          width: 20,
                        ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(), //<--here

                          shrinkWrap: true,
                          //  snapshot.data?.length
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, i) {
                            return Container(
                                width: double.maxFinite,
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Container(
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 10),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Align(
                                                    child: Text(
                                                      snapshot.data?[i]["nom"],
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Color.fromARGB(
                                                              255, 0, 0, 0),
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment: Alignment(-1, 0),
                                                    child: Text(
                                                      snapshot.data?[i]
                                                          ["adresse"],
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Color.fromARGB(
                                                              255, 0, 0, 0),
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              //  _displayDialogDelete(context);
                                              // when clicked yelzem bottom bar fiha update
                                              Spacer(),
                                              Container(
                                                child: PopupMenuButton(
                                                  itemBuilder: (BuildContext) => [
                                                    PopupMenuItem(
                                                      child: Text(
                                                          'Modifier le membre'),
                                                      value: _MenuValues.modifier,
                                                    ),
                                                    const PopupMenuItem(
                                                      child: Text(
                                                          'Supprimer le membre',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              color: Colors.red)),
                                                      value:
                                                          _MenuValues.supprimer,
                                                    )
                                                  ],
                                                  onSelected: (value) {
                                                    switch (value) {
                                                      case _MenuValues.modifier:
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  updateStade(
                                                                      id: snapshot
                                                                              .data![i]
                                                                          ["_id"],
                                                                      equipeid: widget
                                                                          .equipeid)),
                                                        ).then((value) =>
                                                            setState(() {}));

                                                        break;
                                                      case _MenuValues.supprimer:
                                                        Map<String, String>
                                                            headers = {
                                                          "Content-Type":
                                                              "application/json; charset=UTF-8"
                                                        };
                                                        http
                                                            .delete(
                                                          Uri.http(
                                                              "10.0.2.2:3000",
                                                              "/api/stades/" +
                                                                  snapshot
                                                                      .data![i]
                                                                          ["_id"]
                                                                      .toString()),
                                                          headers: headers,
                                                        )
                                                            .then((http.Response
                                                                response) async {
                                                          if (response
                                                                  .statusCode ==
                                                              200) {
                                                            // refresh delete
                                                            setState(() {
                                                              GetAllStade();
                                                            });
                                                          } else if (response
                                                                  .statusCode ==
                                                              401) {
                                                            showDialog(
                                                                context: context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return const AlertDialog(
                                                                    title: Text(
                                                                        "Information"),
                                                                    content: Text(
                                                                        "Username et/ou mot de passe incorrect"),
                                                                  );
                                                                });
                                                          } else {
                                                            showDialog(
                                                                context: context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return const AlertDialog(
                                                                    title: Text(
                                                                        "Information"),
                                                                    content: Text(
                                                                        "Une erreur s'est produite. Veuillez réessayer !"),
                                                                  );
                                                                });
                                                          }
                                                        });
                                                        break;
                                                    }
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                        ])));
                          }),
                    ),
                  ],
                );
              }
            })
      ]),
    ]));
  }
}
