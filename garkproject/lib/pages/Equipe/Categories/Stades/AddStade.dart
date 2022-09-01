import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddStade extends StatefulWidget {
  const AddStade({Key? key, required this.equipeid}) : super(key: key);
  final String equipeid;
  @override
  State<AddStade> createState() => _AddStadeState();
}

class _AddStadeState extends State<AddStade> {
  final TextEditingController _nom = TextEditingController();
  final TextEditingController _adresse = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _telephone = TextEditingController();
  final TextEditingController _acces = TextEditingController();
  final TextEditingController _info = TextEditingController();
  String _baseUrl = "10.0.2.2:3000";
  GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

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
              "Nouveau Stade",
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
            controller: _adresse,
            decoration: const InputDecoration(
              hintText: 'Adresse *',
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
            controller: _acces,
            decoration: const InputDecoration(
              hintText: 'Acceès *',
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
            controller: _info,
            decoration: const InputDecoration(
              hintText: 'Infos *',
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Color.fromARGB(255, 0, 0, 0), width: 1.0),
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "Veuillez renseigner votre infos .";
              } else {
                return null;
              }
            },
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
                    // print(userData1);
                    // print(_nom.text);
                    // print(_telephone.text);
                    // print(_email.text);
                    // print(_acces.text);
                    Map<String, dynamic> userData = {
                      "nom": _nom.text,
                      "adresse": _adresse.text,
                      "telephone": _telephone.text,
                      "email": _email.text,
                      "acces": _acces.text,
                      "infos": "12h",
                      //  "Sport": dropdownSport,
                      "equipe": userData1
                    };

                    Map<String, String> headers = {
                      "Content-Type": "application/json; charset=UTF-8"
                    };

                    http
                        .post(Uri.http(_baseUrl, "/api/stades/"),
                            headers: headers, body: json.encode(userData))
                        .then((http.Response response) async {
                      if (response.statusCode == 201) {
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
                  primary: Color.fromARGB(199, 28, 164, 78),
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
