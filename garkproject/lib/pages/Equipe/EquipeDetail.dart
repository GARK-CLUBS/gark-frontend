import 'package:flutter/material.dart';

import 'package:garkproject/pages/Equipe/Categories/Adversaires/Adversaires.dart';
import 'package:garkproject/pages/Equipe/Categories/Presences.dart';
import 'package:garkproject/pages/Equipe/Categories/Stades/Stade.dart';
import 'package:garkproject/pages/Equipe/Categories/StatEquipe.dart';
import 'package:garkproject/pages/Equipe/Categories/StatJoueurs.dart';
import 'package:garkproject/pages/Membre/Membre.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class EquipeDetail extends StatefulWidget {
  const EquipeDetail({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<EquipeDetail> createState() => _EquipeDetailState();
}

SharedPreferences? prefs;

String cn = "";

class _EquipeDetailState extends State<EquipeDetail> {
  late Future<bool> fetchedDocs;
  var data = [];
  int length_membre = 0;
  String referalcode = "";
  Future<int> fetchDocs() async {
    prefs = await SharedPreferences.getInstance();
    cn = prefs!.getString("nameClub")!;

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
      return length_membre;
    } else {
      return 0;
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => fetchDocs());

    //   fetchedDocs = fetchDocs();
    super.initState();
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
        Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: Colors.black)),
          child: Center(
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://sportbusiness.club/wp-content/uploads/2020/05/Football-Club-FC-Barcelone-1-678x381.jpg"),
                      fit: BoxFit.cover)),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          cn,
          style: TextStyle(),
        ),
      ]),
    );
  }

  Widget getBody() {
    return FutureBuilder(
        future: fetchDocs(),
        builder: (context, snapshot) {
          return SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Column(
                  children: <Widget>[
                    Container(
                        child: Stack(children: <Widget>[
                      Container(
                        height:
                            90, // change it to 140 idha nheb nrejaaha kima kenet
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 2, 0, 50),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(36),
                              bottomRight: Radius.circular(36),
                            )),
                      ),
                      Container(
                          height: 80,
                          width: MediaQuery.of(context).size.width - 40,
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 40),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    blurRadius: 15,
                                    spreadRadius: 5)
                              ]),
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: IntrinsicHeight(
                              child: Row(children: [
                                Text(
                                  snapshot.data.toString(),
                                  style: TextStyle(
                                    fontSize: 44,
                                    color: Color.fromARGB(255, 58, 58, 58),
                                  ),
                                ),
                                Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Membre dans léquipe",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Row(children: [
                                        Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      "https://sportbusiness.club/wp-content/uploads/2020/05/Football-Club-FC-Barcelone-1-678x381.jpg"),
                                                  fit: BoxFit.cover)),
                                        ),
                                        Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(0),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      "https://sportbusiness.club/wp-content/uploads/2020/05/Football-Club-FC-Barcelone-1-678x381.jpg"),
                                                  fit: BoxFit.cover)),
                                        ),
                                        SizedBox(
                                          width: 60,
                                        )
                                      ]),
                                    ]),
                                Spacer(),
                                Container(
                                    alignment: Alignment(0, 0),
                                    child: SizedBox.fromSize(
                                      size: Size(56, 56),
                                      child: ClipOval(
                                        child: Material(
                                          color: Colors.grey.withOpacity(0.0),
                                          child: InkWell(
                                            splashColor: Color.fromARGB(
                                                255, 248, 248, 248),
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => Membre(
                                                        id: '${widget.id}')),
                                              ).then(
                                                  (value) => setState(() {}));

                                              // Navigator.of(context).push(
                                              //     MaterialPageRoute(
                                              //         builder: (c) =>
                                              //             Membre(id: '${widget.id}')));
                                            },
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(Icons
                                                    .arrow_forward_ios), // <-- Icon
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )),
                              ]),
                            ),
                          )),
                    ])),
                  ],
                ),
                // Align(
                //   alignment: Alignment(-0.8, 0.5),
                //   child: Text(
                //     "Championnats",
                //     textAlign: TextAlign.right,
                //     style: TextStyle(
                //       fontSize: 18,
                //       color: Color.fromARGB(255, 0, 0, 0),
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: 10,
                // ),
                // Container(
                //     height: 180,
                //     width: MediaQuery.of(context).size.width,
                //     decoration: BoxDecoration(color: Colors.white, boxShadow: [
                //       BoxShadow(
                //           color: Colors.black.withOpacity(0.1),
                //           blurRadius: 10,
                //           spreadRadius: 3)
                //     ]),
                //     child: Container(
                //         padding: const EdgeInsets.symmetric(horizontal: 10),
                //         child: Column(children: [
                //           Container(
                //             width: 100,
                //             height: 80,
                //             decoration: BoxDecoration(
                //                 borderRadius: BorderRadius.circular(0),
                //                 image: DecorationImage(
                //                     image: NetworkImage(
                //                         "https://static.vecteezy.com/system/resources/previews/001/991/687/original/crown-isolated-icon-symbol-illustration-of-crown-icon-on-white-background-free-vector.jpg"),
                //                     fit: BoxFit.cover)),
                //           ),
                //           Text(
                //             "Aucun championnat en cours",
                //             textAlign: TextAlign.center,
                //             style: TextStyle(
                //               fontSize: 18,
                //               color: Color.fromARGB(255, 131, 131, 131),
                //               fontWeight: FontWeight.bold,
                //             ),
                //           ),
                //           SizedBox(
                //             height: 10,
                //           ),
                //           Text(
                //             "Créez votre première rencontre de championnat depuis le calendrier et complétez le reste des informations sur le web , dans la section championnat",
                //             textAlign: TextAlign.center,
                //             style: TextStyle(
                //               fontSize: 14,
                //               color: Color.fromARGB(255, 174, 174, 174),
                //               fontWeight: FontWeight.bold,
                //             ),
                //           ),
                //         ]))),
                SizedBox(
                  height: 25,
                ),
                Align(
                  alignment: Alignment(-0.8, 0.5),
                  child: Text(
                    "Catégories",
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
                    height: 50,
                    width: MediaQuery.of(context).size.width - 40,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              spreadRadius: 3)
                        ]),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 33,
                              height: 33,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(0),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          "https://st2.depositphotos.com/5266903/8986/v/380/depositphotos_89861218-stock-illustration-patient-ok-rounded-vector-icon.jpg?forcejpeg=true"),
                                      fit: BoxFit.cover)),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment(-0.8, 0),
                                child: Text(
                                  "Bilan des présances",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                                alignment: Alignment(0, 0),
                                child: SizedBox.fromSize(
                                  size: Size(56, 56),
                                  child: ClipOval(
                                    child: Material(
                                      color: Colors.grey.withOpacity(0.0),
                                      child: InkWell(
                                        splashColor:
                                            Color.fromARGB(255, 248, 248, 248),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    BilanPresence(
                                                      idequipe: widget.id,
                                                    )),
                                          ).then((value) => setState(() {}));
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(Icons
                                                .arrow_forward_ios), // <-- Icon
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                          ]),
                    )),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width - 40,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 3)
                      ]),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 33,
                            height: 33,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(0),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "https://findicons.com/files/icons/744/juicy_fruit/256/stats.png"),
                                    fit: BoxFit.cover)),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment(-0.87, 0),
                              child: Text(
                                "Stats équipe",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          Container(
                              alignment: Alignment(0, 0),
                              child: SizedBox.fromSize(
                                size: Size(56, 56),
                                child: ClipOval(
                                  child: Material(
                                    color: Color.fromARGB(255, 213, 199, 199)
                                        .withOpacity(0.0),
                                    child: InkWell(
                                      splashColor:
                                          Color.fromARGB(255, 248, 248, 248),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => StatEquipe(
                                                    idequipe: widget.id,
                                                  )),
                                        ).then((value) => setState(() {}));
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(Icons
                                              .arrow_forward_ios_sharp), // <-- Icon
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                        ]),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width - 40,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              spreadRadius: 3)
                        ]),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(0),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          "https://icon-library.com/images/statistics-icon/statistics-icon-2.jpg"),
                                      fit: BoxFit.cover)),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment(-0.84, 0),
                                child: Text(
                                  "Stats joueurs",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                                alignment: Alignment(0, 1),
                                child: SizedBox.fromSize(
                                  size: Size(56, 56),
                                  child: ClipOval(
                                    child: Material(
                                      color: Colors.grey.withOpacity(0.0),
                                      child: InkWell(
                                        splashColor:
                                            Color.fromARGB(255, 248, 248, 248),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    StatJoueurs(
                                                        idequipe: widget.id)),
                                          ).then((value) => setState(() {}));
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(Icons
                                                .arrow_forward_ios), // <-- Icon
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                          ]),
                    )),
                SizedBox(
                  height: 15,
                ),
                Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width - 40,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              spreadRadius: 3)
                        ]),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(0),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          "https://cdn-icons-png.flaticon.com/512/821/821357.png"),
                                      fit: BoxFit.cover)),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment(-0.88, 0),
                                child: Text(
                                  "Stades",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                                alignment: Alignment(0, 1),
                                child: SizedBox.fromSize(
                                  size: Size(56, 56),
                                  child: ClipOval(
                                    child: Material(
                                      color: Colors.grey.withOpacity(0.0),
                                      child: InkWell(
                                        splashColor:
                                            Color.fromARGB(255, 248, 248, 248),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Stade(equipeid: widget.id)),
                                          ).then((value) => setState(() {}));
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(Icons
                                                .arrow_forward_ios), // <-- Icon
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                          ]),
                    )),
                SizedBox(
                  height: 15,
                ),
                Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width - 40,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              spreadRadius: 3)
                        ]),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(0),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          "https://img.freepik.com/vecteurs-libre/versus-battle-illustration-logo-design-template-versus-vector-icon-vs-lettres-pour-sport_564974-202.jpg"),
                                      fit: BoxFit.cover)),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment(-0.86, 0),
                                child: Text(
                                  "Adversaires",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                                alignment: Alignment(0, 1),
                                child: SizedBox.fromSize(
                                  size: Size(56, 56),
                                  child: ClipOval(
                                    child: Material(
                                      color: Colors.grey.withOpacity(0.0),
                                      child: InkWell(
                                        splashColor:
                                            Color.fromARGB(255, 248, 248, 248),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Adversaires(
                                                        equipeid: widget.id)),
                                          ).then((value) => setState(() {}));
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(Icons
                                                .arrow_forward_ios), // <-- Icon
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                          ]),
                    )),
                SizedBox(height: 15)
              ]));
        });
  }
}
