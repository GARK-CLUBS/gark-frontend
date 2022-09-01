import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UpdateMembre extends StatefulWidget {
  const UpdateMembre({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<UpdateMembre> createState() => _UpdateMembreState();
}

class _UpdateMembreState extends State<UpdateMembre>
    with TickerProviderStateMixin {
  GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  DateTime date = DateTime.now();

  final TextEditingController _nom = TextEditingController();
  final TextEditingController _prenom = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _taille = TextEditingController();
  final TextEditingController _poid = TextEditingController();
  final TextEditingController _admin = TextEditingController();
  final TextEditingController _telephone = TextEditingController();
  final TextEditingController _nummaillot = TextEditingController();
  final TextEditingController birthInput = TextEditingController();
  final TextEditingController datearriveInput = TextEditingController();
  String? dropdownRole;
  String? dropdownRolee;
  String? dropdownPoste;
  bool _isEnable = false;
  bool _addparent = false;
  String _baseUrl = "10.0.2.2:3000";

  // List of items in our dropdown menu
  var itemsRole = [
    'Joueur',
    'Parent',
    'Coach',
    'Staff',
  ];
  var itemsRolee = [
    'Joueur',
    'Parent',
    'Coach',
    'Staff',
  ];
  var itemsPoste = [
    'no idea',
    'no idea1',
  ];
  late Future<bool> fetchedDocs;

  Future<bool> fetchDocs() async {
    Map<String, String> headers = {
      "Content-Type": "application/json; charset=UTF-8",
    };
    http.Response response = await http.get(
        Uri.parse("http://10.0.2.2:3000/api/membres/" + '${widget.id}'),
        headers: headers);
  
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      _nom.text = data["nom"];
      _prenom.text = data["prenom"];
      _email.text = data["email"];
      _taille.text = data["taille"].toString();
      _poid.text = data["poids"].toString();
      _admin.text = data["admin"].toString();
      _telephone.text = data["numTel"].toString();
      _nummaillot.text = data["numMaillot"].toString();
      birthInput.text = data["dateNaissance"];
      datearriveInput.text = data["anneeAriv"];
      dropdownRole = data["role"];
      dropdownPoste = data["poste"];
    }


    return true;
  }

  @override
  void initState() {
    fetchedDocs = fetchDocs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 2, vsync: this);
    int activeTabIndex = 2;

    @override
    void initState() {
      super.initState();
      _tabController = TabController(
        length: 2,
        initialIndex: 2,
        vsync: this,
      );
    }

    @override
    void dispose() {
      _tabController.dispose();
      super.dispose();
    }

    return Scaffold(
        appBar: PreferredSize(
            child: getAppBar(), preferredSize: const Size.fromHeight(50)),
        body: Form(
            key: _keyForm,
            child:SingleChildScrollView(
            child: Column(children: [
          Column(children: <Widget>[
            Container(
                child: Stack(children: <Widget>[
              Container(
                height: 160, // change it to 140 idha nheb nrejaaha kima kenet
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 2, 0, 50),
                ),
              ),
              Stack(
                children: [
                  Center(
                    child: Material(
                      color: Color.fromARGB(255, 145, 195, 236),
                      elevation: 8,
                      shape: CircleBorder(),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: InkWell(
                        splashColor: Colors.black26,
                        onTap: () {},
                        child: Ink.image(
                          image: NetworkImage(
                              'https://sportbusiness.club/wp-content/uploads/2020/05/Football-Club-FC-Barcelone-1-678x381.jpg'),
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0.0,
                    right: 150.0,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Color.fromARGB(255, 2, 0, 50),
                      child: IconButton(
                        icon: Icon(
                          Icons.camera_alt,
                          color: Color.fromARGB(255, 249, 249, 249),
                        ),
                        onPressed: () {
                          print("saved image");
                        },
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 90,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Slim Ayadi",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 140,
                ),
                child: Align(
                  child: Container(
                      height: 23,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 2, 0, 50),
                      ),
                      alignment: Alignment.center,
                      child: ElevatedButton(
                          child: Text("Disponible",
                              style: TextStyle(fontSize: 16)),
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromARGB(255, 255, 255, 255)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromARGB(255, 38, 255, 0)),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      side: BorderSide(
                                          color: Color.fromARGB(
                                              255, 36, 240, 0))))),
                          onPressed: () => print("haka caava ? "))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 120,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Coach",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ])),
          ]),
          Container(
            height: 60, // change it to 140 idha nheb nrejaaha kima kenet
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 2, 0, 50),
            ),
            child: IgnorePointer(
              ignoring: false,
              child: TabBar(
                  controller: _tabController,
                  labelColor: Color.fromARGB(255, 255, 255, 255),
                  tabs: [
                    Tab(
                      child: Container(
                          width: 100,
                          height: 36,
                          decoration: activeTabIndex == 0
                              ? BoxDecoration(
                                  border: Border.all(
                                      color: Color.fromARGB(255, 73, 243, 0),
                                      width: 12),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16)),
                                )
                              : null,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(8, 4, 8, 0),
                            child: Center(
                                child: Text("Informations",
                                    style: TextStyle(
                                        color: Color.fromARGB(
                                            255, 255, 255, 255)))),
                          )),
                    ),
                    Tab(
                      child: Container(
                          width: 100,
                          height: 36,
                          decoration: activeTabIndex == 0
                              ? BoxDecoration(
                                  border: Border.all(
                                      color: Color.fromARGB(255, 73, 243, 0),
                                      width: 12),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16)),
                                )
                              : null,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(8, 4, 8, 0),
                            child: Center(
                                child: Text("Parents",
                                    style: TextStyle(
                                        color: Color.fromARGB(
                                            255, 255, 255, 255)))),
                          )),
                    ),
                  ]),
            ),
          ),
          Container(
            width: double.maxFinite,
            height: 500,
            child: TabBarView(controller: _tabController, children: [
              // to stop list view from infinity looop
              // all you have to do is to add item count =1
              ListView.builder(
                  itemCount: 1,
                  itemBuilder: (_, index) {
                    return Container(
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        child: Column(children: [
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Align(
                                alignment: Alignment(-1, 0),
                                child: Text(
                                  "Infos générales",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Spacer(),
                              IconButton(
                                  icon: const Icon(Icons.edit),
                                  color:
                                      const Color.fromARGB(255, 183, 249, 182),
                                  onPressed: () {
                                    setState(() {
                                      _isEnable = true;
                                    });
                                  })
                            ],
                          ),
                          TextFormField(
                            controller: _nom,
                            decoration: const InputDecoration(
                              labelText: 'Nom :',
                              labelStyle: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 17,
                                  fontFamily: 'AvenirLight'),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Veuillez renseigner votre nom .";
                              } else {
                                return null;
                              }
                            },
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 17,
                                fontFamily: 'AvenirLight'),
                          ),
                          TextFormField(
                            controller: _prenom,
                            decoration: const InputDecoration(
                              labelText: 'Prenom :',
                              labelStyle: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 17,
                                  fontFamily: 'AvenirLight'),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              ),
                            ),
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 17,
                                fontFamily: 'AvenirLight'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Veuillez renseigner votre Prenom .";
                              } else {
                                return null;
                              }
                            },
                          ),
                          TextFormField(
                            controller: _email,
                            decoration: const InputDecoration(
                              labelText: 'email :',
                              labelStyle: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 17,
                                  fontFamily: 'AvenirLight'),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              ),
                            ),
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 17,
                                fontFamily: 'AvenirLight'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Veuillez renseigner votre email .";
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          DropdownButtonFormField<String>(
                            value: dropdownRole,
                            hint: Text("Type of Sport"),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownRole = newValue;
                              });
                            },
                            validator: (String? value) {
                              if (value?.isEmpty ?? true) {
                                return 'Please enter a valid type of sport';
                              }
                            },
                            items: itemsRole
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          TextFormField(
                            controller: birthInput,
                            decoration: InputDecoration(
                              labelText: "Choisissez votre date de naissance",
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              ),
                            ),
                            readOnly: true,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                              );
                              if (pickedDate != null) {
                                date = pickedDate;
                                String formattedDate =
                                    DateFormat('dd/MM/yyyy').format(pickedDate);
                                // _naissance = formattedDate;
                                setState(() {
                                  birthInput.text = formattedDate;
                                });
                                print(birthInput.text);
                              } else {
                                print("Pas de date ");
                              }
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Veuillez renseigner votre  date de naissance .";
                              } else {
                                return null;
                              }
                            },
                          ),
                          TextFormField(
                            controller: datearriveInput,
                            decoration: InputDecoration(
                              labelText: "Choisissez votre date d'arrive ",
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              ),
                            ),
                            readOnly: true,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                              );
                              if (pickedDate != null) {
                                date = pickedDate;
                                String formattedDate =
                                    DateFormat('dd/MM/yyyy').format(pickedDate);
                                // _naissance = formattedDate;
                                setState(() {
                                  datearriveInput.text = formattedDate;
                                });
                                print(datearriveInput.text);
                              } else {
                                print("Pas de date ");
                              }
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Veuillez renseigner votre date d'arrive .";
                              } else {
                                return null;
                              }
                            },
                          ),
                          TextFormField(
                            controller: _admin,
                            decoration: const InputDecoration(
                              labelText: 'admin:',
                              labelStyle: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 17,
                                  fontFamily: 'AvenirLight'),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              ),
                            ),
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 17,
                                fontFamily: 'AvenirLight'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Veuillez renseigner votre admin .";
                              } else {
                                return null;
                              }
                            },
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: _telephone,
                            decoration: const InputDecoration(
                              labelText: 'Telephone:',
                              labelStyle: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 17,
                                  fontFamily: 'AvenirLight'),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              ),
                            ),
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 17,
                                fontFamily: 'AvenirLight'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Veuillez renseigner votre Telephone .";
                              } else {
                                return null;
                              }
                            },
                          ),
                          DropdownButtonFormField<String>(
                            value: dropdownPoste,
                            hint: Text("Poste"),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownPoste = newValue;
                              });
                            },
                            validator: (String? value) {
                              if (value?.isEmpty ?? true) {
                                return 'Please enter a valid Poste';
                              }
                            },
                            items: itemsPoste
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: _taille,
                            decoration: const InputDecoration(
                              labelText: 'Taille (cm):',
                              labelStyle: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 17,
                                  fontFamily: 'AvenirLight'),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Veuillez renseigner votre Taille .";
                              } else {
                                return null;
                              }
                            },
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: _poid,
                            decoration: const InputDecoration(
                              labelText: 'Poids (kg):',
                              labelStyle: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 17,
                                  fontFamily: 'AvenirLight'),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Veuillez renseigner votre Poids .";
                              } else {
                                return null;
                              }
                            },
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: _nummaillot,
                            decoration: const InputDecoration(
                              labelText: 'Numéro de maillot:',
                              labelStyle: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 17,
                                  fontFamily: 'AvenirLight'),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Veuillez renseigner votre Numéro de maillot.";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ]));
                  }),
              //2222222222222222
              _addparent
                  ? ListView.builder(
                      itemCount: 1,
                      itemBuilder: (_, index) {
                        return Container(
                            padding: const EdgeInsets.only(
                              left: 20,
                              right: 20,
                            ),
                            child: Column(children: [
                              SizedBox(
                                height: 20,
                              ),
                              Align(
                                alignment: Alignment(-1, 0),
                                child: Text(
                                  "Parents",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Nom :',
                                  labelStyle: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 17,
                                      fontFamily: 'AvenirLight'),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                ),
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 17,
                                    fontFamily: 'AvenirLight'),
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Prenom :',
                                  labelStyle: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 17,
                                      fontFamily: 'AvenirLight'),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                ),
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 17,
                                    fontFamily: 'AvenirLight'),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        width: 1.0,
                                        color:
                                            Color.fromARGB(255, 158, 158, 158)),
                                  ),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    hint: Text('Role *',
                                        style: const TextStyle(
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 17)),
                                    icon: const Icon(Icons.arrow_drop_down),
                                    isExpanded: true,
                                    elevation: 20,
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                    onChanged: (String? newValue) {
                                      setState(() => dropdownRolee = newValue!);
                                    },
                                    items: itemsRolee
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
                              TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'email:',
                                  labelStyle: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 17,
                                      fontFamily: 'AvenirLight'),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                ),
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 17,
                                    fontFamily: 'AvenirLight'),
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Telephone:',
                                  labelStyle: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 17,
                                      fontFamily: 'AvenirLight'),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 17,
                                    fontFamily: 'AvenirLight'),
                              ),
                            ]));
                      })
                  : ListView.builder(
                      itemCount: 1,
                      itemBuilder: (_, index) {
                        return Container(
                            padding: const EdgeInsets.only(
                              left: 20,
                              right: 20,
                            ),
                            child: Column(children: [
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(0),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            "https://cdn-icons-png.flaticon.com/512/1054/1054868.png"),
                                        fit: BoxFit.cover)),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Aucun parent attribué",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Les parents peuvent répondre aux convocations et communiquer avec le reste de l'equipe",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 174, 174, 174),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              ElevatedButton(
                                  child: Text('Ajouter un parent'),
                                  style: ElevatedButton.styleFrom(
                                    primary: Color.fromARGB(
                                        255, 14, 205, 0), // Background color
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _addparent = true;
                                      // _tabController.animateTo(2);
                                      // DefaultTabController.of(context)?.animateTo(1);
                                    });
                                  }),
                            ]));
                      })
            ]),
          ),
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
      title: Row(children: <Widget>[
        Spacer(),
        Text(
          'Membres',
          textAlign: TextAlign.center,
          style: TextStyle(),
        ),
        Spacer(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.save_as_outlined),
              onPressed: () {
                if (_keyForm.currentState!.validate()) {
                  //   _keyForm.currentState!.save();
                  Map<String, dynamic> userData1 = {
                    "_id": '${widget.id}', // change equipe id
                  };

                  Map<String, dynamic> userData = {
                    "nom": _nom.text,
                    "prenom": _prenom.text,
                    "role": dropdownRole,
                    "admin": _admin.text,
                    "email": _email.text,
                    "numTel": _telephone.text,
                    "poste": dropdownPoste,
                    "dateNaissance": birthInput.text,
                    "anneeAriv": datearriveInput.text,
                    "taille": _taille.text,
                    "poids": _poid.text,
                    "numMaillot": _nummaillot.text,
                    "img": "hahah",
                    "Equipe": userData1
                  };

                  Map<String, String> headers = {
                    "Content-Type": "application/json; charset=UTF-8"
                  };

                  http
                      .put(Uri.http(_baseUrl, "/api/membres/" + '${widget.id}'),
                          headers: headers, body: json.encode(userData))
                      .then((http.Response response) async {
                    if (response.statusCode == 200) {
                      Navigator.pop(context);

                      // print(userFromServer["token"]);
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
                }
              },
            )
          ],
        ),
        SizedBox(
          width: 10,
        ),
      ]),
    );
  }
}
