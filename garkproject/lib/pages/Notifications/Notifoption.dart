import 'package:custom_check_box/custom_check_box.dart';
import 'package:flutter/material.dart';

class Notifoption extends StatefulWidget {
  const Notifoption({Key? key, required this.majeures}) : super(key: key);
  final bool majeures;
  @override
  State<Notifoption> createState() => _NotifoptionState();
}

class _NotifoptionState extends State<Notifoption> {
  bool shouldCheckDefault = false;

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
          widget.majeures
              ? "Notifications majeures "
              : "Notifications mineures ",
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
          "Où voulez-vous les recevoir ?",
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
                        "Mobile",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Text(
                        "Vous les receverez sur votre mobile.\nSauf si vous n'étes pas connecté à l'appli \nou si l'appli ne gère pas encore\n ce type de notification",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey),
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
            SizedBox(
              height: 10,
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
                        "Email",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Text(
                        "Vous les receverez seulement sur votre email",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey),
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
            SizedBox(
              height: 10,
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
                        "Mobile + Email",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Text(
                        "Vous les receverez à la fois \nsur votre mobile et sur votre email",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey),
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
            SizedBox(
              height: 10,
            ),
            Container(
              height: 1,
              color: Color.fromARGB(255, 218, 218, 218),
            ),
            SizedBox(
              height: 10,
            ),
            // here
            if (widget.majeures == false) ...[
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Text(
                          "Ne rien recevoir",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Text(
                          "Vous ne recevrez aucune notification",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  CustomCheckBox(
                    checkBoxSize: 20,
                    value: shouldCheckDefault,
                    splashColor:
                        Color.fromARGB(255, 12, 248, 0).withOpacity(0.4),
                    tooltip: 'Custom Check Box',
                    splashRadius: 40,
                    onChanged: (bool value) {},
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ]
          ],
        ),
      ),
    ])));
  }
}
