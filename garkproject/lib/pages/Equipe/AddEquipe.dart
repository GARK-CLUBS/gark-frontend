import 'package:flutter/material.dart';
import 'package:garkproject/pages/Equipe/Equipe.dart';
import 'package:garkproject/pages/Splash/splash_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AddEquipe extends StatefulWidget {
  const AddEquipe({Key? key}) : super(key: key);

  @override
  State<AddEquipe> createState() => _AddEquipeState();
}

SharedPreferences? prefs;
String? _clubid;
String _clubName = "";
late Future<bool> fetchedDocs;
var data = [];

class _AddEquipeState extends State<AddEquipe> {
  Future<bool> fetchDocs() async {
    prefs = await SharedPreferences.getInstance();
    _clubid = prefs!.getString("participantClub");
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8",
    };
    http.Response response = await http.get(
        Uri.parse("http://10.0.2.2:3000/api/clubs/" + _clubid!),
        headers: headers);
    
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
 
      setState(() {
        _clubName = data["nameClub"];
      });
    }

    return true;
  }

  @override
  void initState() {
    fetchedDocs = fetchDocs();

    super.initState();
  }

  GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

  final TextEditingController _nom = TextEditingController();
  final TextEditingController _ville = TextEditingController();

  String _baseUrl = "10.0.2.2:3000";
  String? dropdownSport;
  String? dropdownGenre;
  String? dropdownAge;
  String? dropdownType;
  String? dropdownNiveau;

  // List of items in our dropdown menu
  var itemsSport = [
    'Football',
    'Handball',
    'Basketball',
    'Volley',
  ];
  var itemsGenre = [
    'Masculin',
    'Feminin',
    'Mixte',
  ];
  var itemsAge = [
    'Adultes',
    'U5',
    'U6',
    'U7',
    'U8',
    'U9',
    'U10',
    'U11',
  ];
  var itemsAssociation = [
    'Association',
    'Club',
    'Entreprise',
    'Groupeami',
    'ScolaireUniversitaire',
  ];
  var itemsNiveau = [
    'Competition',
    'Loisir',
    'Match',
  ];

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
          _clubName,
          style: TextStyle(),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    // -------masque tel
    return Scaffold(
        appBar: PreferredSize(
            child: getAppBar(), preferredSize: const Size.fromHeight(50)),
        body: Form(
            key: _keyForm,
            child: SingleChildScrollView(
                child: Column(children: [
              Column(children: <Widget>[
                Container(
                  child: Stack(children: <Widget>[
                    // Container(
                    //   height: 80, // change it to 140 idha nheb nrejaaha kima kenet
                    //   decoration: const BoxDecoration(
                    //       color: Color.fromARGB(255, 2, 0, 50),
                    //       borderRadius: BorderRadius.only(
                    //         bottomLeft: Radius.circular(36),
                    //         bottomRight: Radius.circular(36),
                    //       )),
                    // ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 40,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      // decoration: BoxDecoration(
                      //     color: Colors.white,
                      //     borderRadius: BorderRadius.circular(15),
                      //     boxShadow: [
                      //       BoxShadow(
                      //           color: Colors.black.withOpacity(0.3),
                      //           blurRadius: 15,
                      //           spreadRadius: 5)
                      //     ]),
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 30),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(children: [
                          Text(
                            "Créer votre équipe ",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 2, 0, 50),
                            ),
                          ),
                          // a blue line
                          /*  Container(
                        height: 5,
                        width: 190,
                        color: Color.fromARGB(255, 2, 0, 50),
                      ),*/
                          SizedBox(height: 20),
                          TextFormField(
                            controller: _nom,
                            decoration: const InputDecoration(
                              hintText: 'Nom de votre equipe ? *',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    width: 1.0),
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
                            controller: _ville,
                            decoration: const InputDecoration(
                              hintText: 'Ville *',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    width: 1.0),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Veuillez renseigner votre ville .";
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          DropdownButtonFormField<String>(
                            value: dropdownSport,
                            hint: Text("Type of Sport"),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownSport = newValue;
                              });
                            },
                            validator: (String? value) {
                              if (value?.isEmpty ?? true) {
                                return 'Please enter a valid type of sport';
                              }
                            },
                            items: itemsSport
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),

                          const SizedBox(
                            height: 20,
                          ),
                          DropdownButtonFormField<String>(
                            value: dropdownGenre,
                            hint: Text("Genre (masculin/féminin)*"),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownGenre = newValue;
                              });
                            },
                            validator: (String? value) {
                              if (value?.isEmpty ?? true) {
                                return 'Please enter a valid type of Genre  *';
                              }
                            },
                            items: itemsGenre
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),

                          const SizedBox(
                            height: 20,
                          ),
                          DropdownButtonFormField<String>(
                            value: dropdownAge,
                            hint: Text("Catégorie d age *"),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownAge = newValue;
                              });
                            },
                            validator: (String? value) {
                              if (value?.isEmpty ?? true) {
                                return 'Please enter a valid type of Catégorie d age   *';
                              }
                            },
                            items: itemsAge
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),

                          const SizedBox(
                            height: 20,
                          ),
                          DropdownButtonFormField<String>(
                            value: dropdownType,
                            hint: Text("Type d équipe *"),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownType = newValue;
                              });
                            },
                            validator: (String? value) {
                              if (value?.isEmpty ?? true) {
                                return 'Please enter a valid type of Type d équipe*';
                              }
                            },
                            items: itemsAssociation
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),

                          const SizedBox(
                            height: 20,
                          ),
                          DropdownButtonFormField<String>(
                            value: dropdownNiveau,
                            hint: Text("Niveau de pratique*"),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownNiveau = newValue;
                              });
                            },
                            validator: (String? value) {
                              if (value?.isEmpty ?? true) {
                                return 'Please enter a valid type of Niveau de pratique*';
                              }
                            },
                            items: itemsNiveau
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),

                          SizedBox(
                            height: 20,
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
                                       Map<String, dynamic> userData1 = {
                                        "_id": _clubid,
                                       };
                                    Map<String, dynamic> userData = {
                                      "Name": _nom.text,
                                      "Genre": dropdownGenre,
                                      "CategorieAge": dropdownAge,
                                      "Type": dropdownType,
                                      "Niveau": dropdownNiveau,
                                      "Ville": _ville.text,
                                      "Sport": dropdownSport,
                                      "club":  userData1  
                                      
                                    };

                                    Map<String, String> headers = {
                                      "Content-Type":
                                          "application/json; charset=UTF-8"
                                    };

                                    http
                                        .post(
                                            Uri.http(_baseUrl, "/api/equipes/"),
                                            headers: headers,
                                            body: json.encode(userData))
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
                                  primary: Color.fromARGB(200, 0, 249, 93),
                                ),
                                child: Text(
                                  "Créer une équipe ",
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
                      ),
                    ),
                  ]),
                )
              ])
            ]))));
  }
}
