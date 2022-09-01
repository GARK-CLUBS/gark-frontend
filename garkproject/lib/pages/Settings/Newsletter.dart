import 'package:custom_check_box/custom_check_box.dart';
import 'package:flutter/material.dart';

class Newsletter extends StatefulWidget {
  const Newsletter({Key? key}) : super(key: key);

  @override
  State<Newsletter> createState() => _NewsletterState();
}

bool shouldCheckDefault = false;

class _NewsletterState extends State<Newsletter> {
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
          "Newsletters",
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
          "Newsletters",
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
        child: Column(children: [
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
                      "Gark",
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
                      "Recevoir les informations au sujet des nouveautés\n de gark",
                      style: TextStyle(
                          fontSize: 13,
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
                      "Offres partenaires",
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
                      "Vous receverez des offres négociées \npour vous par GARK auprès de ses partenaires.",
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
          SizedBox(
            height: 10,
          ),
        ]),
      ),
    ])));
  }
}
