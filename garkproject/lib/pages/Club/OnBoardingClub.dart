import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:garkproject/main.dart';
import 'package:garkproject/pages/Club/AddClub.dart';
import 'package:garkproject/pages/Club/JoinEquipe.dart';

class OnBoardingClub extends StatefulWidget {
  const OnBoardingClub({Key? key}) : super(key: key);

  @override
  State<OnBoardingClub> createState() => _OnBoardingClubState();
}

// redirect tsir fel logiin
class _OnBoardingClubState extends State<OnBoardingClub> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      Column(children: <Widget>[
        Container(
            child: Stack(children: <Widget>[
          Container(
              height: 680,
              width: MediaQuery.of(context).size.width - 40,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 150),
              child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 30),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 354,
                  child: Column(children: [
                    Image.asset(
                      "assets/GARK-LOGO icon + text.png",
                      height: (165),
                      width: (235),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Text(
                      "Bienvenue ! ",
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Vous souhaitez : ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                       SizedBox(
                      height: 30,
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
   Navigator.of(context).push(MaterialPageRoute(
                                  builder: (c) => AddClub()));

                                  },

                                  style: ElevatedButton.styleFrom(
                                      primary: Color.fromARGB(255, 14, 178,
                                          120) //elevated btton background color
                                      ),

                                  child: Text(
                                    "Créer un club",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ), //label text,
                                ),
                              ),
                            ),
                          )
                        
                      ),
                       SizedBox(
                            height: 20,
                          ),
                          new GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (c) => JoinEquipe()));
                            },
                            child: new Text(
                              "Rejoindre une équipe",
                              style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(200, 0, 249, 93),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                  ])))
        ]))
      ])
    ])));
  }
}
