import 'package:custom_check_box/custom_check_box.dart';
import 'package:flutter/material.dart';
import 'package:garkproject/pages/Calendrier/Stats/Joueurs/Buts.dart';
import 'package:garkproject/pages/Calendrier/Stats/Joueurs/TJ.dart';
import 'package:garkproject/pages/Calendrier/Stats/Score/GeneralStats.dart';

class ChooseStat extends StatefulWidget {
  const ChooseStat({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  State<ChooseStat> createState() => _ChooseStatState();
}

bool shouldCheckDefault = false;

class _ChooseStatState extends State<ChooseStat> {
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
          'Stats des joueurs',
          textAlign: TextAlign.center,
          style: TextStyle(),
        ),
        Spacer(),
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
        color: Color.fromARGB(255, 255, 255, 255),
        margin: EdgeInsets.only(top: 10),
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            children: [
              CustomCheckBox(
                checkBoxSize: 20,
                value: shouldCheckDefault,
                splashColor: Color.fromARGB(255, 12, 248, 0).withOpacity(0.4),
                tooltip: 'Custom Check Box',
                splashRadius: 40,
                onChanged: (bool value) {},
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Buts",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Spacer(),
              RawMaterialButton(
                constraints: BoxConstraints.tight(Size(26, 26)),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (c) => Buts(id: widget.id, type: "buts")));
                },
                child: IconTheme(
                  data: IconThemeData(
                      color: Color.fromARGB(255, 197, 197, 197), size: 16),
                  child: Icon(Icons.arrow_forward_ios),
                ),
                shape: CircleBorder(),
              )
            ],
          ),
        ),
      ),
      Container(
        color: Color.fromARGB(255, 255, 255, 255),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              CustomCheckBox(
                checkBoxSize: 20,
                value: shouldCheckDefault,
                splashColor: Color.fromARGB(255, 12, 248, 0).withOpacity(0.4),
                tooltip: 'Custom Check Box',
                splashRadius: 40,
                onChanged: (bool value) {},
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Passes décisives",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Spacer(),
              RawMaterialButton(
                constraints: BoxConstraints.tight(Size(26, 26)),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (c) => Buts(id: widget.id, type: "assists")));
                },
                child: IconTheme(
                  data: IconThemeData(
                      color: Color.fromARGB(255, 197, 197, 197), size: 16),
                  child: Icon(Icons.arrow_forward_ios),
                ),
                shape: CircleBorder(),
              )
            ],
          ),
        ),
      ),
      Container(
        color: Color.fromARGB(255, 255, 255, 255),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              CustomCheckBox(
                checkBoxSize: 20,
                value: shouldCheckDefault,
                splashColor: Color.fromARGB(255, 12, 248, 0).withOpacity(0.4),
                tooltip: 'Custom Check Box',
                splashRadius: 40,
                onChanged: (bool value) {},
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Carton rouges",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Spacer(),
              RawMaterialButton(
                constraints: BoxConstraints.tight(Size(26, 26)),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (c) =>
                          Buts(id: widget.id, type: "cartonRouge")));
                },
                child: IconTheme(
                  data: IconThemeData(
                      color: Color.fromARGB(255, 197, 197, 197), size: 16),
                  child: Icon(Icons.arrow_forward_ios),
                ),
                shape: CircleBorder(),
              )
            ],
          ),
        ),
      ),
      Container(
        color: Color.fromARGB(255, 255, 255, 255),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              CustomCheckBox(
                checkBoxSize: 20,
                value: shouldCheckDefault,
                splashColor: Color.fromARGB(255, 12, 248, 0).withOpacity(0.4),
                tooltip: 'Custom Check Box',
                splashRadius: 40,
                onChanged: (bool value) {},
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Carton jaune",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Spacer(),
              RawMaterialButton(
                constraints: BoxConstraints.tight(Size(26, 26)),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (c) =>
                          Buts(id: widget.id, type: "cartonJaune")));
                },
                child: IconTheme(
                  data: IconThemeData(
                      color: Color.fromARGB(255, 197, 197, 197), size: 16),
                  child: Icon(Icons.arrow_forward_ios),
                ),
                shape: CircleBorder(),
              )
            ],
          ),
        ),
      ),
      Container(
        color: Color.fromARGB(255, 255, 255, 255),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              CustomCheckBox(
                checkBoxSize: 20,
                value: shouldCheckDefault,
                splashColor: Color.fromARGB(255, 12, 248, 0).withOpacity(0.4),
                tooltip: 'Custom Check Box',
                splashRadius: 40,
                onChanged: (bool value) {},
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Temps joué",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Spacer(),
              RawMaterialButton(
                constraints: BoxConstraints.tight(Size(26, 26)),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (c) =>
                          Buts(id: widget.id, type: "tempsJouee")));
                },
                child: IconTheme(
                  data: IconThemeData(
                      color: Color.fromARGB(255, 197, 197, 197), size: 16),
                  child: Icon(Icons.arrow_forward_ios),
                ),
                shape: CircleBorder(),
              )
            ],
          ),
        ),
      ),
    ]));
  }
}
