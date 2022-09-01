import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:garkproject/main.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AddClub extends StatefulWidget {
  const AddClub({Key? key}) : super(key: key);

  @override
  State<AddClub> createState() => _AddClubState();
}

class _AddClubState extends State<AddClub> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nom = TextEditingController();
  final TextEditingController _nbmembre = TextEditingController();
  final TextEditingController _nbequipe = TextEditingController();
  final TextEditingController _telephone = TextEditingController();
  String? dropdownSport;
  var itemsSport = [
    'Football',
    'Handball',
    'Basketball',
    'Volley',
  ];
  SharedPreferences? prefs;
  String pi = "";
  String _baseUrl = "10.0.2.2:3000";
  File? imageFile;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    // -------masque tel
    return Scaffold(
        appBar: PreferredSize(
            child: getAppBar(), preferredSize: const Size.fromHeight(50)),
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
                child: Column(children: [
              Column(children: <Widget>[
                Container(
                    child: Column(children: <Widget>[
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
                          margin: const EdgeInsets.symmetric(vertical: 35),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(children: [
                            Text(
                              "Créer votre club ",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 2, 0, 50),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Ajoutez les informations de votre club et télécharger votre logo ",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 129, 129, 129),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            imageProfile(),
                            Container(
                                height: 600,
                                width: MediaQuery.of(context).size.width - 10,
                                margin: EdgeInsets.symmetric(horizontal: 0),
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 30),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  height: 354,
                                  child: Column(children: [
                                    TextFormField(
                                      controller: _nom,
                                      decoration: const InputDecoration(
                                        labelText: 'Nom du  club:',
                                        labelStyle: TextStyle(
                                            color: Color.fromARGB(
                                                221, 146, 146, 146),
                                            fontSize: 17,
                                            fontFamily: 'AvenirLight'),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    221, 190, 190, 190),
                                                width: 2.0)),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                                width: 2.0)),
                                      ),
                                      style: TextStyle(
                                          color: Color.fromARGB(221, 0, 0, 0),
                                          fontSize: 17,
                                          fontFamily: 'AvenirLight'),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Veuillez renseigner votre nom du club.";
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    TextFormField(
                                      controller: _nbmembre,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        labelText: 'nombre des membres:',
                                        labelStyle: TextStyle(
                                            color: Color.fromARGB(
                                                221, 146, 146, 146),
                                            fontSize: 17,
                                            fontFamily: 'AvenirLight'),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    221, 190, 190, 190),
                                                width: 2.0)),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                                width: 2.0)),
                                      ),
                                      style: TextStyle(
                                          color: Color.fromARGB(221, 0, 0, 0),
                                          fontSize: 17,
                                          fontFamily: 'AvenirLight'),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Veuillez renseigner le nombre des membres .";
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    TextFormField(
                                      controller: _nbequipe,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        labelText: 'nombre des equipes:',
                                        labelStyle: TextStyle(
                                            color: Color.fromARGB(
                                                221, 146, 146, 146),
                                            fontSize: 17,
                                            fontFamily: 'AvenirLight'),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    221, 190, 190, 190),
                                                width: 2.0)),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                                width: 2.0)),
                                      ),
                                      style: TextStyle(
                                          color: Color.fromARGB(221, 0, 0, 0),
                                          fontSize: 17,
                                          fontFamily: 'AvenirLight'),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Veuillez renseigner le nombre des equipes .";
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    TextFormField(
                                      controller: _telephone,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        labelText: 'Telephone:',
                                        labelStyle: TextStyle(
                                            color: Color.fromARGB(
                                                221, 146, 146, 146),
                                            fontSize: 17,
                                            fontFamily: 'AvenirLight'),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    221, 190, 190, 190),
                                                width: 2.0)),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                                width: 2.0)),
                                      ),
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 17,
                                          fontFamily: 'AvenirLight'),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Veuillez renseigner votre telephone .";
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 4),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                              width: 1.0,
                                              color: Color.fromARGB(
                                                  255, 158, 158, 158)),
                                        ),
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          hint: Text('Sport*'),
                                          value: dropdownSport,
                                          icon:
                                              const Icon(Icons.arrow_drop_down),
                                          isExpanded: true,
                                          elevation: 16,
                                          style: const TextStyle(
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0)),
                                          onChanged: (String? newValue) {
                                            setState(() =>
                                                dropdownSport = newValue!);
                                          },
                                          items: itemsSport
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                        //your other widgets here
                                        child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: SizedBox(
                                        width: 250,
                                        height: 45, // <-- Your width
                                        child: Container(
                                          // padding: EdgeInsets.only(top: 30),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                Map<String, dynamic> userData =
                                                    {
                                                  "nameClub": _nom.text,
                                                  "nbMembre": _nbmembre.text,
                                                  "nbEquipe": _nbequipe.text,
                                                  "sport": dropdownSport,
                                                  "numTel": _telephone.text,
                                                };
                                                Map<String, String> headers = {
                                                  "Content-Type":
                                                      "application/json; charset=UTF-8"
                                                };

                                                http
                                                    .post(
                                                        Uri.http(_baseUrl,
                                                            "/api/clubs/"),
                                                        headers: headers,
                                                        body: json
                                                            .encode(userData))
                                                    .then((http.Response
                                                        response) async {
                                                  if (response.statusCode ==
                                                      201) {
                                                    Map<String, dynamic>
                                                        userFromServer =
                                                        json.decode(
                                                            response.body);
                                                    SharedPreferences prefs =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    prefs.setString(
                                                        "clubname", _nom.text);
// search club from name
                                                    Map<String, String>
                                                        headerss = {
                                                      "Content-Type":
                                                          "application/json; charset=UTF-8",
                                                    };
                                                    http.Response responsee =
                                                        await http.get(
                                                            Uri.parse(
                                                                "http://10.0.2.2:3000/api/clubs/byName/" +
                                                                    _nom.text),
                                                            headers: headerss);
                                                    //print(response.body);
                                                    //print(response.statusCode);
                                                    if (responsee.statusCode ==
                                                        200) {
                                                      var dataa = json.decode(
                                                          responsee.body);
                                                      print(
                                                          "id in add club :) ");
                                                       print(dataa);
                                                      //  print(dataa[0]["_id"]);
                                                      // print(dataa["_id"]);

                                                      // update user
                                                      prefs =
                                                          await SharedPreferences
                                                              .getInstance();
                                                      pi = prefs.getString(
                                                          "participantId")!;
                                                      Map<String, dynamic>
                                                          userData1 = {
                                                        "_id": dataa[0]["_id"],
                                                      };
                                                      Map<String, dynamic>
                                                          userData2 = {
                                                        "club": userData1
                                                      };

                                                      Map<String, String>
                                                          headersss = {
                                                        "Content-Type":
                                                            "application/json; charset=UTF-8"
                                                      };
                                                      http
                                                          .put(
                                                              Uri.http(
                                                                  _baseUrl,
                                                                  "/api/participants/" +
                                                                      pi),
                                                              headers:
                                                                  headersss,
                                                              body: json.encode(
                                                                  userData2))
                                                          .then((http.Response
                                                              responseee) async {
                                                                print("print");
                                                        if (responseee
                                                                .statusCode ==
                                                            200) {
                                                          Navigator.of(context).push(
                                                              MaterialPageRoute(
                                                                  builder: (c) =>
                                                                      HomeScreen()));
                                                          prefs.setString(
                                                              "nameClub",
                                                              _nom.text);
                                                          prefs.setString(
                                                              "participantClub",
                                                              dataa[0]["_id"]);
                                                        }
                                                      });
                                                    }
                                                  } else if (response
                                                          .statusCode ==
                                                      401) {
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext
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
                                                        builder: (BuildContext
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
                                              }
                                            },

                                            style: ElevatedButton.styleFrom(
                                                primary: Color.fromARGB(
                                                    255,
                                                    14,
                                                    178,
                                                    120) //elevated btton background color
                                                ),

                                            child: Text(
                                              "Créer mon club",
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ), //label text,
                                          ),
                                        ),
                                      ),
                                    )),
                                  ]),
                                )),
                          ])))
                ]))
              ])
            ]))));
  }

  Widget imageProfile() {
    return Container(
        child: Center(
            child: Stack(
      children: <Widget>[
        CircleAvatar(
            radius: 50,
            backgroundImage:
                imageFile == null ? const AssetImage("assets/logo.PNG") : null),
        Positioned(
            bottom: 20,
            right: 20,
            child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: ((builder) => bottomsheet()),
                  );
                },
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.teal,
                  size: 28,
                )))
      ],
    )));
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

  void getImage({required ImageSource source}) async {
    final file = await ImagePicker().pickImage(source: source);
    if (file?.path != null) {
      setState(() {
        imageFile = File(file!.path);
        print(imageFile);
      });
    }
  }

  Widget bottomsheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile photo ",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: <Widget>[
              ElevatedButton(
                  onPressed: () => getImage(source: ImageSource.camera),
                  child: Text("Capture Image")),
              ElevatedButton(
                  onPressed: () async => getImage(source: ImageSource.gallery),
                  child: Text("Select image")),
            ],
          )
        ],
      ),
    );
  }
}
