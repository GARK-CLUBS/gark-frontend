import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TJ extends StatefulWidget {
  const TJ({Key? key}) : super(key: key);

  @override
  State<TJ> createState() => _TJState();
}

int nb1 = 0;
int nb2 = 0;

class _TJState extends State<TJ> {
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
      title: Row(children: <Widget>[
        Spacer(),
        Text(
          'Temps joué',
          textAlign: TextAlign.center,
          style: TextStyle(),
        ),
          Spacer(),
        IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 2, 0, 50),
          ),
          onPressed: () => {},
        ),
        Padding(
          padding: const EdgeInsets.only(right: 0),
          child: IconButton(
              icon: new Icon(Icons.save_as_outlined), onPressed: () {}),
        )
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
          "Joueurs présents",
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: 18,
            color: Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Column(children: [
                Row(children: [
                  CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(
                        "https://www.simplilearn.com/ice9/free_resources_article_thumb/what_is_image_Processing.jpg"),
                    backgroundColor: Colors.transparent,
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
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      InkWell(
                        child: Container(
                          width: 40,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                  width: 1,
                                  color: Color.fromARGB(255, 97, 204, 35))),
                          child: Icon(
                            FontAwesomeIcons.minus,
                            color: Color.fromARGB(255, 97, 204, 35),
                            size: 24,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            if (nb1 <= 0) {
                              nb1 = 0;
                            } else {
                              nb1--;
                            }
                          });
                        },
                      ),
                      Container(
                        width: 40,
                        height: 26,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            border: Border.all(
                                width: 1,
                                color: Color.fromARGB(255, 97, 204, 35))),
                        child: Text(nb1.toString(),style: TextStyle(fontSize: 16),textAlign: TextAlign.center,),
                      ),
                      InkWell(
                        child: Container(
                          width: 40,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                  width: 1,
                                  color: Color.fromARGB(255, 97, 204, 35))),
                          child: Icon(Icons.add,
                              color: Color.fromARGB(255, 97, 204, 35)),
                        ),
                        onTap: () {
                          setState(() {
                            if (nb1 <= 0) {
                              nb1 = 0;
                            }
                            nb1++;
                          });
                        },
                      ),
                    ],
                  ),
                ])
              ])))
    ]));
  }
}
