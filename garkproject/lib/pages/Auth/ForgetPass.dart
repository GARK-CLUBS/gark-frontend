import 'package:flutter/material.dart';

class ForgetPass extends StatefulWidget {
  const ForgetPass({Key? key}) : super(key: key);

  @override
  State<ForgetPass> createState() => _ForgetPassState();
}

class _ForgetPassState extends State<ForgetPass> {
  @override
  Widget build(BuildContext context) {
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
                height: 600,
                width: MediaQuery.of(context).size.width - 10,
                margin: EdgeInsets.symmetric(horizontal: 0),
                child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    height: 354,
                    child: Column(
                      children: [
                        Text(
                          "Mot de passe oublié ?",
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Pour réinitialise votre mot de passe , entrez l'adresse email associée à votre compte",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 186, 186, 186),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Votre email:',
                            labelStyle: TextStyle(
                                color: Color.fromARGB(221, 190, 190, 190),
                                fontSize: 17,
                                fontFamily: 'AvenirLight'),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(221, 190, 190, 190),
                                    width: 2.0)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    width: 2.0)),
                          ),
                          style: TextStyle(
                              color: Color.fromARGB(221, 255, 255, 255),
                              fontSize: 17,
                              fontFamily: 'AvenirLight'),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ))),
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
                        primary: Color.fromARGB(
                            255, 14, 178, 120) //elevated btton background color
                        ),

                    child: Text(
                      "Réinitialiser",
                      style: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.w400,
                      ),
                    ), //label text,
                  ),
                ),
              ),
            )),
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
