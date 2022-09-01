import 'package:custom_check_box/custom_check_box.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:garkproject/pages/Calendrier/Compos/AddCompos.dart';
import 'package:garkproject/pages/Calendrier/Stats/Joueurs/ChooseStat.dart';
import 'package:garkproject/pages/Calendrier/Stats/Score/GeneralStats.dart';
import 'package:garkproject/pages/Calendrier/Tache/EditTache.dart';
import 'package:garkproject/pages/Calendrier/Tache/Tache.dart';
import 'package:garkproject/pages/Settings/DeleteAccount.dart';
import 'package:garkproject/pages/Calendrier/Calendrier.dart';
import 'package:garkproject/pages/Settings/Indiponibilites.dart';
import 'package:garkproject/pages/Settings/UpdateProfile.dart';
import 'package:group_radio_button/group_radio_button.dart';

import 'Calendrier.dart';

class ParametresCalendrier extends StatefulWidget {
  const ParametresCalendrier({Key? key,required this.id}) : super(key: key);
final String id ; 
  @override
  State<ParametresCalendrier> createState() => _ParametresCalendrierState();
}

TextEditingController namepersons = TextEditingController();
bool _isButtonDisabled = true;
var _selected = "";
DateTime date = DateTime.now();
final TextEditingController birthInput = TextEditingController();
final TextEditingController datearriveInput = TextEditingController();
bool shouldCheckDefault = false;

class _ParametresCalendrierState extends State<ParametresCalendrier>
    with TickerProviderStateMixin {
  bool shouldCheckDefault1 = false;
  bool shouldCheckDefault2 = true;
  bool shouldCheckDefault3 = true;
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
      title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              "hhhhh",
              style: TextStyle(color: Color.fromARGB(255, 2, 0, 50)),
            ),
            Text(
              'Paramètres',
              textAlign: TextAlign.center,
              style: TextStyle(),
            ),
            IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Color.fromARGB(255, 2, 0, 50),
              ),
              onPressed: () => {},
            ),
            Text(
              "hhhhh",
              style: TextStyle(color: Color.fromARGB(255, 2, 0, 50)),
            ),
          ]),
    );
  }

  Widget getBody() {
    TabController _tabController = TabController(length: 3, vsync: this);
    int activeTabIndex = 1;
    return SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
        height: 20,
      ),
      Align(
        alignment: Alignment(-0.8, 0),
        child: Text(
          "Match",
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: 18,
            color: Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      SizedBox(
        height: 5,
      ),
      Container(
          height: 50,
          width: MediaQuery.of(context).size.width - 40,
          margin: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                )
              ]),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              IconButton(
                  icon: const Icon(Icons.mode_edit_outlined),
                  color: Color.fromARGB(255, 54, 54, 54),
                  onPressed: () {
                    setState(() {
                      debugPrint("tekhdem ");
                    });
                  }),
              Expanded(
                child: Align(
                  alignment: Alignment(-0.95, 0),
                  child: Text(
                    "Editer l'événement",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 15,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Container(
                  alignment: Alignment(0, 0),
                  child: SizedBox.fromSize(
                    size: Size(56, 56),
                    child: ClipOval(
                      child: Material(
                        color: Colors.grey.withOpacity(0.0),
                        child: InkWell(
                          splashColor: Color.fromARGB(255, 248, 248, 248),
                          onTap: () {
                            // Calendrier.Editaddevent(_tabController,activeTabIndex,context) ;
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.arrow_forward_ios), // <-- Icon
                            ],
                          ),
                        ),
                      ),
                    ),
                  )),
            ]),
          )),
      SizedBox(height: 1),
      Container(
        height: 50,
        width: MediaQuery.of(context).size.width - 40,
        margin: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
              )
            ]),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            IconButton(
                icon: const Icon(Icons.replay),
                color: Color.fromARGB(255, 54, 54, 54),
                onPressed: () {
                  setState(() {
                    //_isEnable = true;
                  });
                }),
            Expanded(
              child: Align(
                alignment: Alignment(-0.87, 0),
                child: Text(
                  "Reporter l'événement",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 15,
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Container(
                alignment: Alignment(0, 0),
                child: SizedBox.fromSize(
                  size: Size(56, 56),
                  child: ClipOval(
                    child: Material(
                      color:
                          Color.fromARGB(255, 213, 199, 199).withOpacity(0.0),
                      child: InkWell(
                        splashColor: Color.fromARGB(255, 248, 248, 248),
                        onTap: () {
                          _displayDialog(context);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.arrow_forward_ios_sharp), // <-- Icon
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
          ]),
        ),
      ),
      SizedBox(height: 2),
      Container(
          height: 50,
          width: MediaQuery.of(context).size.width - 40,
          margin: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                )
              ]),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              IconButton(
                  icon: const Icon(Icons.edit_calendar_rounded),
                  color: Color.fromARGB(255, 54, 54, 54),
                  onPressed: () {
                    setState(() {
                      //_isEnable = true;
                    });
                  }),
              Expanded(
                child: Align(
                  alignment: Alignment(-0.95, 0),
                  child: Text(
                    "Annuler l'événement",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 15,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Container(
                  alignment: Alignment(0, 1),
                  child: SizedBox.fromSize(
                    size: Size(56, 56),
                    child: ClipOval(
                      child: Material(
                        color: Colors.grey.withOpacity(0.0),
                        child: InkWell(
                          splashColor: Color.fromARGB(255, 248, 248, 248),
                          onTap: () {
                            _displayDialog2(context);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.arrow_forward_ios), // <-- Icon
                            ],
                          ),
                        ),
                      ),
                    ),
                  )),
            ]),
          )),
      SizedBox(height: 2),
      Container(
          height: 50,
          width: MediaQuery.of(context).size.width - 40,
          margin: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                )
              ]),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              IconButton(
                  icon: const Icon(Icons.delete),
                  color: Color.fromARGB(255, 54, 54, 54),
                  onPressed: () {
                    setState(() {
                      //_isEnable = true;
                    });
                  }),
              Expanded(
                child: Align(
                  alignment: Alignment(-0.9, 0),
                  child: Text(
                    "Supprimer l'évenement",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 15,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Container(
                  alignment: Alignment(0, 1),
                  child: SizedBox.fromSize(
                    size: Size(56, 56),
                    child: ClipOval(
                      child: Material(
                        color: Colors.grey.withOpacity(0.0),
                        child: InkWell(
                          splashColor: Color.fromARGB(255, 248, 248, 248),
                          onTap: () {
                            _displayDialog3(context);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.arrow_forward_ios), // <-- Icon
                            ],
                          ),
                        ),
                      ),
                    ),
                  )),
            ]),
          )),
      SizedBox(
        height: 10,
      ),
      Align(
        alignment: Alignment(-0.8, 0),
        child: Text(
          "Joueurs",
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: 18,
            color: Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      SizedBox(height: 10),
      Container(
          height: 50,
          width: MediaQuery.of(context).size.width - 40,
          margin: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                )
              ]),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              IconButton(
                  icon: const Icon(Icons.group_add),
                  color: Color.fromARGB(255, 54, 54, 54),
                  onPressed: () {}),
              Expanded(
                child: Align(
                  alignment: Alignment(-0.9, 0),
                  child: Text(
                    "Ajouter des joueurs",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 15,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Container(
                  alignment: Alignment(0, 1),
                  child: SizedBox.fromSize(
                    size: Size(56, 56),
                    child: ClipOval(
                      child: Material(
                        color: Colors.grey.withOpacity(0.0),
                        child: InkWell(
                          splashColor: Color.fromARGB(255, 248, 248, 248),
                          onTap: () {
                            AddPlayers();
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.arrow_forward_ios), // <-- Icon
                            ],
                          ),
                        ),
                      ),
                    ),
                  )),
            ]),
          )),
      SizedBox(height: 2),
      Container(
          height: 50,
          width: MediaQuery.of(context).size.width - 40,
          margin: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                )
              ]),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              IconButton(
                  icon: const Icon(Icons.task),
                  color: Color.fromARGB(255, 54, 54, 54),
                  onPressed: () {
                    setState(() {
                      //_isEnable = true;
                    });
                  }),
              Expanded(
                child: Align(
                  alignment: Alignment(-0.9, 0),
                  child: Text(
                    "Assigner une tache",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 15,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Container(
                  alignment: Alignment(0, 1),
                  child: SizedBox.fromSize(
                    size: Size(56, 56),
                    child: ClipOval(
                      child: Material(
                        color: Colors.grey.withOpacity(0.0),
                        child: InkWell(
                          splashColor: Color.fromARGB(255, 248, 248, 248),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Tache(text: "", id:"widget.id",idtype: "",)),
                            ).then((value) => setState(() {}));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.arrow_forward_ios), // <-- Icon
                            ],
                          ),
                        ),
                      ),
                    ),
                  )),
            ]),
          )),
      SizedBox(
        height: 10,
      ),
      Align(
        alignment: Alignment(-0.8, 0),
        child: Text(
          "Compos",
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: 18,
            color: Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      SizedBox(height: 10),
      Container(
          height: 50,
          width: MediaQuery.of(context).size.width - 40,
          margin: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                )
              ]),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              IconButton(
                  icon: const Icon(Icons.group_work),
                  color: Color.fromARGB(255, 54, 54, 54),
                  onPressed: () {
                    setState(() {
                      //_isEnable = true;
                    });
                  }),
              Expanded(
                child: Align(
                  alignment: Alignment(-0.9, 0),
                  child: Text(
                    "Editer les compos",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 15,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Container(
                  alignment: Alignment(0, 1),
                  child: SizedBox.fromSize(
                    size: Size(56, 56),
                    child: ClipOval(
                      child: Material(
                        color: Colors.grey.withOpacity(0.0),
                        child: InkWell(
                          splashColor: Color.fromARGB(255, 248, 248, 248),
                          onTap: () {
                        Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AddCompos(number : "5" ,id:widget.id)),
                            ).then((value) => setState(() {}));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.arrow_forward_ios), // <-- Icon
                            ],
                          ),
                        ),
                      ),
                    ),
                  )),
            ]),
          )),
      SizedBox(
        height: 10,
      ),
      Align(
        alignment: Alignment(-0.8, 0),
        child: Text(
          "Stats",
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: 18,
            color: Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      SizedBox(height: 10),
      Container(
          height: 50,
          width: MediaQuery.of(context).size.width - 40,
          margin: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                )
              ]),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              IconButton(
                  icon: const Icon(Icons.scoreboard),
                  color: Color.fromARGB(255, 54, 54, 54),
                  onPressed: () {
                    setState(() {
                      //_isEnable = true;
                    });
                  }),
              Expanded(
                child: Align(
                  alignment: Alignment(-0.9, 0),
                  child: Text(
                    "Editer le score",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 15,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Container(
                  alignment: Alignment(0, 1),
                  child: SizedBox.fromSize(
                    size: Size(56, 56),
                    child: ClipOval(
                      child: Material(
                        color: Colors.grey.withOpacity(0.0),
                        child: InkWell(
                          splashColor: Color.fromARGB(255, 248, 248, 248),
                          onTap: () {
   Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      GeneralStats(id: widget.id )),
                            ).then((value) => setState(() {}));                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.arrow_forward_ios), // <-- Icon
                            ],
                          ),
                        ),
                      ),
                    ),
                  )),
            ]),
          )),
      SizedBox(
        height: 2,
      ),
      Container(
          height: 50,
          width: MediaQuery.of(context).size.width - 40,
          margin: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                )
              ]),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              IconButton(
                  icon: const Icon(Icons.stacked_bar_chart),
                  color: Color.fromARGB(255, 54, 54, 54),
                  onPressed: () {
                    setState(() {
                      //_isEnable = true;
                    });
                  }),
              SizedBox(
                height: 4,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment(-0.9, 0),
                  child: Text(
                    "Editer les stats des joueurs",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 15,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Container(
                  alignment: Alignment(0, 1),
                  child: SizedBox.fromSize(
                    size: Size(56, 56),
                    child: ClipOval(
                      child: Material(
                        color: Colors.grey.withOpacity(0.0),
                        child: InkWell(
                          splashColor: Color.fromARGB(255, 248, 248, 248),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ChooseStat(id:widget.id )),
                            ).then((value) => setState(() {}));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.arrow_forward_ios), // <-- Icon
                            ],
                          ),
                        ),
                      ),
                    ),
                  )),
            ]),
          )),
    ]));
  }

  Future<dynamic> AddPlayers() {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter state) {
            return FractionallySizedBox(
                heightFactor: 0.91,
                child: Wrap(children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 2, 0, 50),
                    ),
                    child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 10),
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.arrow_back,
                                  color: Color.fromARGB(255, 255, 255, 255)),
                              onPressed: () => Navigator.pop(context),
                            ),
                            Align(
                              alignment: Alignment(-1, 0),
                              child: Text(
                                "Choisir une ou plusieurs personnes ",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              child: GestureDetector(
                                onTap: () {
                                  state(() => namepersons.text = "slim ayadi");

                                  _isButtonDisabled = false;
                                  Navigator.pop(context);
                                },
                                child: new Text(
                                  "Valider",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(197, 215, 215, 215),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                  Container(
                      width: double.maxFinite,
                      height: 750,
                      child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(), // new
                          shrinkWrap: true,
                          itemCount: 1,
                          itemBuilder: (_, index) {
                            return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    children: <Widget>[
                                      Container(
                                          child: Stack(children: <Widget>[
                                        Container(
                                          height:
                                              80, // change it to 140 idha nheb nrejaaha kima kenet
                                          decoration: const BoxDecoration(
                                            color:
                                                Color.fromARGB(255, 2, 0, 50),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 20,
                                          left: 0,
                                          right: 0,
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            height: 44,
                                            child: Container(
                                              width: double.infinity,
                                              height: 38,
                                              decoration: BoxDecoration(
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.3),
                                                        blurRadius: 15,
                                                        spreadRadius: 5)
                                                  ]),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  IconButton(
                                                      onPressed: () {},
                                                      icon: Icon(
                                                        Icons.search,
                                                        color: Colors.black,
                                                      )),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Flexible(
                                                    child: TextField(
                                                      cursorColor: Colors.black,
                                                      decoration: InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          hintText:
                                                              "Search for contacts"),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ])),
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 20, left: 15),
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Align(
                                              alignment: Alignment(-0.5, 0),
                                              child: IconTheme(
                                                data: IconThemeData(
                                                    color: Color.fromARGB(
                                                        255, 0, 0, 0),
                                                    size: 22),
                                                child:
                                                    Icon(Icons.arrow_drop_down),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment(-0.8, 0),
                                              child: Text(
                                                "Présent (2) ",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                                child: Divider(
                                              height: 20,
                                              thickness: 1,
                                            )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  // from here
                                  Container(
                                      width: double.maxFinite,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child: Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Column(children: [
                                            Row(
                                              children: [
                                                CircleAvatar(
                                                  radius: 30.0,
                                                  backgroundImage: NetworkImage(
                                                      "https://www.simplilearn.com/ice9/free_resources_article_thumb/what_is_image_Processing.jpg"),
                                                  backgroundColor:
                                                      Colors.transparent,
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),

                                                Align(
                                                  child: Text(
                                                    "Slim ayadi",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Color.fromARGB(
                                                            255, 0, 0, 0),
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),

                                                // when clicked yelzem bottom bar fiha update
                                                Spacer(),
                                                CustomCheckBox(
                                                  checkedFillColor:
                                                      const Color.fromARGB(
                                                          255, 2, 0, 50),
                                                  borderColor: Colors.grey,
                                                  checkBoxSize: 18,
                                                  value: shouldCheckDefault,
                                                  tooltip: ' Check Box',
                                                  onChanged: (val) {
                                                    //do your stuff here
                                                    state(() =>
                                                        shouldCheckDefault =
                                                            val);
                                                  },
                                                ),
                                              ],
                                            ),
                                          ]))),
                                  // to here
                                ]);
                          }))
                ]));
          });
        });
  }

  _displayDialog(BuildContext context) async {
    _selected = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return Container(
            child: Column(
              children: [
                Expanded(
                  child: SimpleDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0))),
                    title: Align(
                      alignment: Alignment(0, 0),
                      child: Text(
                        "Reporter l'événement",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Debut",
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                ),
                              ),
                              controller: birthInput,
                              readOnly: true,
                              onTap: () {
                                DatePicker.showDateTimePicker(context,
                                    showTitleActions: true, onChanged: (date) {
                                  print('change $date in time zone ' +
                                      date.timeZoneOffset.inHours.toString());
                                }, onConfirm: (datee) {
                                  setState(() {
                                    birthInput.text = datee.toString();
                                  });
                                },
                                    currentTime:
                                        DateTime(2022, 12, 31, 23, 12, 34),
                                    locale: LocaleType.en);
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Veuillez renseigner la date de debut .";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Fin",
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                ),
                              ),
                              controller: datearriveInput,
                              readOnly: true,
                              onTap: () {
                                DatePicker.showDateTimePicker(context,
                                    showTitleActions: true, onChanged: (date) {
                                  print('change $date in time zone ' +
                                      date.timeZoneOffset.inHours.toString());
                                }, onConfirm: (datee) {
                                  setState(() {
                                    datearriveInput.text = datee.toString();
                                  });
                                },
                                    currentTime:
                                        DateTime(2022, 12, 31, 23, 12, 34),
                                    locale: LocaleType.en);
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Veuillez renseigner la  date de fin  .";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CustomCheckBox(
                                  checkBoxSize: 20,
                                  value: shouldCheckDefault1,
                                  splashColor: Color.fromARGB(255, 12, 248, 0)
                                      .withOpacity(0.4),
                                  tooltip: 'Custom Check Box',
                                  splashRadius: 40,
                                  onChanged: (bool value) {
                                    setState(() {
                                      shouldCheckDefault1 = value;
                                    });
                                  },
                                ),
                                Text("Report a une date inconnue")
                              ],
                            ),
                            Row(
                              children: [
                                CustomCheckBox(
                                  checkBoxSize: 20,
                                  value: shouldCheckDefault2,
                                  splashColor: Color.fromARGB(255, 12, 248, 0)
                                      .withOpacity(0.4),
                                  tooltip: 'Custom Check Box',
                                  splashRadius: 40,
                                  onChanged: (bool value) {
                                    setState(() {
                                      shouldCheckDefault2 = value;
                                    });
                                  },
                                ),
                                Text("Prévenir les personnes du report")
                              ],
                            ),
                            Row(
                              children: [
                                CustomCheckBox(
                                  checkBoxSize: 20,
                                  value: shouldCheckDefault3,
                                  splashColor: Color.fromARGB(255, 12, 248, 0)
                                      .withOpacity(0.4),
                                  tooltip: 'Custom Check Box',
                                  splashRadius: 40,
                                  onChanged: (bool value) {
                                    setState(() {
                                      shouldCheckDefault3 = value;
                                    });
                                  },
                                ),
                                Text(
                                    "Remettre a zéro les disponibilités \net convocations")
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 20),
                              child: SizedBox(
                                width: 250,
                                height: 45, // <-- Your width
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 30),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (c) => EditTache(
                                                    id: "1",
                                                  )));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Color.fromARGB(255, 47, 176, 64),
                                    ),

                                    child: Text(
                                      "Editer",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ), //label text,
                                  ),
                                ),
                              ),
                            ),
                            new GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Align(
                                alignment: Alignment(0, 0),
                                child: new Text(
                                  "Annuler",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 47, 176, 64),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      )
                    ],

                    elevation: 10,
                    //backgroundColor: Colors.green,
                  ),
                ),
              ],
            ),
          );
        });
      },
    );

    if (_selected != null) {
      setState(() {
        _selected = _selected;
      });
    }
  }

  _displayDialog2(BuildContext context) async {
    _selected = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return Container(
            child: Column(
              children: [
                Expanded(
                  child: SimpleDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0))),
                    title: Align(
                      alignment: Alignment(0, 0),
                      child: Text(
                        "Annuler l'événement",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Align(
                          alignment: Alignment(0, 0),
                          child: Text(
                            " L'événement sera marqué comme annulé sur le calendrier et sur la feuille de match ",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 62, 62, 62),
                              fontWeight: FontWeight.normal,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 20),
                              child: SizedBox(
                                width: 250,
                                height: 45, // <-- Your width
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 30),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (c) => EditTache(
                                                    id: "1",
                                                  )));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Color.fromARGB(255, 47, 176, 64),
                                    ),

                                    child: Text(
                                      "Confirmer",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ), //label text,
                                  ),
                                ),
                              ),
                            ),
                            new GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Align(
                                alignment: Alignment(0, 0),
                                child: new Text(
                                  "Annuler",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 47, 176, 64),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      )
                    ],

                    elevation: 10,
                    //backgroundColor: Colors.green,
                  ),
                ),
              ],
            ),
          );
        });
      },
    );

    if (_selected != null) {
      setState(() {
        _selected = _selected;
      });
    }
  }

  _displayDialog3(BuildContext context) async {
    _selected = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return Container(
            child: Column(
              children: [
                Expanded(
                  child: SimpleDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0))),
                    title: Align(
                      alignment: Alignment(0, 0),
                      child: Text(
                        "Supprimer l'événement",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Align(
                          alignment: Alignment(0, 0),
                          child: Text(
                            "Si vous supprimez cet événement, toutes les données associées seront supprimées : joueurs inscrits, score et stats, forum du match ..  ",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 62, 62, 62),
                              fontWeight: FontWeight.normal,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Align(
                          alignment: Alignment(0, 0),
                          child: Text(
                            "Cette action est irréversible. Etes-vous sur de vouloir supprimer cet événement ?  ",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 250, 83, 41),
                              fontWeight: FontWeight.normal,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 20),
                              child: SizedBox(
                                width: 250,
                                height: 45, // <-- Your width
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 30),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (c) => EditTache(
                                                    id: "1",
                                                  )));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Color.fromARGB(255, 232, 18, 18),
                                    ),

                                    child: Text(
                                      "Confirmer",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ), //label text,
                                  ),
                                ),
                              ),
                            ),
                            new GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Align(
                                alignment: Alignment(0, 0),
                                child: new Text(
                                  "Annuler",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 58, 176, 74),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      )
                    ],

                    elevation: 10,
                    //backgroundColor: Colors.green,
                  ),
                ),
              ],
            ),
          );
        });
      },
    );

    if (_selected != null) {
      setState(() {
        _selected = _selected;
      });
    }
  }
}
