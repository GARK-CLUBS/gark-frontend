import 'package:flutter/material.dart';
import 'package:garkproject/pages/Membre/AddMembre.dart';
import 'package:garkproject/pages/Membre/UpdateMembre.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// TODO profile page to edit for member
/*
design update equipe
profile ,    
*/
class Membre extends StatefulWidget {
  const Membre({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<Membre> createState() => _MembreState();
}

enum _MenuValues { modifier, supprimer }

String _baseUrl = "http://10.0.2.2:3000/api/membres/";

class _MembreState extends State<Membre> {
  Future<List> GetMembers() async {
    try {
      Map<String, String> headers = {
        "Content-Type": "application/json; charset=UTF-8",
      };
      http.Response response = await http.get(
          Uri.parse(
              "http://10.0.2.2:3000/api/equipes/allmembre/" + '${widget.id}'),
          headers: headers);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        return data[0]["membre"];
      } else {
        return Future.error("server error");
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  late Future<bool> fetchedDocs;
  var data = [];
  int length_membre = 0;
  String referalcode = "";
  Future<bool> fetchDocs() async {
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8",
    };
    http.Response response = await http.get(
        Uri.parse("http://10.0.2.2:3000/api/equipes/" + '${widget.id}'),
        headers: headers);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      length_membre = data["membres"].length;
      referalcode = data["referral_code"];
    }

    return true;
  }

// everytime you modify you have to restart
  @override
  void initState() {
    fetchedDocs = fetchDocs();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:
          PreferredSize(child: getAppBar(), preferredSize: Size.fromHeight(50)),
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
          'Membres',
          textAlign: TextAlign.center,
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
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Wrap(
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Text(
                                  "Invitez les membres de votre équipe",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment(-0.8, 0),
                                child: Text(
                                  "Envoyer un email",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black.withOpacity(0),
                                            blurRadius: 10,
                                            spreadRadius: 3)
                                      ]),
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 28,
                                            height: 28,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        "https://png.pngtree.com/svg/20160316/add_user_1132309.png"),
                                                    fit: BoxFit.cover)),
                                          ),
                                          Flexible(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Align(
                                                  alignment: Alignment(-0.8, 0),
                                                  child: Text(
                                                    "1 par 1",
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 0),
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )),
                                          Container(
                                              alignment: Alignment(0, 1),
                                              child: SizedBox.fromSize(
                                                size: Size(52, 52),
                                                child: ClipOval(
                                                  child: Material(
                                                    color: Color.fromARGB(
                                                            255, 142, 142, 142)
                                                        .withOpacity(0.0),
                                                    child: InkWell(
                                                      splashColor:
                                                          Color.fromARGB(255,
                                                              248, 248, 248),
                                                      onTap: () {
                                                        print(
                                                            "add btn works !");
                                                      },
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          IconTheme(
                                                            data: new IconThemeData(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        154,
                                                                        154,
                                                                        154)),
                                                            child: Icon(Icons
                                                                .arrow_forward_ios_rounded),
                                                          ),
                                                          // <-- Icon
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )),
                                        ]),
                                  )),
                              Align(
                                alignment: Alignment(-0.8, 0),
                                child: Text(
                                  "Ajouter un membre",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black.withOpacity(0),
                                            blurRadius: 10,
                                            spreadRadius: 3)
                                      ]),
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 28,
                                            height: 28,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        "https://png.pngtree.com/svg/20160316/add_user_1132309.png"),
                                                    fit: BoxFit.cover)),
                                          ),
                                          Flexible(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Align(
                                                  alignment: Alignment(-0.8, 0),
                                                  child: Text(
                                                    "1 par 1",
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 0),
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )),
                                          Container(
                                              alignment: Alignment(0, 1),
                                              child: SizedBox.fromSize(
                                                size: Size(56, 56),
                                                child: ClipOval(
                                                  child: Material(
                                                    color: Color.fromARGB(
                                                            255, 142, 142, 142)
                                                        .withOpacity(0.0),
                                                    child: InkWell(
                                                      splashColor:
                                                          Color.fromARGB(255,
                                                              248, 248, 248),
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  AddMembre(
                                                                      id: '${widget.id}')),
                                                        ).then((value) =>
                                                            setState(() {}));
                                                      },
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          IconTheme(
                                                            data: new IconThemeData(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        154,
                                                                        154,
                                                                        154)),
                                                            child: Icon(Icons
                                                                .arrow_forward_ios_rounded),
                                                          ),
                                                          // <-- Icon
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )),
                                        ]),
                                  )),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 21, vertical: 10),
                                child: Text(
                                  "Donner le code d'invitation dans le vestiaire",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  height: 60,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            blurRadius: 10,
                                            spreadRadius: 3)
                                      ]),
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Flexible(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Align(
                                                  alignment: Alignment(0, 0),
                                                  child: Text(
                                                    referalcode,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 35,
                                                      color: Color.fromARGB(
                                                          255, 38, 164, 0),
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )),
                                        ]),
                                  )),
                            ],
                          );
                        },
                      );
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

// houni l future builder
  Widget getBody() {
    return SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Column(children: <Widget>[
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
          Positioned(
            bottom: 0,
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 15,
                          offset: Offset(0, 1))
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
        ]))
      ]),
      SizedBox(
        height: 10,
      ),
      Align(
        alignment: Alignment(-0.8, 0),
        child: Text(
          "Coach (x)",
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: 18,
            color: Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      SizedBox(
        height: 15,
      ),
      Container(
        child: FutureBuilder<List>(
            future: GetMembers(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(), //<--here

                    shrinkWrap: true,
                    //  snapshot.data?.length
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, i) {
                      if (snapshot.data![i]["role"]?.toString() == "Coach") {
                        return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UpdateMembre(
                                        id: snapshot.data![i]["_id"])),
                              ).then((value) => setState(() {}));
                            },
                            child: Container(
                                height: 60,
                                width: MediaQuery.of(context).size.width,
                                margin: const EdgeInsets.only(bottom: 2),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 10,
                                          spreadRadius: 3)
                                    ]),
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 43,
                                          height: 43,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      "https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlcnxlbnwwfHwwfHw%3D&w=1000&q=80"),
                                                  fit: BoxFit.cover)),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment(-0.8, 0),
                                            child: Text(
                                              snapshot.data![i]["nom"]
                                                      .toString() +
                                                  " " +
                                                  snapshot.data![i]["prenom"]
                                                      .toString(),
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]),
                                )));
                      } else {
                        return SizedBox.shrink();
                      }
                    });
              } else {
                return Align(
                  alignment: Alignment(-0.5, 0),
                  child: Text(
                    "Aucun coach",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 12,
                      color: Color.fromARGB(255, 167, 167, 167),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );

                //return SizedBox.shrink();
              }
            }),
      ),
      SizedBox(
        height: 15,
      ),
      Align(
        alignment: Alignment(-0.8, 0),
        child: Text(
          "Joueurs (x)",
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: 18,
            color: Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      // joueurs
      SizedBox(height: 15),
      Container(
          child: FutureBuilder<List>(
              future: GetMembers(), 
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(), //<--here

                      shrinkWrap: true,
                      //  snapshot.data?.length
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, i) {
                        if (snapshot.data![i]["role"].toString() == "Joueur") {
                          return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UpdateMembre(
                                          id: snapshot.data![i]["_id"])),
                                ).then((value) => setState(() {}));
                              },
                              child: Container(
                                  height: 60,
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.only(bottom: 2),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            blurRadius: 10,
                                            spreadRadius: 3)
                                      ]),
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 43,
                                            height: 43,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        "https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlcnxlbnwwfHwwfHw%3D&w=1000&q=80"),
                                                    fit: BoxFit.cover)),
                                          ),
                                          Flexible(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Align(
                                                  alignment: Alignment(-0.8, 0),
                                                  child: Text(
                                                    snapshot.data![i]["nom"]
                                                            .toString() +
                                                        " " +
                                                        snapshot.data![i]
                                                                ["prenom"]
                                                            .toString(),
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 0),
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Align(
                                                  alignment:
                                                      Alignment(-0.74, 0),
                                                  child: Text(
                                                    "Aucun email renseigné",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Color.fromARGB(
                                                          255, 255, 0, 0),
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )),
                                          Container(
                                            child: PopupMenuButton(
                                              itemBuilder: (BuildContext) => [
                                                PopupMenuItem(
                                                  child: Text(
                                                      'Modifier le membre'),
                                                  value: _MenuValues.modifier,
                                                ),
                                                const PopupMenuItem(
                                                  child: Text(
                                                      'Supprimer le membre',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                                              UpdateMembre(
                                                                  id: snapshot
                                                                          .data![i]
                                                                      ["_id"])),
                                                    ).then((value) =>
                                                        setState(() {}));

                                                    break;
                                                  case _MenuValues.supprimer:
                                                    Map<String, String>
                                                        headers = {
                                                      "Content-Type":
                                                          "application/json; charset=UTF-8"
                                                    };
                                                    http
                                                        .delete(
                                                      Uri.http(
                                                          "10.0.2.2:3000",
                                                          "/api/membres/" +
                                                              snapshot.data![i]
                                                                  ["_id"]),
                                                      headers: headers,
                                                    )
                                                        .then((http.Response
                                                            response) async {
                                                      if (response.statusCode ==
                                                          200) {
                                                        // refresh delete
                                                        setState(() {
                                                          fetchDocs();
                                                        });
                                                      } else if (response
                                                              .statusCode ==
                                                          401) {
                                                        showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return const AlertDialog(
                                                                title: Text(
                                                                    "Information"),
                                                                content: Text(
                                                                    "Username et/ou mot de passe incorrect"),
                                                              );
                                                            });
                                                      } else {
                                                        showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return const AlertDialog(
                                                                title: Text(
                                                                    "Information"),
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
                                        ]),
                                  )));
                          // this is for compte non active uncomment
                          // Container(
                          //     height: 60,
                          //     width: MediaQuery.of(context).size.width,
                          //     decoration: BoxDecoration(color: Colors.white, boxShadow: [
                          //       BoxShadow(
                          //           color: Colors.black.withOpacity(0),
                          //           blurRadius: 10,
                          //           spreadRadius: 3)
                          //     ]),
                          //     child: Container(
                          //       margin: const EdgeInsets.symmetric(vertical: 10),
                          //       padding: const EdgeInsets.symmetric(horizontal: 10),
                          //       child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          //         Container(
                          //           width: 43,
                          //           height: 43,
                          //           decoration: BoxDecoration(
                          //               borderRadius: BorderRadius.circular(20),
                          //               image: DecorationImage(
                          //                   image: NetworkImage(
                          //                       "https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlcnxlbnwwfHwwfHw%3D&w=1000&q=80"),
                          //                   fit: BoxFit.cover)),
                          //         ),
                          //         Flexible(
                          //             child: Column(
                          //           crossAxisAlignment: CrossAxisAlignment.start,
                          //           mainAxisAlignment: MainAxisAlignment.start,
                          //           children: [
                          //             Expanded(
                          //               child: Align(
                          //                 alignment: Alignment(-0.8, 0),
                          //                 child: Text(
                          //                   "Slim Ayadi",
                          //                   textAlign: TextAlign.right,
                          //                   style: TextStyle(
                          //                     fontSize: 15,
                          //                     color: Color.fromARGB(255, 0, 0, 0),
                          //                     fontWeight: FontWeight.w600,
                          //                   ),
                          //                 ),
                          //               ),
                          //             ),
                          //             Expanded(
                          //               child: Align(
                          //                 alignment: Alignment(-0.74, 0),
                          //                 child: Text(
                          //                   "Compte non activé",
                          //                   textAlign: TextAlign.left,
                          //                   style: TextStyle(
                          //                     fontSize: 15,
                          //                     color: Color.fromARGB(255, 255, 181, 62),
                          //                     fontWeight: FontWeight.w600,
                          //                   ),
                          //                 ),
                          //               ),
                          //             ),
                          //           ],
                          //         )),
                          //         Container(
                          //             alignment: Alignment(0, 1),
                          //             child: SizedBox.fromSize(
                          //               size: Size(56, 56),
                          //               child: ClipOval(
                          //                 child: Material(
                          //                   color: Color.fromARGB(255, 255, 0, 0).withOpacity(0.0),
                          //                   child: InkWell(
                          //                     splashColor: Color.fromARGB(255, 248, 248, 248),
                          //                     onTap: () {
                          //                       print("add btn works !");
                          //                     },
                          //                     child: Column(
                          //                       mainAxisAlignment: MainAxisAlignment.center,
                          //                       children: <Widget>[
                          //                         IconTheme(
                          //                           data: new IconThemeData(
                          //                               color: Color.fromARGB(255, 255, 181, 62)),
                          //                           child: Icon(Icons.replay),
                          //                         ),
                          //                         // <-- Icon
                          //                       ],
                          //                     ),
                          //                   ),
                          //                 ),
                          //               ),
                          //             )),
                          //       ]),
                          //     )),
                        } else {
                          return SizedBox.shrink();
                        }
                      });
                } else {
                  return Align(
                    alignment: Alignment(-0.5, 0),
                    child: Text(
                      "Aucun joueur",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 12,
                        color: Color.fromARGB(255, 167, 167, 167),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                }
              }))
    ]));
  }
}
