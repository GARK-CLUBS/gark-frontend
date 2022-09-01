import 'package:custom_check_box/custom_check_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CompleteProgress extends StatefulWidget {
  const CompleteProgress({Key? key}) : super(key: key);

  @override
  State<CompleteProgress> createState() => _CompleteProgressState();
}

bool shouldCheck = false;
bool shouldCheckDefault = false;

class _CompleteProgressState extends State<CompleteProgress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 2, 0, 50),
      appBar:
          PreferredSize(child: getAppBar(), preferredSize: Size.fromHeight(50)),
      body: getBody(),
    );
  }

  Widget getBody() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Color.fromARGB(255, 2, 0, 50),
        appBar: PreferredSize(
            child: getAppBar(), preferredSize: const Size.fromHeight(50)),
        body: SingleChildScrollView(
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
                      Container(
                          padding: const EdgeInsets.symmetric(vertical: 25),
                          height: 110,
                          child: Column(
                            children: [
                              const Text(
                                "Finaliser la creation de l'équipe",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(223, 252, 252, 252),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    child: LinearPercentIndicator(
                                      width: 300,
                                      animation: true,
                                      percent: 60 / 100,
                                      animationDuration: 1,
                                      lineHeight: 10,
                                      // fillColor: Color.fromARGB(255, 255, 255, 255),
                                      backgroundColor: const Color.fromARGB(
                                          255, 255, 255, 255),

                                      progressColor: const Color.fromARGB(
                                          255, 130, 240, 134),
                                      barRadius: const Radius.circular(16),
                                    ),
                                  ),
                                  const Text(
                                    "60%",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Color.fromARGB(255, 252, 252, 252),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )),
                          // video 
                      SizedBox(
                        height: 150,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          CustomCheckBox(
                            checkBoxSize: 40,
                            value: shouldCheckDefault,
                            splashColor: Color.fromARGB(255, 12, 248, 0)
                                .withOpacity(0.4),
                            tooltip: 'Custom Check Box',
                            splashRadius: 40,
                            onChanged: (bool value) {},
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          const Text(
                            "Créer l'équipe",
                            style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(223, 252, 252, 252),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          CustomCheckBox(
                            checkBoxSize: 40,
                            value: shouldCheckDefault,
                            splashColor: Color.fromARGB(255, 12, 248, 0)
                                .withOpacity(0.4),
                            tooltip: 'Custom Check Box',
                            splashRadius: 40,
                            onChanged: (bool value) {},
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          const Text(
                            "Ajouter une photo de profil",
                            style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(223, 252, 252, 252),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          CustomCheckBox(
                            checkBoxSize: 40,
                            value: shouldCheckDefault,
                            splashColor: Color.fromARGB(255, 12, 248, 0)
                                .withOpacity(0.4),
                            tooltip: 'Custom Check Box',
                            splashRadius: 40,
                            onChanged: (bool value) {},
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          const Text(
                            "Inviter des membres",
                            style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(223, 252, 252, 252),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          CustomCheckBox(
                            checkBoxSize: 40,
                            value: shouldCheckDefault,
                            splashColor: Color.fromARGB(255, 12, 248, 0)
                                .withOpacity(0.4),
                            tooltip: 'Custom Check Box',
                            splashRadius: 40,
                            onChanged: (bool value) {},
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          const Text(
                            "Créer un événement",
                            style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(223, 252, 252, 252),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ])))
          ]),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: 200,
              height: 45, // <-- Your width
              child: Container(
                // padding: EdgeInsets.only(top: 30),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(199, 22, 216, 93),
                  ),

                  child: Text(
                    "Fermer",
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
        ])));
  }

  Widget getAppBar() {
    return SizedBox(
      height: 10,
    );
  }
}
