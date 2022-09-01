import 'package:dynamic_icons/dynamic_icons.dart';
import 'package:flutter/material.dart';
import 'package:garkproject/data/TacheAssigneddata.dart';
import 'package:garkproject/pages/Calendrier/Tache/Tache.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../../data/TacheAssigneddata.dart';

class DisplayTaches extends StatefulWidget {
  const DisplayTaches({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  State<DisplayTaches> createState() => _DisplayTachesState();
}

class _DisplayTachesState extends State<DisplayTaches> {
  var _selected = "";
  bool status1 = false;
  var listmembre = [];
  var listtype = [];
  Future<List> GetAllTaches() async {
    try {
      var response = await http.get(Uri.parse(
          "http://10.0.2.2:3000/api/evenements/tache/" + '${widget.id}'));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        // print("data");
        // print(data);
        // print(data[0]["evenement"]);
        listtype = [];
        listmembre = [];
        return data[0]["evenement"];
      } else {
        return Future.error("server error");
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<int> GetTypes(String id) async {
    try {
      var response =
          await http.get(Uri.parse("http://10.0.2.2:3000/api/types/" + id));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        // print("data");
        // print(data);
        listtype.add(data);
        return data["nomIcon"];
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
    http.Response response = await http.get(
        Uri.parse("http://10.0.2.2:3000/api/membres/" + id),
        headers: headers);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      // print(data["nom"]);
      listmembre.add(data["nom"] + " " + data["prenom"]);
      return data["nom"] + " " + data["prenom"];
    } else {
      return " ";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 244, 244, 244),
      appBar:
          PreferredSize(child: getAppBar(), preferredSize: Size.fromHeight(50)),
      body: getBody(),
    );
  }

  Widget getBody() {
    return SingleChildScrollView(
        child: Column(children: [
      FutureBuilder<List>(
          future: GetAllTaches(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              // print(snapshot);
            }
            if (!snapshot.hasData) {
              // still waiting for data to come
              return CircularProgressIndicator();
            } else if (snapshot.data == null) {
              // got data from snapshot but it is empty

              return Text("");
            } else {
              listtype = [];
              listmembre = [];
              return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(), //<--here

                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, i) {
                    return Column(children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      // Row(
                      //   children: [
                      //     SizedBox(
                      //       width: 15,
                      //     ),
                      //     Align(
                      //       alignment: Alignment(-0.5, 0),
                      //       child: Text(
                      //         "Arbitre ",
                      //         textAlign: TextAlign.right,
                      //         style: TextStyle(
                      //           fontSize: 18,
                      //           color: Color.fromARGB(255, 0, 0, 0),
                      //           fontWeight: FontWeight.w500,
                      //         ),
                      //       ),
                      //     ),
                      //     Spacer(),
                      //     IconButton(
                      //       icon: Icon(Icons.outlined_flag,
                      //           color: Color.fromARGB(255, 180, 180, 180)),
                      //       onPressed: () => Navigator.of(context).pop(),
                      //     ),
                      //   ],
                      // ),
                      Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: Column(children: [
                                Row(
                                  children: [
                                    Stack(
                                      children: [
                                        CircleAvatar(
                                          radius: 30.0,
                                          backgroundImage: NetworkImage(
                                              "https://www.simplilearn.com/ice9/free_resources_article_thumb/what_is_image_Processing.jpg"),
                                          backgroundColor: Colors.transparent,
                                        ),
                                        Container(
                                          child: FutureBuilder<int>(
                                              future: GetTypes(
                                                  snapshot.data![i]["type"]),
                                              builder: (context, snapshot1) {
                                                if (snapshot1.hasError) {
                                                  // print(snapshot);
                                                }
                                                if (!snapshot1.hasData) {
                                                  // still waiting for data to come
                                                  return CircularProgressIndicator();
                                                } else if (snapshot1.data ==
                                                    null) {
                                                  // got data from snapshot but it is empty

                                                  return SizedBox();
                                                } else {
                                                  return Positioned(
                                                      bottom: -10,
                                                      right: -35,
                                                      child: RawMaterialButton(
                                                        onPressed: () {},
                                                        // elevation: 2.0,
                                                        fillColor:
                                                            Color.fromARGB(255,
                                                                255, 255, 255),
                                                        child: Icon(IconData(
                                                            snapshot1.data!,
                                                            fontFamily:
                                                                'MaterialIcons')),
                                                        padding:
                                                            EdgeInsets.all(1.0),
                                                        shape: CircleBorder(),
                                                      ));
                                                }
                                              }),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    FutureBuilder<String>(
                                        future: fetchDocs2(
                                            snapshot.data![i]["membres1"][0]),
                                        builder: (context, snapshot1) {
                                          if (snapshot1.hasError) {
                                            // print(snapshot);
                                          }
                                          if (!snapshot1.hasData) {
                                            // still waiting for data to come
                                            return CircularProgressIndicator();
                                          } else if (snapshot1.data == null) {
                                            // got data from snapshot but it is empty

                                            return SizedBox();
                                          } else {
                                            return Text(
                                              snapshot1.data!,
                                              style: TextStyle(fontSize: 14),
                                            );
                                          }
                                        }),
                                    // Align(
                                    //   child: Text(
                                    //     "Slim ayadi",
                                    //     textAlign: TextAlign.left,
                                    //     style: TextStyle(
                                    //         fontSize: 16,
                                    //         color: Color.fromARGB(255, 0, 0, 0),
                                    //         fontWeight: FontWeight.w400),
                                    //   ),
                                    // ),
                                    //  _displayDialogDelete(context);
                                    // when clicked yelzem bottom bar fiha update
                                    Spacer(),
                                    Container(
                                        alignment: Alignment(0, 1),
                                        child: SizedBox.fromSize(
                                          child: ClipOval(
                                            child: Material(
                                              color: Color.fromARGB(
                                                      255, 142, 142, 142)
                                                  .withOpacity(0.0),
                                              child: InkWell(
                                                splashColor: Color.fromARGB(
                                                    255, 248, 248, 248),
                                                onTap: () {
                                                  // snapshot.data![i]["membres1"][0]
                                                  // snapshot.data![i]["_id"]
                                                  print("listtype");
                                                  print(listtype);
                                                  // _displayDialogDelete(
                                                  //     context,
                                                  //     listmembre[i],
                                                  //     listtype[i]["nomIcon"],
                                                  //     snapshot.data![i]["_id"],
                                                  //     listtype[i]["typechoix"]);
                                                  
                                                  // optimisation code 
                                                },
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    IconTheme(
                                                      data: IconThemeData(
                                                          color: Color.fromARGB(
                                                              255, 0, 0, 0),
                                                          size: 28),
                                                      child:
                                                          Icon(Icons.more_vert),
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
                              ]))),
                    ]);
                  });
            }
          })
    ]));
  }

  _displayDialogDelete(BuildContext context, String name, int icon, String id,
      String tache) async {
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
                      tache,
                      style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  children: [
                    Stack(
                      children: [
                        Align(
                          alignment: Alignment(0, 0),
                          child: CircleAvatar(
                            radius: 40.0,
                            backgroundImage: NetworkImage(
                                "https://www.simplilearn.com/ice9/free_resources_article_thumb/what_is_image_Processing.jpg"),
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                        Positioned(
                            bottom: -05,
                            right: 70,
                            child: RawMaterialButton(
                              onPressed: () {},
                              fillColor: Color.fromARGB(255, 255, 255, 255),
                              child: Icon(
                                  IconData(icon, fontFamily: 'MaterialIcons')),
                              shape: CircleBorder(),
                            )),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Align(
                        alignment: Alignment(0, 0),
                        child: Text(
                          name,
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 4, 4, 4),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
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
                                Uri.http("10.0.2.2:3000", "/api/taches/" + id),
                                headers: headers,
                              )
                                  .then((http.Response response) async {
                                if (response.statusCode == 200) {
                                  // refresh delete
                                  setState(() {
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
                              "Désassigner",
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
        elevation: 10,
        backgroundColor: const Color.fromARGB(255, 2, 0, 50),
        leading: IconButton(
          icon:
              Icon(Icons.arrow_back, color: Color.fromARGB(255, 255, 255, 255)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(children: <Widget>[
          Spacer(),
          Text(
            'Taches assignés',
            textAlign: TextAlign.center,
            style: TextStyle(),
          ),
          Spacer(),
          IconButton(
            icon: Icon(Icons.add, color: Color.fromARGB(255, 255, 255, 255)),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Tache(
                        text: "",
                        id: widget.id,
                        idtype: "",
                      )),
            ).then((value) => setState(() {})),
          ),
        ]));
  }
}
