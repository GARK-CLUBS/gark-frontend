import 'package:custom_check_box/custom_check_box.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Presence extends StatefulWidget {
  const Presence({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  State<Presence> createState() => _PresenceState();
}

late Future<bool> fetchedDocs;

var userStatus = <bool>[];
var members = [];
var members1 = [];
var membersinit = [];
String _baseUrl = "10.0.2.2:3000";

class _PresenceState extends State<Presence> {
  Future<List> GetMembers() async {
    try {
      Map<String, String> headers = {
        "Content-Type": "application/json; charset=UTF-8",
      };
      http.Response response = await http.get(
          Uri.parse(
              "http://10.0.2.2:3000/api/equipes/allmembre/62e7296ac9fe267f7c44647d"),
          headers: headers);

      if (response.statusCode == 200) {
        members = [];
        var data = json.decode(response.body);
        userStatus = [];

        for (var u in data[0]["membre"]) {
          userStatus.add(false);
          members.add(u);
        }
        // we have all members and presence list
        // print(userStatus);
        // print(members);
        // print(membersinit[0]);
        for (int j = 0; j < members.length; j++) {
          // print(membersinit[0].length);
          for (int i = 0; i < membersinit[0].length; i++) {
            // print("membersinitid");
            // print(
            //     membersinit[0][i].substring(0, membersinit[0][i].indexOf(':')));
            // print("membersnormal");
            // print(members[j]["_id"]);
            if (members[j]["_id"] ==
                membersinit[0][i]
                    .substring(0, membersinit[0][i].indexOf(':'))) {
              members.removeAt(j);
              // print(members);
            }
            // print(nb);
          }

          // print("memberssss");
          // print(members);
        }
        // print(data[0]["membre"]);
        return members;
      } else {
        return Future.error("server error");
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<bool> fetchDocs() async {
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8",
    };
    http.Response response = await http.get(
        Uri.parse("http://10.0.2.2:3000/api/evenements/" + '${widget.id}'),
        headers: headers);

    if (response.statusCode == 200) {
      setState(() {
        membersinit = [];
        var data = json.decode(response.body);
        membersinit.add(data["presenceList"]);
        // print("mi");
        // print(membersinit[0]);
      });
    }

    return true;
  }

  // everytime you modify you have to restart
  @override
  void initState() {
    fetchedDocs = fetchDocs();

    super.initState();
  }

  final TextEditingController etat = TextEditingController();

  bool shouldCheckDefault = false;
  String? dropdownRole = null;
  var itemsRole = [
    'Joueur',
    'Parent',
    'Coach',
    'Staff',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 244, 244, 244),
        appBar: PreferredSize(
            child: getAppBar(), preferredSize: const Size.fromHeight(50)),
        body: Stack(children: <Widget>[
          SingleChildScrollView(
              child: Column(children: [
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Align(
                  alignment: Alignment(-0.9, 0),
                  child: Text(
                    "Liste des membres",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Spacer(),
                Align(
                  alignment: Alignment(-0.9, 0),
                  child: Text(
                    "Tous",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 52, 202, 67),
                        fontWeight: FontWeight.w500),
                  ),
                ),
                CustomCheckBox(
                  checkedFillColor: const Color.fromARGB(255, 2, 0, 50),
                  borderColor: Colors.grey,
                  checkBoxSize: 16,
                  value: shouldCheckDefault,
                  tooltip: ' Check Box',
                  onChanged: (val) {
                    //do your stuff here
                    setState(() {
                      shouldCheckDefault = val;
                    });
                  },
                ),
              ],
            ),

            SizedBox(
              height: 10,
            ),
            //  gerer les presences
            Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: FutureBuilder<List>(
                    future: GetMembers(),
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
                        return ListView.builder(
                            physics:
                                const NeverScrollableScrollPhysics(), //<--here

                            shrinkWrap: true,
                            //  snapshot.data?.length
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, i) {
                              return Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
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
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Align(
                                              child: Text(
                                                snapshot.data![i]["nom"]
                                                        .toString() +
                                                    " " +
                                                    snapshot.data![i]["prenom"]
                                                        .toString(),
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
                                        // when clicked yelzem bottom bar fiha update
                                        Spacer(),
                                        StatefulBuilder(builder:
                                            (BuildContext context,
                                                StateSetter state) {
                                          return CustomCheckBox(
                                            checkedFillColor:
                                                const Color.fromARGB(
                                                    255, 2, 0, 50),
                                            borderColor: Colors.grey,
                                            checkBoxSize: 20,
                                            value: userStatus[i],
                                            tooltip: ' Check Box',
                                            onChanged: (val) {
                                              state(() => userStatus[i] =
                                                  !userStatus[i]);

                                              //         setState(() {
                                              //   userStatus[i] =
                                              //       !userStatus[i];
                                              // });

                                              // print(userStatus);
                                            },
                                          );
                                        }),
                                      ],
                                    ),
                                  ]));
                            });
                        // to here
                      }
                    }))
          ])),
          Presence(context)
        ]));
  }

  Align Presence(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
          height: 80,
          width: double.infinity,
          color: Color.fromARGB(255, 252, 252, 252),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  // retour padding ps not dynamic
                  Container(
                    padding: EdgeInsets.only(right: 165),
                    child: Align(
                      alignment: Alignment(-0.9, 0),
                      child: Text(
                        "Présence",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    height: 48.0,
                    width: 250.0,
                    child: TextFormField(
                      controller: etat,
                      decoration: const InputDecoration(
                        labelText: "Selectionner un type",
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ),
                      readOnly: true,
                      onTap: () {
                        // bottom sheet
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Wrap(children: [
                              Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceEvenly, // use whichever suits your need
                                        children: [
                                          SizedBox(
                                              width: 155,
                                              height: 40, // <-- Your width
                                              child: Container(
                                                  // padding: EdgeInsets.only(top: 30),
                                                  child: ElevatedButton(
                                                onPressed: () {
                                                  etat.text = "A l'heure";
                                                  Navigator.of(context).pop();
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  primary: Color.fromARGB(
                                                      199, 38, 208, 101),
                                                ),

                                                child: Text(
                                                  "A l'heure",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255),
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ), //label text,
                                              ))),
                                          SizedBox(
                                              width: 155,
                                              height: 40, // <-- Your width
                                              child: Container(
                                                  // padding: EdgeInsets.only(top: 30),
                                                  child: ElevatedButton(
                                                onPressed: () {
                                                  etat.text = "Retard";
                                                  Navigator.of(context).pop();
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  primary: Color.fromARGB(
                                                      255, 255, 162, 0),
                                                ),

                                                child: Text(
                                                  "Retard",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255),
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ), //label text,
                                              ))),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceEvenly, // use whichever suits your need
                                        children: [
                                          SizedBox(
                                              width: 155,
                                              height: 40, // <-- Your width
                                              child: Container(
                                                  // padding: EdgeInsets.only(top: 30),
                                                  child: ElevatedButton(
                                                onPressed: () {
                                                  etat.text = "excusé";
                                                  Navigator.of(context).pop();
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  primary: Color.fromARGB(
                                                      198, 255, 0, 0),
                                                ),

                                                child: Text(
                                                  "Excusé",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255),
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ), //label text,
                                              ))),
                                          SizedBox(
                                              width: 155,
                                              height: 40, // <-- Your width
                                              child: Container(
                                                  // padding: EdgeInsets.only(top: 30),
                                                  child: ElevatedButton(
                                                onPressed: () {
                                                  etat.text = "Non excusé";
                                                  Navigator.of(context).pop();
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  primary: Color.fromARGB(
                                                      198, 255, 0, 0),
                                                ),

                                                child: Text(
                                                  "Non excusé ",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255),
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ), //label text,
                                              ))),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceEvenly, // use whichever suits your need
                                        children: [
                                          SizedBox(
                                              width: 155,
                                              height: 40, // <-- Your width
                                              child: Container(
                                                  // padding: EdgeInsets.only(top: 30),
                                                  child: ElevatedButton(
                                                onPressed: () {
                                                  etat.text = "Blessé";
                                                  Navigator.of(context).pop();
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  primary: Color.fromARGB(
                                                      198, 218, 218, 218),
                                                ),

                                                child: Text(
                                                  "Blessé",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255),
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ), //label text,
                                              ))),
                                          SizedBox(
                                              width: 155,
                                              height: 40, // <-- Your width
                                              child: Container(
                                                  // padding: EdgeInsets.only(top: 30),
                                                  child: ElevatedButton(
                                                onPressed: () {
                                                  etat.text = "Non convoqué";
                                                  Navigator.of(context).pop();
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  primary: Color.fromARGB(
                                                      198, 218, 218, 218),
                                                ),

                                                child: Text(
                                                  "Non convoqué",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255),
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ), //label text,
                                              ))),
                                        ],
                                      )
                                    ],
                                  ))
                            ]);
                          },
                        );
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
              ),
              Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Flexible(
                    child: VerticalDivider(
                      thickness: 1,
                      color: Color.fromARGB(255, 216, 216, 216),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
              SizedBox(
                  width: 115,
                  height: 40,
                  child: Container(
                      child: ElevatedButton(
                    onPressed: () {
                      members1 = [];

                      setState(() {
                        for (int i = 0; i < userStatus.length; i++) {
                          if (userStatus[i] == true) {
                            members1.add(
                                members[i]["_id"].toString() + ":" + etat.text);
                          }
                        }
                      });

                      Map<String, dynamic> userData = {
                        "presenceList": members1
                      };

                      Map<String, String> headers = {
                        "Content-Type": "application/json; charset=UTF-8"
                      };

                      http
                          .put(
                              Uri.http(_baseUrl,
                                  "/api/evenements/" + '${widget.id}'),
                              headers: headers,
                              body: json.encode(userData))
                          .then((http.Response response) async {
                        print(userData);
                        if (response.statusCode == 200) {
                          //    Navigator.of(context).pop();
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
            ],
          )),
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
        Text(
          'Présences',
          textAlign: TextAlign.center,
          style: TextStyle(),
        ),
      ]),
    );
  }
}
