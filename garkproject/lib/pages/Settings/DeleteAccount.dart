import 'package:flutter/material.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({Key? key}) : super(key: key);

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

String? dropdownMotif = null;
var itemsMotif = [
  'Vacances',
  'Malade',
  'Blessé',
  'Autre motif',
];

class _DeleteAccountState extends State<DeleteAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 245, 245),
      appBar:
          PreferredSize(child: getAppBar(), preferredSize: Size.fromHeight(40)),
      body: getBody(context),
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
              style:
                  TextStyle(color: Color.fromARGB(255, 2, 0, 50), fontSize: 4),
            ),
            Text(
              'Supprimer mon compte',
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
          ]),
    );
  }

  Widget getBody(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      Container(
          width: MediaQuery.of(context).size.width - 10,
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Container(
              child: Column(children: [
            SizedBox(
              height: 40,
            ),
            Align(
              alignment: Alignment(-1, 0),
              child: Text(
                "Avant de confirmer votre fin de carriére sportive sur GarkClub , sachez que vous ne recevrez plus les convocations et autres nouvelles de vos équipes",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 14.5,
                  color: Color.fromARGB(255, 48, 48, 48),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                SizedBox.fromSize(
                  size: Size(56, 56),
                  child: ClipOval(
                    child: Material(
                      color: Color.fromARGB(255, 255, 0, 0).withOpacity(0.0),
                      child: InkWell(
                        splashColor: Color.fromARGB(255, 248, 248, 248),
                        onTap: () {
                          print("add btn works !");
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconTheme(
                              data: new IconThemeData(
                                color: Color.fromARGB(255, 255, 110, 110),
                              ),
                              child: Icon(Icons.report),
                            ),
                            // <-- Icon
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  " Cette action est définitive et irréversible ! ",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 14.5,
                    color: Color.fromARGB(255, 255, 110, 110),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Dites-nous pourquoi vous supprimez votre compte? ",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 18,
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10,),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      width: 1.0, color: Color.fromARGB(255, 158, 158, 158)),
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: Text('Motif *',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.w400,
                          fontSize: 17)),
                  value: dropdownMotif,
                  icon: const Icon(Icons.arrow_drop_down),
                  isExpanded: true,
                  elevation: 20,
                  style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  onChanged: (String? newValue) {
                    setState(() => dropdownMotif = newValue!);
                  },
                  items:
                      itemsMotif.map<DropdownMenuItem<String>>((String value) {
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
                labelText: 'Autres précisions :',
                labelStyle: TextStyle(
                    color: Colors.black87,
                    fontSize: 17,
                    fontFamily: 'AvenirLight'),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(221, 190, 190, 190), width: 2.0)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 0, 0, 0), width: 2.0)),
              ),
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 17,
                  fontFamily: 'AvenirLight'),
            ),
            SizedBox(
              height: 35,
            ),
            Text(
              "Etes-vous sur de vouloir supprimer votre compte ?",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 18,
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Confirmer votre mot de passe',
                labelStyle: TextStyle(
                    color: Colors.black87,
                    fontSize: 17,
                    fontFamily: 'AvenirLight'),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(221, 190, 190, 190), width: 2.0)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 0, 0, 0), width: 2.0)),
              ),
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 17,
                  fontFamily: 'AvenirLight'),
            ),
            SizedBox(height: 100,),
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
                    onPressed: () {},

                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 255, 110, 110),
                    ),

                    child: Text(
                      "Supprimer mon compte",
                      style: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.w400,
                      ),
                    ), //label text,
                  ),
                ),
              ),
            ))
          ])))
    ]));
  }
}
