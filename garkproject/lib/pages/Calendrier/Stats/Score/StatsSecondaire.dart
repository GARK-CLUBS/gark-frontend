import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StatsSecondaire extends StatefulWidget {
  const StatsSecondaire({Key? key}) : super(key: key);

  @override
  State<StatsSecondaire> createState() => _StatsSecondaireState();
}

int nb1 = 0;
int nb2 = 0;
bool status = false;
bool status1 = false;

class _StatsSecondaireState extends State<StatsSecondaire> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 245, 245),
      appBar:
          PreferredSize(child: getAppBar(), preferredSize: Size.fromHeight(40)),
      body: getBody(),
    );
  }

  Widget getAppBar() {
    return AppBar(
      elevation: 10,
      backgroundColor: const Color.fromARGB(255, 2, 0, 50),
      title: Row(children: <Widget>[
        Spacer(),
        Text(
          'Stats secondaires',
          textAlign: TextAlign.center,
          style: TextStyle(),
        ),
        Spacer(),
        IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 2, 0, 50),
          ),
          onPressed: () => {},
        ),
        Padding(
          padding: const EdgeInsets.only(right: 0),
          child: IconButton(
              icon: new Icon(Icons.save_as_outlined), onPressed: () {}),
        )
      ]),
    );
  }

  Widget getBody() {
    return SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
        height: 20,
      ),
      Align(
        alignment: Alignment(-0.8, 0),
        child: Text(
          "Stats secondaires",
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: 18,
            color: Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Container(
          margin: EdgeInsets.only(top: 10),
          width: double.maxFinite,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Container(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceEvenly, // use whichever suits your need
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 18),
                        child: Align(
                          alignment: Alignment(0, 0),
                          child: Text(
                            "Noirs",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      FlutterSwitch(
                        width: 55.0,
                        height: 25.0,
                        value: status,
                        onToggle: (val) {
                          setState(() {
                            status = val;
                          });
                        },
                      ),
                    ],
                  ),
                  Text(
                    "\n COCHER SI \n L'EQUIPE EST \n FORFAIT :",
                    style: TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 182, 182, 182)),
                    textAlign: TextAlign.center,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 18),
                        child: Align(
                          alignment: Alignment(0, 0),
                          child: Text(
                            "Noirs",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      FlutterSwitch(
                        width: 55.0,
                        height: 25.0,
                        value: status1,
                        onToggle: (val) {
                          setState(() {
                            status1 = val;
                          });
                        },
                      ),
                    ],
                  ),
                ]),
          )),
      Container(
          width: double.maxFinite,
          height: 180,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Container(
              padding: const EdgeInsets.only(
                top: 20,
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceEvenly, // use whichever suits your need
                  children: [
                    Column(
                      children: [
                        Align(
                          alignment: Alignment(0, 0),
                          child: Text(
                            "Noirs",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 28.0),
                          child: Align(
                            alignment: Alignment(0, 0),
                            child: Text(
                              nb1.toString(),
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 42,
                                color: nb1 > nb2
                                    ? Color.fromARGB(255, 0, 255, 110)
                                    : nb1 < nb2
                                        ? Color.fromARGB(255, 255, 0, 0)
                                        : Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                        new SizedBox(
                          width: 100,
                          height: 5.0,
                          child: new Center(
                            child: new Container(
                              margin: new EdgeInsetsDirectional.only(
                                  start: 1.0, end: 1.0),
                              height: 2.0,
                              color: Color.fromARGB(255, 208, 208, 208),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              InkWell(
                                child: Container(
                                  width: 40,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      border: Border.all(
                                          width: 1,
                                          color: Color.fromARGB(
                                              255, 97, 204, 35))),
                                  child: Icon(
                                    FontAwesomeIcons.minus,
                                    color: Color.fromARGB(255, 97, 204, 35),
                                    size: 24,
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    if (nb1 <= 0) {
                                      nb1 = 0;
                                    } else {
                                      nb1--;
                                    }
                                  });
                                },
                              ),
                              InkWell(
                                child: Container(
                                  width: 40,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      border: Border.all(
                                          width: 1,
                                          color: Color.fromARGB(
                                              255, 97, 204, 35))),
                                  child: Icon(Icons.add,
                                      color: Color.fromARGB(255, 97, 204, 35)),
                                ),
                                onTap: () {
                                  setState(() {
                                    if (nb1 <= 0) {
                                      nb1 = 0;
                                    }
                                    nb1++;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "AV.P",
                      style: TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 182, 182, 182)),
                    ),
                    Column(
                      children: [
                        Align(
                          alignment: Alignment(0, 0),
                          child: Text(
                            "Bruns",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 28.0),
                          child: Align(
                            alignment: Alignment(0, 0),
                            child: Text(
                              nb2.toString(),
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 42,
                                color: nb2 > nb1
                                    ? Color.fromARGB(255, 0, 255, 110)
                                    : nb2 < nb1
                                        ? Color.fromARGB(255, 255, 0, 0)
                                        : Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                        new SizedBox(
                          width: 100,
                          height: 5.0,
                          child: new Center(
                            child: new Container(
                              margin: new EdgeInsetsDirectional.only(
                                  start: 1.0, end: 1.0),
                              height: 2.0,
                              color: Color.fromARGB(255, 208, 208, 208),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              InkWell(
                                child: Container(
                                  width: 40,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      border: Border.all(
                                          width: 1,
                                          color: Color.fromARGB(
                                              255, 97, 204, 35))),
                                  child: Icon(
                                    FontAwesomeIcons.minus,
                                    color: Color.fromARGB(255, 97, 204, 35),
                                    size: 24,
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    if (nb2 <= 0) {
                                      nb2 = 0;
                                    } else {
                                      nb2--;
                                    }
                                  });
                                },
                              ),
                              InkWell(
                                child: Container(
                                  width: 40,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      border: Border.all(
                                          width: 1,
                                          color: Color.fromARGB(
                                              255, 97, 204, 35))),
                                  child: Icon(Icons.add,
                                      color: Color.fromARGB(255, 97, 204, 35)),
                                ),
                                onTap: () {
                                  setState(() {
                                    if (nb2 <= 0) {
                                      nb2 = 0;
                                    }
                                    nb2++;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ]))),
      Container(
          width: double.maxFinite,
          height: 180,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Container(
              padding: const EdgeInsets.only(
                top: 20,
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceEvenly, // use whichever suits your need
                  children: [
                    Column(
                      children: [
                        Align(
                          alignment: Alignment(0, 0),
                          child: Text(
                            "Noirs",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 28.0),
                          child: Align(
                            alignment: Alignment(0, 0),
                            child: Text(
                              nb1.toString(),
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 42,
                                color: nb1 > nb2
                                    ? Color.fromARGB(255, 0, 255, 110)
                                    : nb1 < nb2
                                        ? Color.fromARGB(255, 255, 0, 0)
                                        : Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                        new SizedBox(
                          width: 100,
                          height: 5.0,
                          child: new Center(
                            child: new Container(
                              margin: new EdgeInsetsDirectional.only(
                                  start: 1.0, end: 1.0),
                              height: 2.0,
                              color: Color.fromARGB(255, 208, 208, 208),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              InkWell(
                                child: Container(
                                  width: 40,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      border: Border.all(
                                          width: 1,
                                          color: Color.fromARGB(
                                              255, 97, 204, 35))),
                                  child: Icon(
                                    FontAwesomeIcons.minus,
                                    color: Color.fromARGB(255, 97, 204, 35),
                                    size: 24,
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    if (nb1 <= 0) {
                                      nb1 = 0;
                                    } else {
                                      nb1--;
                                    }
                                  });
                                },
                              ),
                              InkWell(
                                child: Container(
                                  width: 40,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      border: Border.all(
                                          width: 1,
                                          color: Color.fromARGB(
                                              255, 97, 204, 35))),
                                  child: Icon(Icons.add,
                                      color: Color.fromARGB(255, 97, 204, 35)),
                                ),
                                onTap: () {
                                  setState(() {
                                    if (nb1 <= 0) {
                                      nb1 = 0;
                                    }
                                    nb1++;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "TAB",
                      style: TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 182, 182, 182)),
                    ),
                    Column(
                      children: [
                        Align(
                          alignment: Alignment(0, 0),
                          child: Text(
                            "Bruns",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 28.0),
                          child: Align(
                            alignment: Alignment(0, 0),
                            child: Text(
                              nb2.toString(),
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 42,
                                color: nb2 > nb1
                                    ? Color.fromARGB(255, 0, 255, 110)
                                    : nb2 < nb1
                                        ? Color.fromARGB(255, 255, 0, 0)
                                        : Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                        new SizedBox(
                          width: 100,
                          height: 5.0,
                          child: new Center(
                            child: new Container(
                              margin: new EdgeInsetsDirectional.only(
                                  start: 1.0, end: 1.0),
                              height: 2.0,
                              color: Color.fromARGB(255, 208, 208, 208),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              InkWell(
                                child: Container(
                                  width: 40,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      border: Border.all(
                                          width: 1,
                                          color: Color.fromARGB(
                                              255, 97, 204, 35))),
                                  child: Icon(
                                    FontAwesomeIcons.minus,
                                    color: Color.fromARGB(255, 97, 204, 35),
                                    size: 24,
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    if (nb2 <= 0) {
                                      nb2 = 0;
                                    } else {
                                      nb2--;
                                    }
                                  });
                                },
                              ),
                              InkWell(
                                child: Container(
                                  width: 40,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      border: Border.all(
                                          width: 1,
                                          color: Color.fromARGB(
                                              255, 97, 204, 35))),
                                  child: Icon(Icons.add,
                                      color: Color.fromARGB(255, 97, 204, 35)),
                                ),
                                onTap: () {
                                  setState(() {
                                    if (nb2 <= 0) {
                                      nb2 = 0;
                                    }
                                    nb2++;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ]))),
      Container(
          width: double.maxFinite,
          height: 180,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Container(
              padding: const EdgeInsets.only(
                top: 20,
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceEvenly, // use whichever suits your need
                  children: [
                    Column(
                      children: [
                        Align(
                          alignment: Alignment(0, 0),
                          child: Text(
                            "Noirs",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 28.0),
                          child: Align(
                            alignment: Alignment(0, 0),
                            child: Text(
                              nb1.toString(),
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 42,
                                color: nb1 > nb2
                                    ? Color.fromARGB(255, 0, 255, 110)
                                    : nb1 < nb2
                                        ? Color.fromARGB(255, 255, 0, 0)
                                        : Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                        new SizedBox(
                          width: 100,
                          height: 5.0,
                          child: new Center(
                            child: new Container(
                              margin: new EdgeInsetsDirectional.only(
                                  start: 1.0, end: 1.0),
                              height: 2.0,
                              color: Color.fromARGB(255, 208, 208, 208),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              InkWell(
                                child: Container(
                                  width: 40,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      border: Border.all(
                                          width: 1,
                                          color: Color.fromARGB(
                                              255, 97, 204, 35))),
                                  child: Icon(
                                    FontAwesomeIcons.minus,
                                    color: Color.fromARGB(255, 97, 204, 35),
                                    size: 24,
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    if (nb1 <= 0) {
                                      nb1 = 0;
                                    } else {
                                      nb1--;
                                    }
                                  });
                                },
                              ),
                              InkWell(
                                child: Container(
                                  width: 40,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      border: Border.all(
                                          width: 1,
                                          color: Color.fromARGB(
                                              255, 97, 204, 35))),
                                  child: Icon(Icons.add,
                                      color: Color.fromARGB(255, 97, 204, 35)),
                                ),
                                onTap: () {
                                  setState(() {
                                    if (nb1 <= 0) {
                                      nb1 = 0;
                                    }
                                    nb1++;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "CSC",
                      style: TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 182, 182, 182)),
                    ),
                    Column(
                      children: [
                        Align(
                          alignment: Alignment(0, 0),
                          child: Text(
                            "Bruns",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 28.0),
                          child: Align(
                            alignment: Alignment(0, 0),
                            child: Text(
                              nb2.toString(),
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 42,
                                color: nb2 > nb1
                                    ? Color.fromARGB(255, 0, 255, 110)
                                    : nb2 < nb1
                                        ? Color.fromARGB(255, 255, 0, 0)
                                        : Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                        new SizedBox(
                          width: 100,
                          height: 5.0,
                          child: new Center(
                            child: new Container(
                              margin: new EdgeInsetsDirectional.only(
                                  start: 1.0, end: 1.0),
                              height: 2.0,
                              color: Color.fromARGB(255, 208, 208, 208),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              InkWell(
                                child: Container(
                                  width: 40,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      border: Border.all(
                                          width: 1,
                                          color: Color.fromARGB(
                                              255, 97, 204, 35))),
                                  child: Icon(
                                    FontAwesomeIcons.minus,
                                    color: Color.fromARGB(255, 97, 204, 35),
                                    size: 24,
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    if (nb2 <= 0) {
                                      nb2 = 0;
                                    } else {
                                      nb2--;
                                    }
                                  });
                                },
                              ),
                              InkWell(
                                child: Container(
                                  width: 40,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      border: Border.all(
                                          width: 1,
                                          color: Color.fromARGB(
                                              255, 97, 204, 35))),
                                  child: Icon(Icons.add,
                                      color: Color.fromARGB(255, 97, 204, 35)),
                                ),
                                onTap: () {
                                  setState(() {
                                    if (nb2 <= 0) {
                                      nb2 = 0;
                                    }
                                    nb2++;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ]))),
    ]));
  }
}
