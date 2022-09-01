import 'package:flutter/material.dart';
import 'package:garkproject/pages/Notifications/Notifoption.dart';

class NotifParam extends StatefulWidget {
  const NotifParam({Key? key}) : super(key: key);

  @override
  State<NotifParam> createState() => _NotifParamState();
}

class _NotifParamState extends State<NotifParam> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 245, 245),
      appBar: PreferredSize(
          child: getAppBar(), preferredSize: const Size.fromHeight(50)),
      body: getBody(),
    );
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
          "Notifications",
          style: TextStyle(),
        ),
        Spacer(),
      ]),
    );
  }

  Widget getBody() {
    return SingleChildScrollView(
        child: Container(
            child: Column(children: [
      SizedBox(height: 20),
      Align(
        alignment: Alignment(-0.9, 0),
        child: Text(
          "Notifications majeures *",
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 16,
            color: Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      SizedBox(
        height: 11,
      ),
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                "les notifications majeures constituent le coeur de Gark et sont indispensables au bon fonctionnement de votre équipe \nElles sont donc obligatoires.",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 2,
      ),
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                "De préférence sur",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Text(
                "Mobile + Email",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.black),
              ),
            ),
            Container(
                child: SizedBox.fromSize(
              size: Size(42, 42),
              child: ClipOval(
                child: Material(
                  color: Colors.grey.withOpacity(0.0),
                  child: InkWell(
                    splashColor: Color.fromARGB(255, 248, 248, 248),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (c) => const Notifoption(majeures: true)));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey,
                          size: 16,
                        ), // <-- Icon
                      ],
                    ),
                  ),
                ),
              ),
            )),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(18.0),
        child: Text(
          "Exemples : Convocations aux événements, alertes de match annulés,etc.",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.normal, color: Colors.grey),
        ),
      ),
      SizedBox(height: 10),
      Align(
        alignment: Alignment(-0.9, 0),
        child: Text(
          "Notifications mineures *",
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 16,
            color: Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      SizedBox(
        height: 11,
      ),
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                "les notifications mineures ne sont pas indispensable à la vie de votre équipe.\nVous pouvez choisir de ne pas les recevoir.",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 2,
      ),
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                "De préférence sur",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Text(
                "Mobile + Email",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.black),
              ),
            ),
            Container(
                child: SizedBox.fromSize(
              size: Size(42, 42),
              child: ClipOval(
                child: Material(
                  color: Colors.grey.withOpacity(0.0),
                  child: InkWell(
                    splashColor: Color.fromARGB(255, 248, 248, 248),
                    onTap: () {
                       Navigator.of(context).push(MaterialPageRoute(
                          builder: (c) => const Notifoption(majeures: false)));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey,
                          size: 16,
                        ), // <-- Icon
                      ],
                    ),
                  ),
                ),
              ),
            )),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(18.0),
        child: Text(
          "Exemples : Comptes renuds d'après match , nouveaux commentaires dans une discussion , notifications de début de saison etc.",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.normal, color: Colors.grey),
        ),
      ),
      // to here
    ])));
  }
}
