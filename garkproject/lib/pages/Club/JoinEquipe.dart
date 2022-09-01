import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:garkproject/main.dart';

class JoinEquipe extends StatefulWidget {
  const JoinEquipe({Key? key}) : super(key: key);

  @override
  State<JoinEquipe> createState() => _JoinEquipeState();
}

class _JoinEquipeState extends State<JoinEquipe> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    // -------masque tel
    return Scaffold(
        appBar: PreferredSize(
            child: getAppBar(), preferredSize: const Size.fromHeight(50)),
        body: SingleChildScrollView(
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
                  height: 600,
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
                      height: 354,
                      child: Column(children: [
                        Text(
                          "Rejoindre une équipe ",
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
                          "Pour rejoindre une équipe, il vous faut le code de l'equipe qui vous a été transmis par le coach ",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 129, 129, 129),
                          ),
                          textAlign: TextAlign.center,
                        )
                      ]))),

              Container(
                  height: 400,
                  width: MediaQuery.of(context).size.width - 10,
                  margin: EdgeInsets.symmetric(horizontal: 0, vertical: 100),
                  child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 30),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: 354,
                      child: Column(children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.key),
                            labelText: 'Le code de votre équipe:',
                            labelStyle: TextStyle(
                                color: Color.fromARGB(221, 146, 146, 146),
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
                              color: Color.fromARGB(221, 255, 255, 255),
                              fontSize: 17,
                              fontFamily: 'AvenirLight'),
                        ),
                      ]))),
            ])),
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
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (c) => HomeScreen()));
                      },

                      style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 14, 178,
                              120) //elevated btton background color
                          ),

                      child: Text(
                        "Rejoindre",
                        style: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.w400,
                        ),
                      ), //label text,
                    ),
                  ),
                ),
              ),
            ),
          ])
        ])));
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
