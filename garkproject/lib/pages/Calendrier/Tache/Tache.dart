import 'package:custom_check_box/custom_check_box.dart';
import 'package:flutter/material.dart';
import 'package:garkproject/pages/Calendrier/CalendrierDetail.dart';
import 'package:garkproject/pages/Calendrier/Tache/SelectTache.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Tache extends StatefulWidget {
  const Tache({Key? key, this.text, required this.id, required this.idtype})
      : super(key: key);
  final String? text;
  final String id;
  final String idtype;

  @override
  State<Tache> createState() => _TacheState();
}

class _TacheState extends State<Tache> {
  String _baseUrl = "10.0.2.2:3000";

  var userStatus = <bool>[];
  var memberslist = [];
  var membersselected = [];
  var membersname = [];
  var membersselectedname = [];
  var memberstopost = [];
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
      // membersname = [];

      // print(data["nom"]);
      return data["nom"];
    } else {
      return " ";
    }
  }

  int _counter = 0;
  TextEditingController nametache = TextEditingController();
  TextEditingController namepersons = TextEditingController();
  bool _isButtonDisabled = true;
  GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

  bool shouldCheckDefault = false;

  @override
  void initState() {
    nametache.text = widget.text!;
    super.initState();
  }

  void _incrementCounter() {
    setState(() {
      _isButtonDisabled = false;
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        appBar: PreferredSize(
            child: getAppBar(), preferredSize: const Size.fromHeight(50)),
        body: Form(
          key: _keyForm,
          child: SingleChildScrollView(
              child: Container(
                  height: 599,
                  padding: EdgeInsets.only(right: 20, left: 20),
                  child: Column(children: [
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment(-1, 0),
                      child: Text(
                        "Choisir le type",
                        style: TextStyle(
                            fontSize: 17,
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    TextFormField(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SelectTache(id: widget.id)),
                        );
                      },
                      readOnly: true,
                      controller: nametache,
                      decoration: const InputDecoration(
                        labelText: "   ex : Apporter les bouteilles d'eau",
                        labelStyle: TextStyle(
                            color: Color.fromARGB(221, 179, 179, 179),
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Veuillez renseigner votre nom d'équipe .";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment(-1, 0),
                      child: Text(
                        "Choisir une ou plusieurs personnes",
                        style: TextStyle(
                            fontSize: 17,
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    TextFormField(
                      onTap: () {
                        //working here
                        if (_keyForm.currentState!.validate()) {
                          showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (context) {
                                return StatefulBuilder(builder:
                                    (BuildContext context, StateSetter state) {
                                  return FractionallySizedBox(
                                      heightFactor: 0.91,
                                      child: Wrap(children: [
                                        Container(
                                          decoration: const BoxDecoration(
                                            color:
                                                Color.fromARGB(255, 2, 0, 50),
                                          ),
                                          child: Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 10),
                                              child: Row(
                                                children: [
                                                  IconButton(
                                                    icon: Icon(Icons.arrow_back,
                                                        color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255)),
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                  ),
                                                  Align(
                                                    alignment: Alignment(-1, 0),
                                                    child: Text(
                                                      "Choisir une ou plusieurs personnes ",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 15),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        state(() => {
                                                              memberstopost.addAll(
                                                                  membersselected),
                                                              namepersons.text =
                                                                  "",
                                                              for (int i = 0;
                                                                  i <
                                                                      membersselectedname
                                                                          .length;
                                                                  i++)
                                                                {
                                                                  namepersons
                                                                      .text = namepersons
                                                                          .text +
                                                                      membersselectedname[
                                                                          i] +
                                                                      " , ",
                                                                },
                                                            });

                                                        _isButtonDisabled =
                                                            false;
                                                        Navigator.pop(context);
                                                      },
                                                      child: new Text(
                                                        "Valider",
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          color: Color.fromARGB(
                                                              197,
                                                              215,
                                                              215,
                                                              215),
                                                          fontWeight:
                                                              FontWeight.w700,
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
                                                physics:
                                                    const AlwaysScrollableScrollPhysics(), // new
                                                shrinkWrap: true,
                                                itemCount: 1,
                                                itemBuilder: (_, index) {
                                                  return Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Column(
                                                          children: <Widget>[
                                                            Container(
                                                                child: Stack(
                                                                    children: <
                                                                        Widget>[
                                                                  Container(
                                                                    height:
                                                                        80, // change it to 140 idha nheb nrejaaha kima kenet
                                                                    decoration:
                                                                        const BoxDecoration(
                                                                      color: Color
                                                                          .fromARGB(
                                                                              255,
                                                                              2,
                                                                              0,
                                                                              50),
                                                                    ),
                                                                  ),
                                                                  Positioned(
                                                                    bottom: 20,
                                                                    left: 0,
                                                                    right: 0,
                                                                    child:
                                                                        Container(
                                                                      margin: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              10),
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              10),
                                                                      height:
                                                                          44,
                                                                      child:
                                                                          Container(
                                                                        width: double
                                                                            .infinity,
                                                                        height:
                                                                            38,
                                                                        decoration: BoxDecoration(
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                255,
                                                                                255,
                                                                                255),
                                                                            borderRadius: BorderRadius.circular(15),
                                                                            boxShadow: [
                                                                              BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 15, spreadRadius: 5)
                                                                            ]),
                                                                        child:
                                                                            Row(
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
                                                                                decoration: InputDecoration(border: InputBorder.none, hintText: "Search for contacts"),
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
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 20,
                                                                  left: 15),
                                                          color: Color.fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255),
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Align(
                                                                    alignment:
                                                                        Alignment(
                                                                            -0.5,
                                                                            0),
                                                                    child:
                                                                        IconTheme(
                                                                      data: IconThemeData(
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                          size:
                                                                              22),
                                                                      child: Icon(
                                                                          Icons
                                                                              .arrow_drop_down),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment(
                                                                            -0.8,
                                                                            0),
                                                                    child: Text(
                                                                      "Présent",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              16,
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
                                                                      child:
                                                                          Divider(
                                                                    height: 20,
                                                                    thickness:
                                                                        1,
                                                                  )),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        // from here
                                                        FutureBuilder<List>(
                                                            future:
                                                                GetAllMembres(),
                                                            builder: (context,
                                                                snapshot) {
                                                              if (snapshot
                                                                  .hasError) {
                                                                // print(snapshot);
                                                              }
                                                              if (!snapshot
                                                                  .hasData) {
                                                                // still waiting for data to come
                                                                return CircularProgressIndicator();
                                                              } else if (snapshot
                                                                      .data ==
                                                                  null) {
                                                                // got data from snapshot but it is empty

                                                                return SizedBox();
                                                              } else {
                                                                // print(
                                                                //     snapshot.data);
                                                                return ListView
                                                                    .builder(
                                                                        physics:
                                                                            const NeverScrollableScrollPhysics(), //<--here

                                                                        shrinkWrap:
                                                                            true,
                                                                        itemCount: snapshot
                                                                            .data
                                                                            ?.length,
                                                                        itemBuilder:
                                                                            (context,
                                                                                i) {
                                                                          return Container(
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
                                                                                        CircleAvatar(
                                                                                          radius: 30.0,
                                                                                          backgroundImage: NetworkImage("https://www.simplilearn.com/ice9/free_resources_article_thumb/what_is_image_Processing.jpg"),
                                                                                          backgroundColor: Colors.transparent,
                                                                                        ),
                                                                                        SizedBox(
                                                                                          width: 15,
                                                                                        ),

                                                                                        FutureBuilder<String>(
                                                                                            future: fetchDocs2(snapshot.data![i].substring(0, snapshot.data![i].indexOf(':'))),
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
                                                                                                membersname.add(snapshot.data);
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
                                                                                        // if (userStatus[i] == false) {userStatus[i] = true, membersselected.add(snapshot.data!)} else {userStatus[i] = false, membersselected.remove(i)} ,print(membersselected)
                                                                                        // when clicked yelzem bottom bar fiha update
                                                                                        Spacer(),
                                                                                        StatefulBuilder(builder: (BuildContext context, StateSetter state) {
                                                                                          return CustomCheckBox(
                                                                                            checkedFillColor: const Color.fromARGB(255, 2, 0, 50),
                                                                                            borderColor: Colors.grey,
                                                                                            checkBoxSize: 20,
                                                                                            value: userStatus[i],
                                                                                            tooltip: ' Check Box',
                                                                                            onChanged: (val) {
                                                                                              state(() => {
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
                      },
                      readOnly: true,
                      controller: namepersons,
                      decoration: const InputDecoration(
                        labelText: "   ex : Slim Slim",
                        labelStyle: TextStyle(
                            color: Color.fromARGB(221, 179, 179, 179),
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
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: 250,
                        height: 45, // <-- Your width
                        child: ElevatedButton(
                          onPressed: () {
                            // event
                            Map<String, dynamic> userData1 = {
                              "_id": widget.id,
                            };
                            //tache
                            Map<String, dynamic> userData2 = {
                              "_id": widget.idtype,
                            };
                            // print("object");
                            // print(memberstopost);
                            for (int i = 0; i < memberstopost.length; i++) {
                              Map<String, dynamic> userData = {
                                "type": userData2,
                                "evenement": userData1,
                                "membres1": memberstopost[i],
                              };

                              Map<String, String> headers = {
                                "Content-Type":
                                    "application/json; charset=UTF-8"
                              };

                              http
                                  .post(Uri.http(_baseUrl, "/api/taches/"),
                                      headers: headers,
                                      body: json.encode(userData))
                                  .then((http.Response response) async {
                                // print(userData);
                                if (response.statusCode == 201) {
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CalendrierDetail(id: widget.id)),
                            ).then((value) => setState(() {}));
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 14, 178,
                                  120) //elevated btton background color
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
                  ]))),
        ));
  }

  Widget getAppBar() {
    return AppBar(
      elevation: 10,
      backgroundColor: const Color.fromARGB(255, 2, 0, 50),
      leading: IconButton(
          icon:
              Icon(Icons.arrow_back, color: Color.fromARGB(255, 255, 255, 255)),
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (c) => CalendrierDetail(id: widget.id)))),
      title: Row(children: <Widget>[
        new Align(
          alignment: Alignment.topLeft,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Text(''),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            "Assigner une tache",
            style: TextStyle(),
          ),
        ),
        new Align(
          alignment: Alignment.topRight,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              '',
              textAlign: TextAlign.start,
            ),
          ),
        ),
      ]),
    );
  }
}
