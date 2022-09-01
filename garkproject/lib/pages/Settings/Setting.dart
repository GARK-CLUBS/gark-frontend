import 'package:flutter/material.dart';
import 'package:garkproject/pages/Notifications/NotifParam.dart';
import 'package:garkproject/pages/Settings/BonPlans.dart';
import 'package:garkproject/pages/Settings/DeleteAccount.dart';
import 'package:garkproject/pages/Settings/Indiponibilites.dart';
import 'package:garkproject/pages/Settings/Newsletter.dart';
import 'package:garkproject/pages/Settings/UpdateProfile.dart';
import 'package:garkproject/pages/Splash/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
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
    return SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
        height: 20,
      ),
      Align(
        alignment: Alignment(-0.8, 0),
        child: Text(
          "Mon compte",
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
                  icon: const Icon(Icons.person),
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
                    "Mon compte",
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
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (c) => UpdateProfile()));
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
                icon: const Icon(Icons.calendar_month_outlined),
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
                  "Gérer mes indisponibilités",
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
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (c) => Indisponibilites()));
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
                  icon: const Icon(Icons.star_border_outlined),
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
                    "Abonnement",
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
                            print("add btn works !");
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
                    "Supprimer mon compte",
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
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (c) => DeleteAccount()));
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
          "Réglages",
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
                  icon: const Icon(Icons.notifications_none_rounded),
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
                    "Gérer mes notifications",
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
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (c) => const NotifParam()));
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
                  icon: const Icon(Icons.near_me),
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
                    "Newsletters",
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
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (c) => const Newsletter()));
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
                  icon: const Icon(Icons.data_exploration_sharp),
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
                    "Bons Plans",
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
       Navigator.of(context).push(MaterialPageRoute(
                                builder: (c) => const BonPlans()));                          },
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
          "Autres",
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
                  icon: const Icon(Icons.drive_folder_upload_outlined),
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
                    "Partager SportEasy",
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
                            print("add btn works !");
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
                  icon: const Icon(Icons.question_mark_sharp),
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
                    "Aide",
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
                            print("add btn works !");
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
        height: 8,
      ),
      Align(
        alignment: Alignment(0, 0),
        child: Text(
          "Version 1.0.0",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: Color.fromARGB(255, 191, 191, 191),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      SizedBox(
        height: 8,
      ),
      Align(
        alignment: Alignment(0, 0),
        child: Text(
          "Politique de confidentialité",
          textAlign: TextAlign.center,
          style: TextStyle(
            decoration: TextDecoration.underline,
            fontSize: 14,
            color: Color.fromARGB(255, 167, 167, 167),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      SizedBox(
        height: 10,
      ),
      new GestureDetector(
        onTap: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.remove("token");
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                //TODO LOGOUT

                return SplashScreen();
              },
            ),
          );
        },
        child: Align(
          alignment: Alignment(0, 0),
          child: Text(
            "Deconnexion",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Color.fromARGB(255, 255, 0, 0),
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    ]));
  }
}
