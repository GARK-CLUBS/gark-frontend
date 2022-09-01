import 'package:dynamic_icons/dynamic_icons.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:garkproject/pages/Calendrier/Tache/Tache.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddTache extends StatefulWidget {
  const AddTache({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  State<AddTache> createState() => _AddTacheState();
}

final TextEditingController _nom = TextEditingController();
int? selected;
String _baseUrl = "10.0.2.2:3000";
GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
int? nameicon;

class _AddTacheState extends State<AddTache> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 235, 235, 235),
      appBar:
          PreferredSize(child: getAppBar(), preferredSize: Size.fromHeight(50)),
      body: getBody(),
    );
  }

  Widget getBody() {
    return Form(
      key: _keyForm,
      child: Stack(children: <Widget>[
        SingleChildScrollView(
            child: Column(children: [
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _nom,
              decoration: const InputDecoration(
                hintText: 'Nom  *',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 0, 0, 0), width: 1.0),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Veuillez renseigner le nom ";
                } else {
                  return null;
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment(-0.9, -0.1),
              child: Text(
                "CHOISIR UNE ICONE",
                style: TextStyle(
                    fontSize: 13,
                    color: Color.fromARGB(255, 132, 132, 132),
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Container(height: 750, child: gridv()),
        ])),
        Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                height: 50,
                color: Color.fromARGB(255, 252, 252, 252),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Column(children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_keyForm.currentState!.validate()) {
                            // print("aa");
                            // print(widget.id);
                            Map<String, dynamic> userData1 = {
                              "_id": widget.id,
                            };
                            Map<String, dynamic> userData = {
                              "typechoix": _nom.text,
                              "nomIcon": nameicon,
                              "evenement": userData1
                            };

                            Map<String, String> headers = {
                              "Content-Type": "application/json; charset=UTF-8"
                            };

                            http
                                .post(Uri.http(_baseUrl, "/api/types/"),
                                    headers: headers,
                                    body: json.encode(userData))
                                .then((http.Response response) async {
                              // print(userData);
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
                          primary: Color.fromARGB(199, 26, 209, 93),
                        ),

                        child: Text(
                          "Editer",
                          style: TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w400,
                          ),
                        ), //label text,
                      ),
                    ),
                  ])
                ])))
      ]),
    );
  }

  Widget gridv() {
    final List<MenuData> menu = [
      MenuData(0xe5f2, 'Menu 1'),
      MenuData(0xe383, 'Menu 2'),
      MenuData(0xf05ae, 'Menu 3'),
      MenuData(0xe398, 'Menu 4'),
      MenuData(0xf04c8, 'Menu 5'),
      MenuData(0xe1d6, 'Menu 6'),
      MenuData(0xe3c2, 'Menu 7'),
      MenuData(0xe5e3, 'Menu 8'),
      MenuData(0xe22d, 'Menu 9'),
      MenuData(0xf1be, 'Menu 9'),
      MenuData(0xec90, 'Menu 9'),
      MenuData(0xf029c, 'Menu 9'),
      MenuData(0xf3c6, 'Menu 9'),
      MenuData(0xf3c7, 'Menu 9'),
      MenuData(0xf3c8, 'Menu 9'),
      MenuData(0xf3d7, 'Menu 9'),
      MenuData(0xed16, 'Menu 9'),
      MenuData(0xf01a, 'Menu 9'),
      MenuData(0xe645, 'Menu 9'),
      MenuData(0xf1fb, 'Menu 9'),
      MenuData(0xeeb8, 'Menu 9'),
      MenuData(0xeea2, 'Menu 9'),
      MenuData(0xf3c9, 'Menu 9'),
      MenuData(0xf3cb, 'Menu 9'),
      MenuData(0xf01c8, 'Menu 9'),
      MenuData(0xe11a, 'Menu 9'),
      MenuData(0xf097, 'Menu 9'),
    ];
    return Container(
        child: Scrollbar(
      thickness: 3,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              GridView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: menu.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1,
                    crossAxisCount: 4,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0),
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 0.2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: index == selected
                          ? BorderSide(
                              color: Color.fromARGB(255, 91, 188, 47)
                                  .withOpacity(0.60),
                              width: 1,
                            )
                          : new BorderSide(
                              width: 0,
                              color: Color.fromARGB(255, 255, 255, 255)
                                  .withOpacity(0.60),
                            ),
                    ),
                    child: InkWell(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(IconData(menu[index].icon,
                              fontFamily: 'MaterialIcons'))

                          // Icon(
                          //   menu[index].icon,
                          //   size: 30,
                          // ),
                        ],
                      ),
                      onTap: () => {
                        setState(() {
                          selected = index;
                          nameicon = menu[index].icon;
                        })
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Widget getAppBar() {
    return AppBar(
        elevation: 10,
        backgroundColor: const Color.fromARGB(255, 2, 0, 50),
        leading: IconButton(
          icon:
              Icon(Icons.arrow_back, color: Color.fromARGB(255, 255, 255, 255)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(children: <Widget>[
          Spacer(),
          Text(
            'Ajouter une tache',
            textAlign: TextAlign.center,
            style: TextStyle(),
          ),
          Spacer(flex: 2),
        ]));
  }
}

class MenuData {
  MenuData(this.icon, this.title);
  final int icon;
  final String title;
}
