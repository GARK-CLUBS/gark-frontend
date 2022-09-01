import 'package:flutter/material.dart';
import 'package:garkproject/pages/NetworkHandler/NetworkHandler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

bool crypte = true;

class _SignupState extends State<Signup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _nom = TextEditingController();
  final TextEditingController _prenom = TextEditingController();
  String? errorText;
  String? errorTextEmail;
  bool validate = false;
  bool validateEmail = false;
  String _baseUrl = "10.0.2.2:3000";
  bool circular = false; // -------Design chargement
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        appBar: PreferredSize(
            child: getAppBar(), preferredSize: const Size.fromHeight(50)),
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
                child: Column(children: [
              Column(children: <Widget>[
                Container(
                    height: 740,
                    width: MediaQuery.of(context).size.width - 20,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 15),
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        height: 354,
                        child: Column(children: [
                          Text(
                            "Créer un compte",
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(221, 0, 0, 0),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _prenom,
                            decoration: const InputDecoration(
                              labelText: 'Votre prenom:',
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
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Veuillez renseigner votre prénom.";
                              } else {
                                return null;
                              }
                            },
                          ),
                          TextFormField(
                            controller: _nom,
                            decoration: const InputDecoration(
                              labelText: 'Votre nom:',
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
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Veuillez renseigner votre nom .";
                              } else {
                                return null;
                              }
                            },
                          ),
                          TextFormField(
                            controller: _email,
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
                            validator: (value) {
                              String pattern =
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                              if (value!.isEmpty) {
                                return "Veuillez renseigner votre adresse mail";
                              } else if (!RegExp(pattern).hasMatch(value)) {
                                return "Veuillez renseigner une adresse mail valide";
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            controller: _password,
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
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Veuillez renseigner votre mot de passe.";
                              } else if (value.length < 8) {
                                return "Votre mot de passe doit contenir au moins 8 caractères";
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                              height: 180,
                              width: MediaQuery.of(context).size.width - 40,
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(57, 121, 110, 126),
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 10,
                                        spreadRadius: 3)
                                  ]),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .start, //change here don't //worked
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              AnimatedContainer(
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: 20,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors
                                                            .grey.shade400),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)),
                                                child: Center(
                                                    child: Icon(Icons.check,
                                                        color: Colors.white,
                                                        size: 15)),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "Plus de 8 caractéres ",
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color.fromARGB(
                                                      255, 176, 176, 176),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              AnimatedContainer(
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: 20,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors
                                                            .grey.shade400),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)),
                                                child: Center(
                                                    child: Icon(Icons.check,
                                                        color: Colors.white,
                                                        size: 15)),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "Au moins une majuscule",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color.fromARGB(
                                                      255, 176, 176, 176),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              AnimatedContainer(
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: 20,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors
                                                            .grey.shade400),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)),
                                                child: Center(
                                                    child: Icon(Icons.check,
                                                        color: Colors.white,
                                                        size: 15)),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "Au moins une minuscule",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color.fromARGB(
                                                      255, 176, 176, 176),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              AnimatedContainer(
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: 20,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors
                                                            .grey.shade400),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)),
                                                child: Center(
                                                    child: Icon(Icons.check,
                                                        color: Colors.white,
                                                        size: 15)),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "Un caractère spécial",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color.fromARGB(
                                                      255, 176, 176, 176),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              AnimatedContainer(
                                                duration:
                                                    Duration(milliseconds: 500),
                                                width: 20,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors
                                                            .grey.shade400),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)),
                                                child: Center(
                                                    child: Icon(Icons.check,
                                                        color: Colors.white,
                                                        size: 15)),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "Un chiffre",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color.fromARGB(
                                                      255, 176, 176, 176),
                                                ),
                                              )
                                            ],
                                          ),
                                        ]),
                                    SizedBox(
                                      width: 105,
                                      height: 10,
                                    ),
                                    IconTheme(
                                      data:const   IconThemeData(
                                          color: Color.fromARGB(
                                              255, 154, 154, 154)),
                                      child: Icon(Icons.info_outline),
                                    ),
                                  ])),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: 250,
                            height: 45, // <-- Your width
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  //   _keyForm.currentState!.save();
                                  Map<String, dynamic> userData = {
                                    "firstName": _nom.text,
                                    "lastName": _prenom.text,
                                    "email": _email.text,
                                    "password": _password.text,
                                  };

                                  Map<String, String> headers = {
                                    "Content-Type":
                                        "application/json; charset=UTF-8"
                                  };

                                  http
                                      .post(
                                          Uri.http(
                                              _baseUrl, "/api/participants/"),
                                          headers: headers,
                                          body: json.encode(userData))
                                      .then((http.Response response) async {
                                    if (response.statusCode == 201) {
                                      // Map<String, dynamic> userFromServer =
                                      //     json.decode(response.body);

                                      Navigator.pushReplacementNamed(
                                          context, "/login");
                                      // print(userFromServer["token"]);
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
                                "Créer un compte",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "En validant,vous acceptez les conditions générales d'utilisation et notre politique de confidentialité des données , Gark s'engage a protéger vos données personnelles",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13,
                              color: Color.fromARGB(255, 159, 159, 159),
                              fontWeight: FontWeight.w400,
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

  checkEmail() async {
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    if (_email.text.isEmpty) {
      setState(() {
        circular = false;
        validateEmail = false;
        errorTextEmail = "Veuillez renseigner votre adresse mail";
      });
    } else if (!RegExp(pattern).hasMatch(_email.text)) {
      return "Veuillez renseigner une adresse mail valide";
    } else {
      var response =
          await NetworkHandler().get("/user/checkEmail/${_email.text}");
      if (response['Status']) {
        setState(() {
          validateEmail = false;
          errorTextEmail = "Cette adresse mail a déjà été utilisée";
        });
      } else {
        setState(() {
          validateEmail = true;
        });
      }
    }
  }
}
