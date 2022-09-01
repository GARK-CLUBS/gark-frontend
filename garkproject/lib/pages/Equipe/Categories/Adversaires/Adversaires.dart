import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:garkproject/pages/Equipe/Categories/Adversaires/AddAdversaires.dart';
import 'package:garkproject/pages/Equipe/Categories/Adversaires/updateAdversaire.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Adversaires extends StatefulWidget {
  const Adversaires({Key? key, required this.equipeid}) : super(key: key);
  final String equipeid;

  @override
  State<Adversaires> createState() => _AdversairesState();
}

enum _MenuValues { modifier, supprimer }

class _AdversairesState extends State<Adversaires> {
  SharedPreferences? prefs;
  String cn = "";
  int nb = 0;

  Future<List> GetAllAdversaire() async {
    try {
      prefs = await SharedPreferences.getInstance();
      cn = prefs!.getString("participantClub")!;
      var response = await http.get(Uri.parse(
          "http://10.0.2.2:3000/api/equipes/alladversaire/" +
              '${widget.equipeid}'));
      var data = json.decode(response.body);

      if (response.statusCode == 200) {
        setState(() {
          nb = data[0]["equipe"].length;
        });
        return jsonDecode(response.body);
      } else {
        return Future.error("server error");
      }
    } catch (e) {
      return Future.error(e);
    }
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
      elevation: 10,
      backgroundColor: const Color.fromARGB(255, 2, 0, 50),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Color.fromARGB(255, 255, 255, 255)),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Row(children: <Widget>[
        Spacer(),
        Text(
          "Liste des adversaires",
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
                                AddAdversaires(equipeid: widget.equipeid)),
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
        Row(
          children: [
            SizedBox(
              width: 20,
            ),
            Align(
              alignment: Alignment(-0.5, 0),
              child: Text(
                nb > 1
                    ? nb.toString() + " adversaires "
                    : nb.toString() + " adversaire",
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
        Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: FutureBuilder<List>(
              future: GetAllAdversaire(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(), //<--here

                      shrinkWrap: true,
                      //  snapshot.data?.length
                      itemCount: snapshot.data?[0]["equipe"].length,
                      itemBuilder: (context, i) {
                        return Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 30.0,
                                    backgroundImage: NetworkImage(
                                        "https://www.simplilearn.com/ice9/free_resources_article_thumb/what_is_image_Processing.jpg"),
                                    backgroundColor: Colors.transparent,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),

                                  Align(
                                    child: Text(
                                      snapshot.data?[0]["equipe"][i]["nom"],
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  //  _displayDialogDelete(context);
                                  // when clicked yelzem bottom bar fiha update
                                  Spacer(),
                                  Container(
                                    child: PopupMenuButton(
                                      itemBuilder: (BuildContext) => [
                                        PopupMenuItem(
                                          child: Text('Modifier le membre'),
                                          value: _MenuValues.modifier,
                                        ),
                                        const PopupMenuItem(
                                          child: Text('Supprimer le membre',
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
                                                      updateAdversaire(
                                                          id: snapshot.data![0]
                                                                  ["equipe"][i]
                                                              ["_id"],
                                                          equipeid:
                                                              widget.equipeid)),
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
                                                  "/api/adversaires/" +
                                                      snapshot.data![0]
                                                              ["equipe"][i]
                                                              ["_id"]
                                                          .toString()),
                                              headers: headers,
                                            )
                                                .then((http.Response
                                                    response) async {
                                              if (response.statusCode == 200) {
                                                // refresh delete
                                                setState(() {
                                                  GetAllAdversaire();
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
                            ]));
                      });
                } else {
                  return Text("");
                }
              }),
        )
      ])
    ]));
  }
}
