import 'package:flutter/material.dart';
import 'package:garkproject/main.dart';
import 'package:garkproject/pages/Auth/ForgetPass.dart';
import 'package:garkproject/pages/Club/OnBoardingClub.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

bool crypte = true;

class _LoginState extends State<Login> {
  String? _email;
  String? _password;
  GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

  final TextEditingController _email2 = TextEditingController();
  final TextEditingController _password2 = TextEditingController();

  String _baseUrl = "10.0.2.2:3000";

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
                child: Column(children: [
              Column(children: <Widget>[
                Container(
                    height: 680,
                    width: MediaQuery.of(context).size.width - 10,
                    margin: EdgeInsets.symmetric(horizontal: 0),
                    child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 30),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 354,
                        child: Column(children: [
                          Text(
                            "Connexion",
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 2, 0, 50),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            controller: _email2,
                            decoration: const InputDecoration(
                              labelText: 'Votre email:',
                              labelStyle: TextStyle(
                                  color: Color.fromARGB(221, 190, 190, 190),
                                  fontSize: 17,
                                  fontFamily: 'AvenirLight'),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(221, 190, 190, 190),
                                      width: 2.0)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      width: 2.0)),
                            ),
                            style: TextStyle(
                                color: Color.fromARGB(221, 0, 0, 0),
                                fontSize: 17,
                                fontFamily: 'AvenirLight'),
                            onSaved: (String? value) {
                              _email = value!;
                            },
                            validator: (String? value) {
                              String pattern =
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                              if (value == null || value.isEmpty) {
                                return "L'adresse email ne doit pas etre vide";
                              } else if (!RegExp(pattern).hasMatch(value)) {
                                return "L'adresse email est incorrecte";
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            controller: _password2,
                            obscureText: crypte,
                            decoration: InputDecoration(
                              labelText: 'Votre mot de passe:',
                              labelStyle: TextStyle(
                                  color: Color.fromARGB(221, 190, 190, 190),
                                  fontSize: 17,
                                  fontFamily: 'AvenirLight'),
                              suffixIcon: IconButton(
                                icon: Icon(crypte
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                color: Color.fromARGB(221, 190, 190, 190),
                                onPressed: () {
                                  setState(() {
                                    crypte = !crypte;
                                  });
                                },
                              ),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(221, 190, 190, 190),
                                      width: 2.0)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      width: 2.0)),
                            ),
                            style: TextStyle(
                                color: Color.fromARGB(221, 0, 0, 0),
                                fontSize: 17,
                                fontFamily: 'AvenirLight'),
                            onSaved: (String? value) {
                              _password = value!;
                            },
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Le mot de passe ne doit pas etre vide";
                              } else if (value.length < 2) {
                                return "Le mot de passe doit avoir au moins 4 caractères";
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          new GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (c) => ForgetPass()));
                            },
                            child: new Text(
                              "Mot de passe oublié ?",
                              style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(200, 0, 249, 93),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          SizedBox(
                            width: 250,
                            height: 45, // <-- Your width
                            child: Container(
                              // padding: EdgeInsets.only(top: 30),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_keyForm.currentState!.validate()) {
                                    //   _keyForm.currentState!.save();
                                    Map<String, dynamic> userData = {
                                      "email": _email2.text,
                                      "password": _password2.text
                                    };
                                    Map<String, String> headers = {
                                      "Content-Type":
                                          "application/json; charset=UTF-8"
                                    };

                                    http
                                        .post(
                                            Uri.http(_baseUrl,
                                                "/api/participants/login"),
                                            headers: headers,
                                            body: json.encode(userData))
                                        .then((http.Response response) async {
                                          print(userData);
                                      if (response.statusCode == 200) {
                                        Map<String, dynamic> userFromServer =
                                            json.decode(response.body);
                                        print(response.body);
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        prefs.setString("email", _email2.text);
                                        prefs.setString(
                                            "token", userFromServer["token"]);
                                        Map<String, String> headerss = {
                                          "Content-Type":
                                              "application/json; charset=UTF-8",
                                        };
                                        // si il a un  club
                                        if (userFromServer["participantClub"] !=
                                            null) {
                                          http.Response responsee = await http.get(
                                              Uri.parse(
                                                  "http://10.0.2.2:3000/api/clubs/" +
                                                      userFromServer[
                                                          "participantClub"]!),
                                              headers: headerss);
                                          //print(response.body);
                                          //print(response.statusCode);
                                          if (responsee.statusCode == 200) {
                                            var dataa =
                                                json.decode(responsee.body);
                                            prefs.setString(
                                                "nameClub", dataa["nameClub"]);
                                            prefs.setString(
                                                "participantClub",
                                                userFromServer[
                                                    "participantClub"]);
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (c) =>
                                                        HomeScreen()));
                                          }
                                        } else if (userFromServer[
                                                "participantClub"] ==
                                            null) {
                                          prefs.setString("nameClub", " ");
                                          prefs.setString("participantId",
                                              userFromServer["participantId"]);
                                          print("user from server data");
                                          print(userFromServer);
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (c) =>
                                                      OnBoardingClub()));
                                          print(userFromServer["token"]);
                                        }
                                      } else if (response.statusCode == 401) {
                                        print("in 401");

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
                                  "Se connecter",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ), //label text,
                              ),
                            ),
                          ),
                        ])))
              ])
            ]))));
  }

  Widget getAppBar() {
    return AppBar(
      elevation: 10,
      backgroundColor: const Color.fromARGB(255, 2, 0, 50),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Color.fromARGB(255, 255, 255, 255)),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }
}
