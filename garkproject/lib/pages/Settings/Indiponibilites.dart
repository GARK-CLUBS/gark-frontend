import 'package:flutter/material.dart';
import 'package:garkproject/main.dart';
import 'package:garkproject/pages/Settings/AddIndisponibilite.dart';

class Indisponibilites extends StatefulWidget {
  const Indisponibilites({Key? key}) : super(key: key);

  @override
  State<Indisponibilites> createState() => _IndisponibilitesState();
}

class _IndisponibilitesState extends State<Indisponibilites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 245, 245),
      appBar:
          PreferredSize(child: getAppBar(), preferredSize: Size.fromHeight(40)),
      body: getBody(context),
    );
  }
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
            'Indisponibilités',
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

Widget getBody(BuildContext context) {
  return SingleChildScrollView(
      child: Column(children: [
    Container(
        width: MediaQuery.of(context).size.width - 10,
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(children: [
              SizedBox(
                height: 80,
              ),
              Image.asset(
                "assets/doodle.PNG",
                height: (165),
                width: (235),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Aucune absence en cours ou à venir",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 59, 59, 59),
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Cette fonctionnalité vous permet d'indiquer une absence pour une periode à venir",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Color.fromARGB(255, 159, 159, 159),
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "En savoir plus",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Color.fromARGB(255, 159, 159, 159),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Vous ne serez pas convoqué automatiquement et votre coach sera en courant de votre absence",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Color.fromARGB(255, 159, 159, 159),
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                width: 250,
                height: 45, // <-- Your width
                child: Container(
                  // padding: EdgeInsets.only(top: 30),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (c) => AddIndisponibilite()));
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(
                            255, 14, 178, 120) //elevated btton background color
                        ),
                    child: Text(
                      "Ajouter une indisponibilité",
                      style: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ])))
  ]));
}
