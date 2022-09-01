import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class updateAdversaire extends StatefulWidget {
  const updateAdversaire({Key? key, required this.id, required this.equipeid})
      : super(key: key);
  final String equipeid;
  final String id;

  @override
  State<updateAdversaire> createState() => _updateAdversaireState();
}

GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
String _baseUrl = "10.0.2.2:3000";

final TextEditingController _nom = TextEditingController();
final TextEditingController _nomcourant = TextEditingController();
final TextEditingController _email = TextEditingController();
final TextEditingController _telephone = TextEditingController();

class _updateAdversaireState extends State<updateAdversaire> {
  late Future<bool> fetchedDocs;

  SharedPreferences? prefs;

  String cn = "";
  var data = [];
  Future<bool> fetchDocss() async {
    prefs = await SharedPreferences.getInstance();
    cn = prefs!.getString("nameClub")!;

    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8",
    };
    http.Response response = await http.get(
        Uri.parse("http://10.0.2.2:3000/api/adversaires/" + '${widget.id}'),
        headers: headers);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      _nom.text = data["nom"];
      _telephone.text = data["telephone"];
      _email.text = data["email"];
      _nomcourant.text = data["nomCourant"];
    }

    return true;
  }

  @override
  void initState() {
    fetchedDocs = fetchDocss();
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
            Text(
              "Update adversaire",
              style: TextStyle(),
            ),
          ]),
    );
  }

  Widget getBody() {
    return Form(
      key: _keyForm,
      child: SingleChildScrollView(
          child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
          SizedBox(height: 20),
          TextFormField(
            controller: _nom,
            decoration: const InputDecoration(
              hintText: 'Nom de votre equipe ? *',
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Color.fromARGB(255, 0, 0, 0), width: 1.0),
              ),
            ),
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
          TextFormField(
            controller: _nomcourant,
            decoration: const InputDecoration(
              hintText: 'Nom courant *',
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Color.fromARGB(255, 0, 0, 0), width: 1.0),
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "Veuillez renseigner votre nom courant .";
              } else {
                return null;
              }
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _email,
            decoration: const InputDecoration(
              hintText: 'Email *',
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Color.fromARGB(255, 0, 0, 0), width: 1.0),
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "Veuillez renseigner votre email .";
              } else {
                return null;
              }
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _telephone,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: "Telephone",
              labelStyle: TextStyle(
                  color: Colors.black87,
                  fontSize: 17,
                  fontFamily: 'AvenirLight'),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
              ),
            ),
            style: const TextStyle(
                color: Colors.black87, fontSize: 17, fontFamily: 'AvenirLight'),
          ),
          Container(
            margin: EdgeInsets.only(top: 100),
            width: 250,
            height: 45, // <-- Your width
            child: Container(
              // padding: EdgeInsets.only(top: 30),
              child: ElevatedButton(
                onPressed: () {
                  if (_keyForm.currentState!.validate()) {
                    //   _keyForm.currentState!.save();
                    Map<String, dynamic> userData1 = {
                      "_id": widget.equipeid,
                    };

                    Map<String, dynamic> userData = {
                      "nom": _nom.text,
                      "nomCourant": _nomcourant.text,
                      "email": _email.text,
                      "telephone": _telephone.text,
                      "equipe": userData1
                    };

                    Map<String, String> headers = {
                      "Content-Type": "application/json; charset=UTF-8"
                    };

                    http
                        .put(
                            Uri.http(
                                _baseUrl, "/api/adversaires/" + '${widget.id}'),
                            headers: headers,
                            body: json.encode(userData))
                        .then((http.Response response) async {
                      if (response.statusCode == 200) {
                        _nom.text = "";
                        _nomcourant.text = "";
                        _email.text = "";
                        _telephone.text = "";
                        Navigator.pop(context);
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
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(200, 0, 249, 93),
                ),
                child: Text(
                  "Enregistrer ",
                  style: TextStyle(
                    fontSize: 15,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ]),
      )),
    );
  }
}
