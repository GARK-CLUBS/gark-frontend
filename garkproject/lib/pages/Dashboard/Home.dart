import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:garkproject/pages/Dashboard/AddDepenses.dart';
import 'package:garkproject/pages/Dashboard/AddPayment.dart';
import 'package:garkproject/pages/Dashboard/EditDepenses.dart';
import 'package:garkproject/pages/Dashboard/EditPayment.dart';
import 'package:mccounting_text/mccounting_text.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

String cn = "";
SharedPreferences? prefs;

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  var PaymentList = [];
  var DepensesList = [];
  var DepensesListannuel = [];
  double somme = 0;
  double length = 0;
  Future<String> fetchDocs2(String id) async {
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8",
    };
    http.Response response = await http.get(
        Uri.parse("http://10.0.2.2:3000/api/membres/" + id),
        headers: headers);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      //  print(data );
      return data["nom"] + " " + data["prenom"];
    } else {
      return " ";
    }
  }

  Future<List> GetAllPayment() async {
    try {
      prefs = await SharedPreferences.getInstance();
      cn = prefs!.getString("participantClub")!;
      Map<String, String> headers = {
        "Content-Type": "application/json; charset=UTF-8",
      };
      var response = await http.get(
          Uri.parse("http://10.0.2.2:3000/api/clubs/allpayment/" + cn),
          headers: headers);
      if (response.statusCode == 200) {
        PaymentList = [];
        var data = jsonDecode(response.body);
        setState(() {
          PaymentList = data[0]["club"];
        });
        length = 0 ; 
        somme = 0 ; 
        length = (data[0]["club"].length).toDouble();

        for (var u in data[0]["club"]) {
          setState(() {
            somme += u["montant"];
          });
        }
        print(PaymentList);
        return data[0]["club"];
      } else {
        return Future.error("server error");
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List> GetAllDepense() async {
    try {
      prefs = await SharedPreferences.getInstance();
      cn = prefs!.getString("participantClub")!;
      Map<String, String> headers = {
        "Content-Type": "application/json; charset=UTF-8",
      };
      var response = await http.get(
          Uri.parse("http://10.0.2.2:3000/api/clubs/alldepanse/" + cn),
          headers: headers);
      if (response.statusCode == 200) {
        DepensesList = [];
        DepensesListannuel = [];
        var data = jsonDecode(response.body);
        setState(() {
          for (var u in data[0]["club"]) {
            if (u["type"] == "mensuel") {
              setState(() {
                DepensesList.add(u);
              });
            } else {
              setState(() {
                DepensesListannuel.add(u);
              });
            }
          }
        });
        print(DepensesList);
        return data[0]["club"];
      } else {
        return Future.error("server error");
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  void initState() {
    GetAllPayment();
    GetAllDepense();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 245, 245),
      body: getBody(),
    );
  }

  Widget getBody() {
    TabController _tabController = TabController(length: 3, vsync: this);

    return Form(
      child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 20,
        ),
        Align(
          alignment: Alignment(-0.8, 0),
          child: Text(
            "Collections",
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 18,
              color: Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          color: Colors.white,
          child: TabBar(
              isScrollable: true, // new line

              controller: _tabController,
              labelColor: Color.fromARGB(255, 255, 255, 255),
              tabs: [
                Tab(
                  child: Container(
                    width: 100,
                    height: 36,
                    child: Center(
                        child: Text("Dashboard",
                            style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 12))),
                  ),
                ),
                Tab(
                    child: Container(
                  width: 110,
                  height: 36,
                  child: Center(
                      child: Text("Payments",
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 11))),
                )),
                Tab(
                    child: Container(
                  width: 100,
                  height: 36,
                  child: Center(
                      child: Text("Depenses",
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 12))),
                )),
              ]),
        ),
        Container(
          color: Color.fromARGB(255, 244, 244, 244),
          width: double.maxFinite,
          height: 530,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TabBarView(controller: _tabController, children: [
            ListView.builder(
                itemCount: 1,
                itemBuilder: (_, index) {
                  return Container(
                      // padding: const EdgeInsets.only(
                      //   left: 20,
                      //   right: 20,
                      // ),
                      child: Column(children: [
                    Container(
                        width: double.maxFinite,
                        height: 140,
                        padding: EdgeInsets.symmetric(vertical: 30),
                        margin: EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceEvenly, // use whichever suits your need
                                children: [
                                  Column(
                                    children: [
                                      McCountingText(
                                        begin: 0,
                                        end: somme,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4,
                                        duration: Duration(seconds: 1),
                                        curve: Curves.decelerate,
                                      ),
                                      Text(
                                        "Collected",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      McCountingText(
                                        begin: 0,
                                        end: length,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4,
                                        duration: Duration(seconds: 1),
                                        curve: Curves.decelerate,
                                      ),
                                      Text(
                                        "Open Collections",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ]))),
                    //working here
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            margin: const EdgeInsets.only(bottom: 15),
                            child: Column(
                              children: [
                                Row(children: [
                                  Text(
                                    "Recent payments",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Spacer(),
                                  SizedBox(
                                    height: 45,
                                    child: Container(
                                      padding: EdgeInsets.only(top: 15),
                                      child: GestureDetector(
                                        onTap: () {
                                          _tabController.index = 1;
                                        },

                                        child: Text(
                                          "See all payments",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Color.fromARGB(
                                                255, 64, 197, 40),
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ), //label text,
                                      ),
                                    ),
                                  ),
                                ]),
                                CreateTable(),
                              ],
                            ))),
                    SizedBox(
                      height: 30,
                    )
                  ]));
                }),
            ListView.builder(
                itemCount: 1,
                itemBuilder: (_, index) {
                  return Container(
                      // padding: const EdgeInsets.only(
                      //   left: 20,
                      //   right: 20,
                      // ),
                      child: Column(children: [
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment(-0.9, 0),
                      child: Text(
                        "Payments",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            margin: const EdgeInsets.only(bottom: 15),
                            child: Column(
                              children: [
                                Row(children: [
                                  Text(
                                    "Recent payments",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Spacer(),
                                  SizedBox(
                                    height: 45,
                                    child: Container(
                                      padding: EdgeInsets.only(top: 15),
                                      child: GestureDetector(
                                        onTap: () {
                                          _tabController.index = 1;
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AddPayment()),
                                          ).then((value) => setState(() {}));
                                        },

                                        child: Text(
                                          "Add new payment",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Color.fromARGB(
                                                255, 64, 197, 40),
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ), //label text,
                                      ),
                                    ),
                                  ),
                                ]),
                                CreateTable(),
                              ],
                            ))),
                    SizedBox(
                      height: 30,
                    )
                  ]));
                }),
            ListView.builder(
                itemCount: 1,
                itemBuilder: (_, index) {
                  return Container(
                      // padding: const EdgeInsets.only(
                      //   left: 20,
                      //   right: 20,
                      // ),
                      child: Column(children: [
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment(-0.9, 0),
                      child: Text(
                        "Depenses mensuel",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            margin: const EdgeInsets.only(bottom: 15),
                            child: Column(
                              children: [
                                Row(children: [
                                  Text(
                                    "Recent payments",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Spacer(),
                                  SizedBox(
                                    height: 45,
                                    child: Container(
                                      padding: EdgeInsets.only(top: 15),
                                      child: GestureDetector(
                                        onTap: () {
                                          _tabController.index = 1;
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AddDepenses(
                                                        type: "mensuel")),
                                          ).then((value) => setState(() {}));
                                        },

                                        child: Text(
                                          "Add new payment",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Color.fromARGB(
                                                255, 64, 197, 40),
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ), //label text,
                                      ),
                                    ),
                                  ),
                                ]),
                                CreateTable2(),
                              ],
                            ))),
                    Align(
                      alignment: Alignment(-0.9, 0),
                      child: Text(
                        "Depenses annuel",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            margin: const EdgeInsets.only(bottom: 15),
                            child: Column(
                              children: [
                                Row(children: [
                                  Text(
                                    "Recent payments",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Spacer(),
                                  SizedBox(
                                    height: 45,
                                    child: Container(
                                      padding: EdgeInsets.only(top: 15),
                                      child: GestureDetector(
                                        onTap: () {
                                          _tabController.index = 1;
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AddDepenses(
                                                        type: "annuel")),
                                          ).then((value) => setState(() {}));
                                        },

                                        child: Text(
                                          "Add new payment",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Color.fromARGB(
                                                255, 64, 197, 40),
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ), //label text,
                                      ),
                                    ),
                                  ),
                                ]),
                                CreateTable3(),
                              ],
                            ))),
                    SizedBox(
                      height: 20,
                    ),
                  ]));
                })
          ]),
        )
      ])),
    );
  }

  Widget CreateTable() {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 55.0,
          columns: [
            DataColumn(label: Text('paidby')),
            DataColumn(label: Text('paidfor')),
            DataColumn(label: Text('date')),
            DataColumn(label: Text('Amount paid')),
            DataColumn(label: Text('Abonnement')),
            DataColumn(label: Text('Edit')),
            DataColumn(label: Text('Delete')),
          ],
          rows: PaymentList.map((e) => DataRow(cells: [
                DataCell(Container(
                  child: FutureBuilder<String>(
                      future: fetchDocs2(e["membre"]),
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
                              snapshot.data!,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontWeight: FontWeight.w400),
                            ),
                          );
                        }
                      }),
                )),
                DataCell(Container(
                  child: Text(e["PayedFor"]),
                )),
                DataCell(Container(
                  child: Text(e["createdAt"]),
                )),
                DataCell(Container(
                  child: Text(e["montant"].toString()),
                )),
                DataCell(Container(
                  child: Text(e["type"].toString()),
                )),
                // DataCell(Container(
                //   width: e["pack"] == 'Payé' ? 45 : 65,
                //   height: 19,
                //   decoration: BoxDecoration(
                //       color: e["pack"] == 'Payé'
                //           ? Color.fromARGB(255, 161, 211, 166)
                //           : Color.fromARGB(255, 207, 93, 93),
                //       borderRadius: BorderRadius.all(Radius.circular(20))),
                //   child: Text(
                //     e["pack"],
                //     style: TextStyle(color: Color.fromARGB(255, 253, 253, 253)),
                //     textAlign: TextAlign.center,
                //   ),
                // )),
                DataCell(
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Color.fromARGB(255, 2, 0, 50),
                    child: IconButton(
                      icon: const Icon(
                        Icons.edit,
                        color: Color.fromARGB(255, 249, 249, 249),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditPayment(id: e["_id"])),
                        ).then((value) => setState(() {}));
                      },
                    ),
                  ),
                ),
                DataCell(
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Color.fromARGB(255, 255, 0, 0),
                    child: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Color.fromARGB(255, 249, 249, 249),
                      ),
                      onPressed: () {
                        Map<String, String> headers = {
                          "Content-Type": "application/json; charset=UTF-8"
                        };
                        http
                            .delete(
                          Uri.http(
                              "10.0.2.2:3000", "/api/payments/" + e["_id"]),
                          headers: headers,
                        )
                            .then((http.Response response) async {
                          if (response.statusCode == 200) {
                            // refresh delete
                            setState(() {
                              GetAllPayment();
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
                    ),
                  ),
                ),
              ])).toList(),
        ));
  }

  Widget CreateTable2() {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 55.0,
          columns: [
            DataColumn(label: Text('Type')),
            DataColumn(label: Text('Somme')),
            DataColumn(label: Text('Date paiement')),
            DataColumn(label: Text('Edit')),
            DataColumn(label: Text('Delete')),
          ],
          rows: DepensesList.map((e) => DataRow(cells: [
                DataCell(Container(
                  child: Text(e["sousType"]),
                )),
                // DataCell(Container(
                //   width: e["datePayment"] == 'Payé' ? 45 : 65,
                //   height: 19,
                //   decoration: BoxDecoration(
                //       color: e["datePayment"] == 'Payé'
                //           ? Color.fromARGB(255, 161, 211, 166)
                //           : Color.fromARGB(255, 207, 93, 93),
                //       borderRadius: BorderRadius.all(Radius.circular(20))),
                //   child: Text(
                //     e["datePayment"],
                //     style: TextStyle(color: Color.fromARGB(255, 253, 253, 253)),
                //     textAlign: TextAlign.center,
                //   ),
                // )),
                DataCell(Container(
                  child: Text(e["montant"]),
                )),
                DataCell(Container(
                  child: Text(e["createdAt"]),
                )),
                DataCell(
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Color.fromARGB(255, 2, 0, 50),
                    child: IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Color.fromARGB(255, 249, 249, 249),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  EditDepenses(type: "mensuel", id: e["_id"])),
                        ).then((value) => setState(() {}));
                      },
                    ),
                  ),
                ),
                DataCell(
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Color.fromARGB(255, 255, 0, 0),
                    child: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Color.fromARGB(255, 249, 249, 249),
                      ),
                      onPressed: () {
                        Map<String, String> headers = {
                          "Content-Type": "application/json; charset=UTF-8"
                        };
                        http
                            .delete(
                          Uri.http(
                              "10.0.2.2:3000", "/api/depanses/" + e["_id"]),
                          headers: headers,
                        )
                            .then((http.Response response) async {
                          if (response.statusCode == 200) {
                            // refresh delete
                            setState(() {
                              GetAllPayment();
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
                    ),
                  ),
                ),
              ])).toList(),
        ));
  }

  Widget CreateTable3() {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 55.0,
          columns: [
            DataColumn(label: Text("Type d'assurance")),
            DataColumn(label: Text('assurance')),
            DataColumn(label: Text('Montant')),
            DataColumn(label: Text('Date paiement')),
            DataColumn(label: Text('Edit')),
            DataColumn(label: Text('Desactivate')),
          ],
          rows: DepensesListannuel.map((e) => DataRow(cells: [
                DataCell(Container(
                  child: Text(e["type"]),
                )),
                DataCell(Container(
                  child: Text(e["sousType"]),
                )),
                // DataCell(Container(
                //   width: e["datePayment"] == 'Payé' ? 45 : 65,
                //   height: 19,
                //   decoration: BoxDecoration(
                //       color: e["datePayment"] == 'Payé'
                //           ? Color.fromARGB(255, 161, 211, 166)
                //           : Color.fromARGB(255, 207, 93, 93),
                //       borderRadius: BorderRadius.all(Radius.circular(20))),
                //   child: Text(
                //     e["datePayment"],
                //     style: TextStyle(color: Color.fromARGB(255, 253, 253, 253)),
                //     textAlign: TextAlign.center,
                //   ),
                // )),
                DataCell(Container(
                  child: Text(e["montant"]),
                )),
                DataCell(Container(
                  child: Text(e["createdAt"]),
                )),
                DataCell(
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Color.fromARGB(255, 2, 0, 50),
                    child: IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Color.fromARGB(255, 249, 249, 249),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  EditDepenses(type: "annuel", id: e["_id"])),
                        ).then((value) => setState(() {}));
                      },
                    ),
                  ),
                ),
                DataCell(
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Color.fromARGB(255, 255, 0, 0),
                    child: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Color.fromARGB(255, 249, 249, 249),
                      ),
                      onPressed: () {
                        Map<String, String> headers = {
                          "Content-Type": "application/json; charset=UTF-8"
                        };
                        http
                            .delete(
                          Uri.http(
                              "10.0.2.2:3000", "/api/depanses/" + e["_id"]),
                          headers: headers,
                        )
                            .then((http.Response response) async {
                          if (response.statusCode == 200) {
                            // refresh delete
                            print("object");
                            setState(() {
                              GetAllPayment();
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
                    ),
                  ),
                ),
              ])).toList(),
        ));
  }
}
