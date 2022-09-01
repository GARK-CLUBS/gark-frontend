import 'package:custom_check_box/custom_check_box.dart';
import 'package:flutter/material.dart';
import 'package:garkproject/main.dart';
import 'package:garkproject/pages/Calendrier/Calendrier.dart';
import 'package:garkproject/pages/Calendrier/CalendrierDetail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class HommeMatch extends StatefulWidget {
  const HommeMatch({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  State<HommeMatch> createState() => _HommeMatchState();
}

var userStatus = <bool>[];
var memberslist = [];
bool nomember = true;
var members1 = [];
String _baseUrl = "10.0.2.2:3000";

class _HommeMatchState extends State<HommeMatch> {
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
      print("his");
      print(id);
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

// everytime you modify you have to restart
  @override
  void initState() {
    GetAllMembres();

    super.initState();
  }

  bool shouldCheckDefault1 = false;

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
    return Container(
        width: double.maxFinite,
        child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(), // new
            shrinkWrap: true,
            itemCount: 1,
            itemBuilder: (_, index) {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // from here
                    Container(
                        width: double.maxFinite,
                        padding: EdgeInsets.symmetric(horizontal: 10),
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
                                print(snapshot.data);
                                return ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(), //<--here

                                    shrinkWrap: true,
                                    itemCount: snapshot.data?.length,
                                    itemBuilder: (context, i) {
                                      return Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Column(children: [
                                            Row(
                                              children: [
                                                CircleAvatar(
                                                  radius: 30.0,
                                                  backgroundImage: NetworkImage(
                                                      "https://www.simplilearn.com/ice9/free_resources_article_thumb/what_is_image_Processing.jpg"),
                                                  backgroundColor:
                                                      Colors.transparent,
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    FutureBuilder<String>(
                                                        future: fetchDocs2(snapshot
                                                            .data![i]
                                                            .substring(
                                                                0,
                                                                snapshot
                                                                    .data![i]
                                                                    .indexOf(
                                                                        ':'))),
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

                                                            return Text(
                                                                "context");
                                                          } else {
                                                            // print("snap");
                                                            // print(snapshot
                                                            //     .data);
                                                            return Align(
                                                              child: Text(
                                                                //   fetchDocs2(snapshot.data![i].substring(0,snapshot.data![i].indexOf(':'))) ,
                                                                snapshot.data!,
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                            );
                                                          }
                                                        }),
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
                                                      state(() =>
                                                          userStatus[i] =
                                                              !userStatus[i]);
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
                    // to here
                  ]);
            }));
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
            'Homme du match',
            textAlign: TextAlign.center,
            style: TextStyle(),
          ),
          Spacer(),
          IconButton(
              icon: Icon(Icons.add, color: Color.fromARGB(255, 255, 255, 255)),
              onPressed: () async {
                for (int i = 0; i < userStatus.length; i++) {
                  if (userStatus[i] == true) {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();

                    members1 = [];
                    members1.add(memberslist[0][i]
                        .substring(0, memberslist[0][i].indexOf(':')));
                  }
                }
                Map<String, dynamic> userData = {"hommeDuMatchList": members1};

                Map<String, String> headers = {
                  "Content-Type": "application/json; charset=UTF-8"
                };

                http
                    .put(
                        Uri.http(_baseUrl, "/api/evenements/" + '${widget.id}'),
                        headers: headers,
                        body: json.encode(userData))
                    .then((http.Response response) async {
                  print(userData);
                  if (response.statusCode == 200) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CalendrierDetail(id: widget.id)),
                    ).then((value) => setState(() {}));
                  } else if (response.statusCode == 401) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const AlertDialog(
                            title: Text("Information"),
                            content:
                                Text("Username et/ou mot de passe incorrect"),
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

                print(members1);
              }),
        ]));
  }
}
