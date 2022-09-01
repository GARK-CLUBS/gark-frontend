import 'package:flutter/material.dart';
import 'package:garkproject/pages/Auth/Login.dart';
import 'package:garkproject/pages/Auth/Signup.dart';
import 'package:garkproject/pages/Equipe/AddEquipe.dart';

// This is the best practice
import 'splash_content.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Duration kAnimationDuration = Duration(milliseconds: 200);
  Color kPrimaryColor = Color.fromARGB(200,0,249,93);

  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Gérez comme un pro votre équipe de sport amateur",
      "text2": "",
      "image": "assets/GARK-LOGO icon + text.png"
    },
    {
      "text": "Gérez vos matchs & entrainements",
      "text2":
          "Créez vos évènements dans le calendrier , convoquez des membres et voyez leurs disponibilités",
      "image": "assets/cal.png"
    },
    {
      "text": "Communiquez avec votre équipe",
      "text2":
          "Discutez avec les membres par messagerie , soyez alerté par des notifications ou des emails",
      "image": "assets/Chat-icon.jpg"
    },
    {
      "text": "Analysez vos performances",
      "text2":
          "Toutes les statistiques de l'équipe , de chaque joueur et un bilan d'assiduité",
      "image": "assets/stats-icon.png"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color.fromARGB(255, 255, 255, 255),
        child: SafeArea(
          minimum: const EdgeInsets.all(20.0),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Spacer(),
                Expanded(
                  flex: 3,
                  child: PageView.builder(
                    onPageChanged: (value) {
                      setState(() {
                        currentPage = value;
                      });
                    },
                    itemCount: splashData.length,
                    itemBuilder: (context, index) => SplashContent(
                      image: splashData[index]["image"],
                      text: splashData[index]['text'],
                      text2: splashData[index]['text2'],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: (20)),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 80,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            splashData.length,
                            (index) => buildDot(index: index),
                          ),
                        ),
                         SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 250, // <-- Your width
                          child: Container(
                            // padding: EdgeInsets.only(top: 30),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (c) => Signup()));
                              },

                              style: ElevatedButton.styleFrom(
                                primary: Color.fromARGB(200,0,249,93),
                              ),

                              child: Text(
                                "Créer un compte",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(199, 255, 255, 255),
                                  fontWeight: FontWeight.w400,
                                ),
                              ), //label text,
                            ),
                          ),
                        ),
                          SizedBox(
                          height: 10,
                        ),
                        new GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (c) => Login()));
                          },
                          child: new Text(
                            "Connexion",
                            style: TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(200,0,249,93),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index
            ? kPrimaryColor
            : Color.fromARGB(255, 186, 186, 186),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
