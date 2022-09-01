import 'package:dynamic_icons/dynamic_icons.dart';
import 'package:flutter/material.dart';
import 'package:garkproject/pages/Auth/ForgetPass.dart';
import 'package:garkproject/pages/Calendrier/Presence.dart';
import 'package:garkproject/pages/Calendrier/Tache/AddTache.dart';
import 'package:garkproject/pages/Calendrier/Tache/EditTache.dart';
import 'package:garkproject/pages/Calendrier/Tache/Tache.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../data/TacheData.dart';

class SelectTache extends StatefulWidget {
  const SelectTache({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<SelectTache> createState() => _SelectTacheState();
}

class _SelectTacheState extends State<SelectTache> {
  Future<List> GetAllTaches() async {
    try {
      var response = await http.get(Uri.parse(
          "http://10.0.2.2:3000/api/evenements/type/" + '${widget.id}'));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        // print(data[0]["evenement"]);
        return data[0]["evenement"];
      } else {
        return Future.error("server error");
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  var _selected = "";

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Color.fromARGB(255, 244, 244, 244),
        appBar: PreferredSize(
            child: getAppBar(), preferredSize: const Size.fromHeight(50)),
        body: SingleChildScrollView(
            child: Container(
                child: Column(children: [
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment(-0.9, 0),
            child: Text(
              "Choisir une tache",
              style: TextStyle(
                  fontSize: 17,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Column(children: [
                    FutureBuilder<List>(
                        future: GetAllTaches(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                                physics:
                                    const NeverScrollableScrollPhysics(), //<--here
                                shrinkWrap: true,
                                itemCount: snapshot.data?.length,
                                itemBuilder: (BuildContext ctxt, int i) {
                                  // print(snapshot.data);
                                  // print("wer");
                                  return InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (c) => Tache(
                                                  text: snapshot.data![i]
                                                      ["typechoix"],
                                                  id: widget.id,idtype : snapshot.data![i]
                                                      ["_id"])));
                                    },
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(IconData(
                                                snapshot.data![i]["nomIcon"],
                                                fontFamily: 'MaterialIcons')),
                                            // DynamicIcons.getIconFromName(
                                            //     snapshot.data![i]["nomIcon"]),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Align(
                                              alignment: Alignment(-0.9, 0),
                                              child: Text(
                                                snapshot.data![i]["typechoix"],
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                ),
                                              ),
                                            ),
                                            Spacer(),
                                            Container(
                                                alignment: Alignment(0, 1),
                                                child: SizedBox.fromSize(
                                                  child: ClipOval(
                                                    child: Material(
                                                      color: Color.fromARGB(255,
                                                              142, 142, 142)
                                                          .withOpacity(0.0),
                                                      child: InkWell(
                                                        splashColor:
                                                            Color.fromARGB(255,
                                                                248, 248, 248),
                                                        onTap: () {
                                                          _displayDialog(
                                                              context,
                                                              snapshot.data![i]
                                                                  ["typechoix"],
                                                              snapshot.data![i]
                                                                  ["nomIcon"],
                                                              snapshot.data![i]
                                                                  ["_id"]);
                                                        },
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            IconTheme(
                                                              data: IconThemeData(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                  size: 28),
                                                              child: Icon(Icons
                                                                  .more_vert),
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
                                        if (i != usersList.length - 1) ...[
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: Divider(
                                                height: 20,
                                                thickness: 2,
                                              )),
                                            ],
                                          )
                                        ] else ...[
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: SizedBox(
                                                height: 15,
                                              )),
                                            ],
                                          )
                                        ]
                                      ],
                                    ),
                                  );
                                });
                          }
                          return SizedBox();
                        })
                  ]))),
        ]))));
  }

  _displayDialog(BuildContext context, String t, int i, String id) async {
    _selected = await showDialog(
      context: context,
      // barrierDismissible: false,
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
                      t,
                      style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  children: [
                    IconTheme(
                      data: IconThemeData(
                          color: Color.fromARGB(255, 96, 96, 96), size: 52),
                      child: Icon(IconData(i, fontFamily: 'MaterialIcons')),
                      //Icon(Icons.flag_outlined),
                    ),
                    // DynamicIcons.getIconFromName(
                    //   i,
                    //   size: 52,
                    // ),
                    //           Icon(
                    //   i,
                    //   size: 30,
                    // ),
                    // IconTheme(
                    //   data: IconThemeData(
                    //       color: Color.fromARGB(255, 96, 96, 96), size: 52),
                    //   child: Icon(Icons.flag_outlined),
                    // ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: SizedBox(
                        width: 250,
                        height: 45, // <-- Your width
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (c) => EditTache(
                                        id: id,
                                      )));
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(200, 0, 249, 93),
                            ),

                            child: Text(
                              "Editer",
                              style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontWeight: FontWeight.w400,
                              ),
                            ), //label text,
                          ),
                        ),
                      ),
                    ),
                    new GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();

                        _displayDialogDelete(context, id, i,t);
                      },
                      child: Align(
                        alignment: Alignment(0, 0),
                        child: new Text(
                          "Supprimer",
                          style: TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 255, 96, 96),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
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

  _displayDialogDelete(BuildContext contexts, String id, int i,String name) async {
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
                      "Supprimer la tache",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  children: [
                    IconTheme(
                      data: IconThemeData(
                          color: Color.fromARGB(255, 96, 96, 96), size: 52),
                      child: Icon(IconData(i, fontFamily: 'MaterialIcons')),
                      //Icon(Icons.flag_outlined),
                    ),
                    Align(
                      alignment: Alignment(0, 0),
                      child: Text(
                        name,
                        style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 179, 179, 179),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Align(
                        alignment: Alignment(0, 0),
                        child: Text(
                          "Attention : en supprimant cette tache , vous perdrez définitivement tout son historique d'utilisation (sur les feuilles de match et sur les bilans statistiques)",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 205, 104, 104),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: SizedBox(
                        width: 250,
                        height: 45, // <-- Your width
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: ElevatedButton(
                            onPressed: () {
                              Map<String, String> headers = {
                                "Content-Type":
                                    "application/json; charset=UTF-8"
                              };
                              http
                                  .delete(
                                Uri.http("10.0.2.2:3000", "/api/types/" + id),
                                headers: headers,
                              )
                                  .then((http.Response response) async {
                                if (response.statusCode == 200) {
                                  // refresh delete
                                  setState(() {
                                    GetAllTaches();
                                    Navigator.of(context).pop();
                                  });
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
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(197, 255, 0, 0),
                            ),

                            child: Text(
                              "Supprimer",
                              style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontWeight: FontWeight.w400,
                              ),
                            ), //label text,
                          ),
                        ),
                      ),
                    ),
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
        
            const Align(
              alignment: Alignment.center,
              child: Text(
                "Liste des taches",
                style: TextStyle(),
              ),
            ),
            Spacer(),
            RawMaterialButton(
              constraints: BoxConstraints.tight(Size(26, 26)),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (c) => AddTache(id: widget.id)));
              },
              child: const IconTheme(
                data: IconThemeData(
                    color: Color.fromARGB(255, 255, 255, 255), size: 26),
                child: Icon(Icons.add),
              ),
              shape: CircleBorder(),
            )
          ]),
    );
  }
}
