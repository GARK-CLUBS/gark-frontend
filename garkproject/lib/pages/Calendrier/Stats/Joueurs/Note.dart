import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Note extends StatefulWidget {
  const Note({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  State<Note> createState() => _NoteState();
}

int _value = 5;
String _baseUrl = "10.0.2.2:3000";
var userStatus = <int>[];
var memberslist = [];
var members1 = [];
bool init = false;

class _NoteState extends State<Note> {
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

  Future<List> GetAllMembres() async {
    try {
      Map<String, String> headers = {
        "Content-Type": "application/json; charset=UTF-8",
      };
      var response = await http.get(
          Uri.parse(
              "http://10.0.2.2:3000/api/evenements/presence/" + '${widget.id}'),
          headers: headers);
      var response2 = await http.get(
          Uri.parse("http://10.0.2.2:3000/api/evenements/statistique/" +
              '${widget.id}'),
          headers: headers);
      if (response.statusCode == 200 && response2.statusCode == 200) {
        // if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var data2 = jsonDecode(response2.body);
        // print("data2");
        // print(data2[0]["evenement"].length);
        if (data2[0]["evenement"].length > 0) {
          init = true;
        }
        // for (var u in data2[0]["evenement"]) {
        //   print(u["type"]);
        //   if (u["type"] == widget.type) {
        //     init = true;
        //   }
        // }

        // print(init);

        memberslist = [];

        if (init == false) {
          print("init false************************** ");

          memberslist.add(data[0]["evenement"]);
          userStatus = [];
          for (var u in data[0]["evenement"]) {
            userStatus.add(0);
          }

          // print(memberslist[0]);
          // print(userStatus);
        } else {
          print("init true ******************************");
          memberslist = [];

          memberslist.add(data2[0]["evenement"]);
          userStatus = [];
          for (var u in data2[0]["evenement"]) {
            //  print("1111");
            //   print( u);
            userStatus.add(int.parse(u["note"]));
          }
        }

        print(memberslist);
        return memberslist[0];
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
      backgroundColor: Color.fromARGB(255, 245, 245, 245),
      appBar:
          PreferredSize(child: getAppBar(), preferredSize: Size.fromHeight(40)),
      body: getBody(),
    );
  }

  Widget getAppBar() {
    return AppBar(
      elevation: 10,
      centerTitle: true, // this is all you need

      backgroundColor: const Color.fromARGB(255, 2, 0, 50),
      title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Spacer(),
            Text(
              'Note des joueurs',
              textAlign: TextAlign.center,
              style: TextStyle(),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 0),
              child: IconButton(
                  icon: new Icon(Icons.save_as_outlined),
                  onPressed: () {
                    for (int J = 0; J < memberslist[0].length; J++) {
                      // print("we are in the loop ");
                      // print(memberslist[0][J]["_id"]);

                      if (init == true) {
                        Map<String, String> headers = {
                          "Content-Type": "application/json; charset=UTF-8"
                        };

                        Map<String, dynamic> userData = {
                          "note": userStatus[J],
                        };
                        // update
                        http
                            .put(
                                Uri.http(
                                    _baseUrl,
                                    "/api/statistiques/" +
                                        memberslist[0][J]["_id"]),
                                headers: headers,
                                body: json.encode(userData))
                            .then((http.Response response) async {
                          // print(userData);
                          if (response.statusCode == 200) {
                            Navigator.of(context).pop();
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
                        Map<String, dynamic> userevent = {
                          "_id": widget.id,
                        };
                        Map<String, dynamic> usermembre = {
                          "_id": init == true
                              ? memberslist[0][J]["membre"]
                              : memberslist[0][J]
                                  .substring(0, memberslist[0][J].indexOf(':')),
                          //id will change if init ==true
                        };
                        Map<String, dynamic> userData = {
                          "evenement": userevent,
                          // "equipe": "62e7296ac9fe267f7c44647d",
                          "membre": usermembre,

                          //id will change if init ==true
                          "note": userStatus[J],
                        };

                        Map<String, String> headers = {
                          "Content-Type": "application/json; charset=UTF-8"
                        };
                        // insert
                        http
                            .post(Uri.http(_baseUrl, "/api/statistiques/"),
                                headers: headers, body: json.encode(userData))
                            .then((http.Response response) async {
                          // print(userData);
                          if (response.statusCode == 201) {
                              Navigator.of(context).pop();
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
                    }
                  }),
            )
          ]),
    );
  }

  Widget getBody() {
    return SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
        height: 20,
      ),
      Align(
        alignment: Alignment(-0.8, 0),
        child: Text(
          "Joueurs présents",
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: 18,
            color: Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      FutureBuilder<List>(
          future: GetAllMembres(),
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
              // print(
              //     snapshot.data);
              return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(), //<--here

                  shrinkWrap: true,
                  itemCount: snapshot1.data?.length,
                  itemBuilder: (context, i) {
                    return Container(
                        width: double.maxFinite,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(children: [
                              Row(children: [
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FutureBuilder<String>(
                                        future: fetchDocs2(init == false
                                            ? snapshot1.data![i].substring(0,
                                                snapshot1.data![i].indexOf(':'))
                                            : snapshot1.data![i]["membre"]),
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
                                            // print("snap");
                                            // print(snapshot
                                            //     .data);
                                            return Align(
                                              child: Text(
                                                //   fetchDocs2(snapshot.data![i].substring(0,snapshot.data![i].indexOf(':'))) ,
                                                snapshot.data!,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color.fromARGB(
                                                        255, 0, 0, 0),
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            );
                                          }
                                        }),
                                  ],
                                ),
                                Spacer(),
                                StatefulBuilder(builder:
                                    (BuildContext context, StateSetter state) {
                                  return Row(
                                    children: [
                                      Text(
                                        userStatus[i].toString(),
                                        style: TextStyle(
                                            color: userStatus[i] == 5
                                                ? Colors.grey
                                                : userStatus[i] > 5
                                                    ? Colors.green
                                                    : Colors.red,
                                            fontWeight: FontWeight.w700),
                                        textAlign: TextAlign.left,
                                      ),
                                      SfSlider(
                                        activeColor: userStatus[i] == 5
                                            ? Colors.grey
                                            : userStatus[i] > 5
                                                ? Colors.green
                                                : Colors.red,
                                        min: 0.0,
                                        max: 10.0,
                                        value: userStatus[i],
                                        interval: 2,
                                        enableTooltip: true,
                                        minorTicksPerInterval: 1,
                                        onChanged: (dynamic value) {
                                          state(() {
                                            userStatus[i] = value.toInt();
                                            ;
                                          });
                                        },
                                      ),
                                    ],
                                  );
                                }),
                              ])
                            ])));
                  });
            }
          })
    ]));
  }
}
