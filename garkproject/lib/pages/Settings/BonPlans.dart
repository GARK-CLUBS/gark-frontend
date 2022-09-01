import 'package:custom_check_box/custom_check_box.dart';
import 'package:flutter/material.dart';

class BonPlans extends StatefulWidget {
  const BonPlans({Key? key}) : super(key: key);

  @override
  State<BonPlans> createState() => _BonPlansState();
}
bool shouldCheckDefault = false;

class _BonPlansState extends State<BonPlans> {
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
          "Bon Plans",
          style: TextStyle(),
        ),
        Spacer(),
      ]),
    );
  }

  Widget getBody() {
    return SingleChildScrollView(
        child: Container(
          color: Colors.white,
            child: Column(children: [
      Image.asset(
        "assets/bonplans.PNG",
        width: MediaQuery.of(context).size.width,
      ),
  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 15),
                    child: Text(
                      "En désactivant les bons plans de votre profil , vous ne pourrez plus profiter des promotions que nous avons négociées pour notre communauté. Vous pouvez réactiver la présence des bons plans à tout moment",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 50, 50, 50)),
                    ),
                  ),
                     Container(
              height: 1,
              color: Color.fromARGB(255, 218, 218, 218),
            ),
            SizedBox(
              height: 10,
            ),
                Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Text(
                      "Afficher les bons plans",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ),
              
                ],
              ),
              Spacer(),
              CustomCheckBox(
                checkBoxSize: 20,
                value: shouldCheckDefault,
                splashColor: Color.fromARGB(255, 12, 248, 0).withOpacity(0.4),
                tooltip: 'Custom Check Box',
                splashRadius: 40,
                onChanged: (bool value) {},
              ),
            ],
          ),
    ])));
  }
}
