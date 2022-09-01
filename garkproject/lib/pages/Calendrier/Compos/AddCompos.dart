import 'package:custom_check_box/custom_check_box.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:garkproject/data/TacheData.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddCompos extends StatefulWidget {
  const AddCompos({Key? key, required this.number, required this.id})
      : super(key: key);
  final String number;
  final String id;
  @override
  State<AddCompos> createState() => _AddComposState();
}

Offset offset = Offset(0.0, 0.0);

List LineupList = [
  {
    "nom": "Gardien",
    "idjoueur": "1",
    "top": 435.004,
    "left": 167.004,
    "image": "assets/2.jpg",
    "a": "",
  },
  {
    "nom": "cb1",
    "idjoueur": "1",
    "top": 321.004,
    "left": 119.004,
    "image": "assets/1.png",
    "a": "",
  },
  {
    "nom": "cb2",
    "idjoueur": "1",
    "top": 319.004,
    "left": 225.004,
    "image": "assets/3.png",
    "a": "",
  },
  {
    "nom": "mc2",
    "idjoueur": "1",
    "top": 140.004,
    "left": 164.004,
    "image": "assets/2.jpg",
    "a": "",
  },
  {
    "nom": "at1",
    "idjoueur": "1",
    "top": 18.004,
    "left": 167.004,
    "image": "assets/5.jpg",
    "a": "",
  },
  {
    "nom": "mc3",
    "idjoueur": "1",
    "top": 216.004,
    "left": 88.004,
    "image": "assets/4.jpg",
    "a": "",
  },
  {
    "nom": "at2",
    "idjoueur": "1",
    "top": 26.004,
    "left": 64.004,
    "image": "assets/3.png",
    "a": "",
  },
  {
    "nom": "mc1",
    "idjoueur": "1",
    "top": 213.004,
    "left": 237.004,
    "image": "assets/4.jpg",
    "a": "",
  },
  {
    "nom": "cb3",
    "idjoueur": "1",
    "top": 303.004,
    "left": 20.004,
    "image": "assets/1.png",
    "a": "",
  },
  {
    "nom": "cb4",
    "idjoueur": "1",
    "top": 301.004,
    "left": 328.004,
    "image": "assets/3.png",
    "a": "",
  },
  {
    "nom": "at3",
    "idjoueur": "1",
    "top": 27.004,
    "left": 270.004,
    "image": "assets/5.jpg",
    "a": "",
  },
];

List Remplacant1 = [
  {
    "nom": "Gardien",
    "top": 330.00,
    "left": 170.00,
    "offset": offset,
    "image": "assets/5.jpg",
  },
  {
    "nom": "Gardien",
    "top": 330.00,
    "left": 170.00,
    "offset": offset,
    "image": "assets/4.jpg",
  },
  {
    "nom": "Gardien",
    "top": 330.00,
    "left": 170.00,
    "offset": offset,
    "image": " ",
  },
];

class _AddComposState extends State<AddCompos> {
  var memberslist = [];
  var userStatus = [];
  Future<List> GetAllMembres() async {
    try {
      Map<String, String> headers = {
        "Content-Type": "application/json; charset=UTF-8",
      };
      var response = await http.get(
          Uri.parse(
              "http://10.0.2.2:3000/api/evenements/presence/" + '${widget.id}'),
          headers: headers);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        memberslist = [];
        //  print(data[0]["evenement"]);
        memberslist.add(data[0]["evenement"]);
        // print(memberslist);
        userStatus = [];
        for (var u in data[0]["evenement"]) {
          userStatus.add(false);
        }

        // print(memberslist[0]);
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

      // print(data["nom"]);
      return data["nom"];
    } else {
      return " ";
    }
  }

  var data = [];

  Future<List> GetAllCompos() async {
    try {
      var response = await http.get(
          Uri.parse("http://10.0.2.2:3000/api/evenements/compos/" + widget.id));
      if (response.statusCode == 200) {
        data = [];

        data = jsonDecode(response.body);
        if (data[0]["evenement"].length > 1) {
          // print(data[0]["evenement"].length);
          //    LineupList = [];
          // print("in condition ");
          // print(LineupList);
          int i = 0;
          for (var u in data[0]["evenement"]) {
            setState(() {
              LineupList[i]["idjoueur"] = u["nom"];
              LineupList[i]["top"] = u["top"];
              LineupList[i]["left"] = u["left"];
              LineupList[i]["image"] = u["image"];
              LineupList[i]["a"] = u["_id"];
            });
            i++;
          }
          // print(LineupList);

          // print(data[0]["evenement"]);
          existe = true;
          return LineupList;
        } else {
          return LineupList;
        }
      } else {
        return Future.error("server error");
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List> GetAllRemplacants() async {
    try {
      var response = await http.get(Uri.parse(
          "http://10.0.2.2:3000/api/evenements/remplacant/" + widget.id));
      if (response.statusCode == 200) {
        data = [];

        data = jsonDecode(response.body);
        return data[0]["evenement"];
      } else {
        return Future.error("server error");
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  void initState() {
    GetAllCompos();
    super.initState();
  }

  bool shouldCheckDefault = false;
  bool existe = false;
  int toggle = 0;
  Size? screen;
  Size containerSize = const Size(50, 50);
  String? dropdownSport;
  bool isremplacant = false;
  var text = "";
  var itemsSport = [
    '4-4-2',
    '4-4-1',
    '4-4-3',
    '4-4-4',
  ];
  int? selected;
  int? selected2;
  int? index = 0;
  String _baseUrl = "10.0.2.2:3000";

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
            Spacer(),
            Text(
              'Gérer les compos',
              textAlign: TextAlign.center,
              style: TextStyle(),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 0),
              child: IconButton(
                  icon: new Icon(Icons.save_as_outlined),
                  onPressed: () {
                    bool ex = false;

                    // print("LineupList insave btn");
                    // print(LineupList);
                    for (int i = 0; i < LineupList.length; i++) {
                      if (LineupList[i]["idjoueur"].length < 2) {
                        ex = true;
                      }
                    }
                    // print(LineupList);
                    if (ex == false) {
                      for (int i = 0; i < LineupList.length; i++) {
                        if (existe == true) {
                          Map<String, dynamic> eventData = {
                            "_id": widget.id,
                          };
                          Map<String, dynamic> userData = {
                            "nom": LineupList[i]["idjoueur"],
                            "top": LineupList[i]["top"],
                            "left": LineupList[i]["left"],
                            "evenement": eventData,
                            "image": LineupList[i]["image"],
                          };
                          Map<String, String> headers = {
                            "Content-Type": "application/json; charset=UTF-8"
                          };
                          // update
                          http
                              .put(
                                  Uri.http(_baseUrl,
                                      "/api/compos/" + LineupList[i]["a"]),
                                  headers: headers,
                                  body: json.encode(userData))
                              .then((http.Response response) async {
                            // print(userData);
                            if (response.statusCode == 200) {
                              //   Navigator.of(context).pop();
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
                        } else {
                          Map<String, dynamic> eventData = {
                            "_id": widget.id,
                          };
                          Map<String, dynamic> userData = {
                            "nom": LineupList[i]["idjoueur"],
                            "top": LineupList[i]["top"],
                            "left": LineupList[i]["left"],
                            "evenement": eventData,
                            "image": LineupList[i]["image"],
                          };
                          Map<String, String> headers = {
                            "Content-Type": "application/json; charset=UTF-8"
                          };
                          http
                              .post(Uri.http(_baseUrl, "/api/compos/"),
                                  headers: headers, body: json.encode(userData))
                              .then((http.Response response) async {
                            // print(userData);
                            if (response.statusCode == 201) {
                              // setState(() {
                              //   existe = true;
                              // });
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          super.widget));
                              // Navigator.of(context).pop();
                            } else if (response.statusCode == 401) {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const AlertDialog(
                                      title: Text("Information"),
                                      content: Text(
                                          "Usernom et/ou mot de passe incorrect"),
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
                      }
                    } else {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const AlertDialog(
                              title: Text("Information"),
                              content: Text("fill players"),
                            );
                          });
                    }
                  }),
            )
          ]),
    );
  }

  Widget getBody() {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment
            //       .spaceEvenly, // use whichever suits your need
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: ToggleSwitch(
            //         minHeight: 30,
            //         minWidth: 80.0,
            //         cornerRadius: 20.0,
            //         activeBgColors: [
            //           [Color.fromARGB(255, 0, 123, 255)],
            //           [Colors.red[800]!]
            //         ],
            //         activeFgColor: Colors.white,
            //         inactiveBgColor: Color.fromARGB(255, 255, 255, 255),
            //         inactiveFgColor: Color.fromARGB(255, 0, 226, 38),
            //         borderColor: [
            //           Color.fromARGB(255, 0, 226, 38),
            //         ],
            //         borderWidth: 1,
            //         initialLabelIndex: toggle,
            //         totalSwitches: 2,
            //         labels: ['Bleu', 'Rouge'],
            //         radiusStyle: true,
            //         onToggle: (index) {
            //           setState(() {
            //             toggle = index!;
            //           });
            //         },
            //       ),
            //     ),
            //   ],
            // ),
            SizedBox(
              height: 65,
            ),
            Team1(),
            // if (toggle == 1) ...[
            //   Team1(),
            // ] else ...[
            //   Team1(),
            // ],
          ],
        ));
  }

  LayoutBuilder Team1() {
    String nombre =
        '${widget.number}'.substring(0, '${widget.number}'.indexOf(" "));
    LineupList.removeRange(int.parse(nombre), LineupList.length);
    // print("lilll");
    // print(LineupList);

//     print("LineupList team1");
//     print(LineupList);
//  print("existe");
//  print(existe);

    return LayoutBuilder(builder: (context, constraints) {
      final boxSize = Size(525, 525);
      screen ??= Size(boxSize.width, boxSize.height);
      return SingleChildScrollView(
        child: Column(
          children: [
              Stack(
                //      alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: boxSize.width,
                    height: boxSize.height,
                    child: Image.asset(
                      "assets/field.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                
                  for (int i = 0; i < LineupList.length; i++) ...[
                    Positioned(
                      left: LineupList[i]["left"],
                      top: LineupList[i]["top"],
                      child: Column(
                        children: [
                          GestureDetector(
                              onTap: () {
                                ShowPlayer(
                                  false,
                                  i,
                                );
                                selected = i;
                              },
                              onPanDown: (d) {
                                // print(LineupList);
                                // LineupList[i]["leftprev"] = LineupList[i]["left"];
                                // LineupList[i]["topprev"] = LineupList[i]["top"];
                              },
                              onPanUpdate: (details) {
                                setState(() {
                                  LineupList[i]["left"] =
                                      LineupList[i]["left"] + details.delta.dx;

                                  LineupList[i]["top"] =
                                      LineupList[i]["top"] + details.delta.dy;
                                  // print(LineupList[i]);
                                });
                              },
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: DottedDecoration(
                                    shape: Shape.box,
                                    color: Colors.white,
                                    strokeWidth: 3),
                                child: Column(children: [
                                  SizedBox(
                                    height: 50,
                                    child: Image.asset(
                                      LineupList[i]["image"],
                                      height: 50,
                                      width: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ]),
                              )),
                          if (LineupList[i]["idjoueur"].length > 3) ...[
                            FutureBuilder<String>(
                                future: fetchDocs2(LineupList[i]["idjoueur"]),
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
                                    return Align(
                                      child: Text(snapshot.data!,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                    );
                                  }
                                }),
                          ] else ...[
                            Align(
                              child: Text("snapshot.data!",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            )
                          ]
                        ],
                      ),
                    ),
                  ],
                ],
                // ]
              ),
            Text(
              "REMPLAÇANTS",
              style: TextStyle(color: Color.fromARGB(255, 112, 112, 112)),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              height: 50,
              child: FutureBuilder<List>(
                  future: GetAllRemplacants(),
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
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot1.data!.length + 1,
                          itemBuilder: (BuildContext ctxt, int index) {
                            if (index == snapshot1.data!.length) {
                              return addremp();
                            }

                            return InkWell(
                                onTap: () {
                                  // print("edit tache");
                                },
                                child: Row(
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          width: 50.0,
                                          decoration: DottedDecoration(
                                              shape: Shape.box,
                                              color: Color.fromARGB(
                                                  255, 152, 152, 152),
                                              strokeWidth: 3),
                                          child: RawMaterialButton(
                                            constraints: BoxConstraints.tight(
                                                Size(26, 26)),
                                            onPressed: () {
                                              setState(() {
                                                ShowPlayer(true, 1);
                                              });
                                            },
                                            child: Image.asset(
                                              Remplacant1[index]["image"],
                                              height: 30,
                                              width: 30,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        // FutureBuilder<String>(
                                        //     future: fetchDocs2(
                                        //         snapshot1.data![index]["nom"]),
                                        //     builder: (context, snapshot) {
                                        //       if (snapshot.hasError) {
                                        //         // print(snapshot);
                                        //       }
                                        //       if (!snapshot.hasData) {
                                        //         // still waiting for data to come
                                        //         return CircularProgressIndicator();
                                        //       } else if (snapshot.data ==
                                        //           null) {
                                        //         // got data from snapshot but it is empty

                                        //         return Text("context");
                                        //       } else {
                                        //         return Align(
                                        //           child: Text(snapshot.data!,
                                        //               textAlign: TextAlign.left,
                                        //               style: TextStyle(
                                        //                   color: Colors.white,
                                        //                   fontSize: 16,
                                        //                   fontWeight:
                                        //                       FontWeight.bold)),
                                        //         );
                                        //       }
                                        //     }),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ));
                          });
                    }
                  }),
            ),
          ],
        ),
      );
    });
  }

  InkWell addremp() {
    return InkWell(
        onTap: () {
          print("edit tache");
        },
        child: Row(
          children: [
            Container(
              width: 50.0,
              decoration: DottedDecoration(
                  shape: Shape.box,
                  color: Color.fromARGB(255, 152, 152, 152),
                  strokeWidth: 3),
              child: RawMaterialButton(
                  constraints: BoxConstraints.tight(Size(26, 26)),
                  onPressed: () {
                    setState(() {
                      ShowPlayer(true, 1);
                    });
                  },
                  child: const IconTheme(
                    data: IconThemeData(
                        color: Color.fromARGB(255, 152, 152, 152), size: 16),
                    child: Icon(Icons.add),
                  )),
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ));
  }

  Future<dynamic> ShowPlayer(
    bool remplacant,
    int id,
  ) {
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
                              onPressed: () => {
                                setState(() {
                                  text = "x";
                                }),
                                Navigator.pop(context)
                              },
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
                                  //   state(() =>  );
                                  if (remplacant == true) {
                                    for (int i = 0;
                                        i < userStatus.length;
                                        i++) {
                                      if (userStatus[i] == true) {
                                        // print(memberslist[0][i]);
                                        //         print( memberslist[0][i].substring(
                                        //         0, memberslist[0][i].indexOf(':')));

                                        Map<String, dynamic> eventData = {
                                          "_id": widget.id,
                                        };
                                        Map<String, dynamic> userData = {
                                          "nom": memberslist[0][i].substring(0,
                                              memberslist[0][i].indexOf(':')),
                                          "image": LineupList[i]["image"],
                                          "evenement": eventData,
                                        };
                                        Map<String, String> headers = {
                                          "Content-Type":
                                              "application/json; charset=UTF-8"
                                        };
                                        http
                                            .post(
                                                Uri.http(_baseUrl,
                                                    "/api/remplacants/"),
                                                headers: headers,
                                                body: json.encode(userData))
                                            .then(
                                                (http.Response response) async {
                                          // print(userData);
                                          if (response.statusCode == 201) {
                                            // setState(() {
                                            //   existe = true;
                                            // });
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        super.widget));
                                            // Navigator.of(context).pop();
                                          } else if (response.statusCode ==
                                              401) {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return const AlertDialog(
                                                    title: Text("Information"),
                                                    content: Text(
                                                        "Usernom et/ou mot de passe incorrect"),
                                                  );
                                                });
                                          } else {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return const AlertDialog(
                                                    title: Text("Information"),
                                                    content: Text(
                                                        "Une erreur s'est produite. Veuillez réessayer !"),
                                                  );
                                                });
                                          }
                                        });
                                      }
                                    }
                                  } else {
                                    setState(() {
                                      for (int i = 0;
                                          i < userStatus.length;
                                          i++) {
                                        if (userStatus[i] == true) {
                                          LineupList[id]["image"] =
                                              "assets/5.jpg";
                                          LineupList[id]["idjoueur"] =
                                              memberslist[0][i].substring(
                                                  0,
                                                  memberslist[0][i]
                                                      .indexOf(':'));
                                          // print(memberslist[0][i]);
                                          //         print( memberslist[0][i].substring(
                                          //         0, memberslist[0][i].indexOf(':')));
                                        }
                                      }

                                      // LineupList[id]["image"] = "assets/5.jpg";
                                      // LineupList[id]["idjoueur"] = "aaa";
                                    });
                                  }
                                  // print(LineupList);
                                  Navigator.pop(context);
                                },
                                child: new Text(
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
                                                "Présent (2) ",
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
                                  Container(
                                      width: double.maxFinite,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child: FutureBuilder<List>(
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
                                              // print(snapshot.data);
                                              return ListView.builder(
                                                  physics:
                                                      const NeverScrollableScrollPhysics(), //<--here

                                                  shrinkWrap: true,
                                                  itemCount:
                                                      snapshot.data?.length,
                                                  itemBuilder: (context, i) {
                                                    return Container(
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
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      FutureBuilder<
                                                                              String>(
                                                                          future: fetchDocs2(snapshot.data![i].substring(
                                                                              0,
                                                                              snapshot.data![i].indexOf(
                                                                                  ':'))),
                                                                          builder:
                                                                              (context, snapshot) {
                                                                            if (snapshot.hasError) {
                                                                              // print(snapshot);
                                                                            }
                                                                            if (!snapshot.hasData) {
                                                                              // still waiting for data to come
                                                                              return CircularProgressIndicator();
                                                                            } else if (snapshot.data ==
                                                                                null) {
                                                                              // got data from snapshot but it is empty

                                                                              return Text("context");
                                                                            } else {
                                                                              // print("snap");
                                                                              // print(snapshot
                                                                              //     .data);
                                                                              return Align(
                                                                                child: Text(
                                                                                  //   fetchDocs2(snapshot.data![i].substring(0,snapshot.data![i].indexOf(':'))) ,
                                                                                  snapshot.data!,
                                                                                  textAlign: TextAlign.left,
                                                                                  style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.w400),
                                                                                ),
                                                                              );
                                                                            }
                                                                          }),
                                                                    ],
                                                                  ),
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
                                                                            userStatus[i] =
                                                                                !userStatus[i]);
                                                                        print(
                                                                            userStatus);
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
                                ]);
                          }))
                ]));
          });
        });
  }
}
