import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:garkproject/data/TacheData.dart';
import 'package:garkproject/pages/Equipe/AddEquipe.dart';
import 'package:garkproject/pages/Equipe/EquipeDetail.dart';
import 'package:garkproject/pages/Equipe/UpdateEquipe.dart';
import 'package:garkproject/pages/Membre/AddMembre.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Equipe extends StatefulWidget {
  const Equipe({Key? key}) : super(key: key);

  @override
  _EquipeState createState() => _EquipeState();
}

SharedPreferences? prefs;

String cn = "";

enum _MenuValues { modifier, supprimer }

Future<List> GetAllEquipe() async {
  try {
    prefs = await SharedPreferences.getInstance();
    cn = prefs!.getString("participantClub")!;
    var response =
        await http.get(Uri.parse("http://10.0.2.2:3000/api/clubs/alleq/" + cn));
    if (response.statusCode == 200) {

      return jsonDecode(response.body);
    } else {
      return Future.error("server error");
    }
  } catch (e) {
    return Future.error(e);
  }
}

class _EquipeState extends State<Equipe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:
          PreferredSize(child: getAppBar(), preferredSize: Size.fromHeight(0)),
      body: getBody(),
    );
  }

  Widget getAppBar() {
    return AppBar(
      elevation: 10,
      backgroundColor: Color.fromARGB(255, 2, 0, 50),
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
                  height: 80, // change it to 140 idha nheb nrejaaha kima kenet
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 2, 0, 50),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(36),
                        bottomRight: Radius.circular(36),
                      )),
                ),
                //uncomment to get clubs name 9bal search
                /*  Positioned(
                  bottom: 60,
                  left: 10,
                  right: 0,
                  child: Container(
                      child: Column(children: <Widget>[
                    SizedBox(
                      height: 45,
                      width: 100,
                    ),
                    ListTile(
                      title: Text(
                        //display club
                        "FC BARCELONA",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w800),
                      ),
                      leading: Container(
                        width: 75,
                        height: 95,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            border: Border.all(color: Colors.black)),
                        child: Center(
                          child: Container(
                            width: 160,
                            height: 160,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "https://sportbusiness.club/wp-content/uploads/2020/05/Football-Club-FC-Barcelone-1-678x381.jpg"),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                      ),
                    ),
                  ])),
                ),*/
                Positioned(
                  bottom: -10,
                  left: 0,
                  right: 0,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height: 54,
                    child: Container(
                      width: double.infinity,
                      height: 48,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.3),
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
                                  border: InputBorder.none,
                                  hintText: "Search for contacts"),
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
          SizedBox(
            height: 10,
          ),
          // btn creer equipe
          Container(
            alignment: Alignment(-0.8, 0),
            padding: EdgeInsets.only(top: 10),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddEquipe()),
                ).then((value) => setState(() {}));
              },
              icon: Icon(
                  Icons.accessibility_outlined), //icon data for elevated button
              label: Text("Créer une équipe"), //label text
              style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(
                      255, 14, 178, 120) //elevated btton background color
                  ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
              child: FutureBuilder<List>(
            future: GetAllEquipe(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(), //<--here

                    shrinkWrap: true,
                    //  snapshot.data?.length
                    itemCount: snapshot.data?[0]["equipe"].length,
                    itemBuilder: (context, i) {
                      return Padding(
                          padding: const EdgeInsets.all(10),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EquipeDetail(
                                        id: snapshot.data![0]["equipe"][i]
                                            ["_id"])),
                              ).then((value) => setState(() {}));
                            },
                            child: Container(
                              height: 100,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.55),
                                        spreadRadius: 2,
                                        blurRadius: 15,
                                        offset: Offset(0, 1))
                                  ],
                                  color: Colors.white.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(33)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceEvenly, // use whichever suits your need

                                children: [
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    width: 65,
                                    height: 65,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(28),
                                        border:
                                            Border.all(color: Colors.black)),
                                    child: Center(
                                      child: Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    "https://sportbusiness.club/wp-content/uploads/2020/05/Football-Club-FC-Barcelone-1-678x381.jpg"),
                                                fit: BoxFit.cover)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          snapshot.data![0]["equipe"][i]
                                              ["Name"],
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                            snapshot.data![0]["equipe"][i]
                                                ["CategorieAge"],
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black
                                                    .withOpacity(0.5))),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                      alignment: Alignment(0, 0),
                                      child: SizedBox.fromSize(
                                        size: Size(56, 56),
                                        child: ClipOval(
                                          child: Material(
                                            color: Colors.grey.withOpacity(0.0),
                                            child: InkWell(
                                              splashColor: Color.fromARGB(
                                                  255, 248, 248, 248),
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (c) =>
                                                            AddMembre(id: snapshot.data![0]
                                                                  ["equipe"][i]
                                                              ["_id"])));
                                              },
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Icon(Icons.add), // <-- Icon
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      )),
                                  Container(
                                    child: PopupMenuButton(
                                      itemBuilder: (BuildContext) => [
                                        PopupMenuItem(
                                          child: Text('Modifier l equipe'),
                                          value: _MenuValues.modifier,
                                        ),
                                        const PopupMenuItem(
                                          child: Text('Supprimer l equipe',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red)),
                                          value: _MenuValues.supprimer,
                                        )
                                      ],
                                      onSelected: (value) {
                                        switch (value) {
                                          case _MenuValues.modifier:
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UpdateEquipe(
                                                          id: snapshot.data![0]
                                                                  ["equipe"][i]
                                                              ["_id"])),
                                            ).then((value) => setState(() {}));

                                            break;
                                          case _MenuValues.supprimer:
                                            Map<String, String> headers = {
                                              "Content-Type":
                                                  "application/json; charset=UTF-8"
                                            };
                                            http
                                                .delete(
                                              Uri.http(
                                                  "10.0.2.2:3000",
                                                  "/api/equipes/" +
                                                      snapshot.data![0]
                                                          ["equipe"][i]["_id"]),
                                              headers: headers,
                                            )
                                                .then((http.Response
                                                    response) async {
                                              if (response.statusCode == 200) {
                                                // refresh delete
                                                setState(() {
                                                  GetAllEquipe();
                                                });
                                              } else if (response.statusCode ==
                                                  401) {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return const AlertDialog(
                                                        title:
                                                            Text("Information"),
                                                        content: Text(
                                                            "Username et/ou mot de passe incorrect"),
                                                      );
                                                    });
                                              } else {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return const AlertDialog(
                                                        title:
                                                            Text("Information"),
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
                            ),
                          ));
                    });
              } else {
                return Text("");
              }
            },
          ))
        ],
      ),
    );
  }
}
