import 'package:flutter/material.dart';
import 'package:garkproject/pages/Calendrier/Calendrier.dart';
import 'package:garkproject/pages/Calendrier/CalendrierDetail.dart';
import 'package:garkproject/pages/Notifications/NotifParam.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: getBody(context),
    );
  }

  SingleChildScrollView getBody(BuildContext context) {
    return SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Column(children: <Widget>[
        Container(
            child: Stack(children: <Widget>[
          Container(
            // 160
            height: 80,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 2, 0, 50),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 30,
            right: 0,
            child: Container(
                child: Row(
              children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        //display club
                        "Notifications",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w600),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (c) => const NotifParam()));
                        },
                        child: const Text(
                          "Modifier les paramètres",
                          style: TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(197, 58, 200, 110),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ]),
                Spacer(),
                RawMaterialButton(
                  constraints: BoxConstraints.tight(Size(26, 26)),
                  onPressed: () {
                    notifaction(context, true);
                  },
                  child: IconTheme(
                    data: IconThemeData(
                        color: Color.fromARGB(255, 255, 255, 255), size: 26),
                    child: Icon(Icons.more_vert),
                  ),
                  shape: CircleBorder(),
                )
              ],
            )),
          ),
        ])),
        InkWell(
          onTap: ()=>{
            //  Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (context) => CalendrierDetail()),
            //   ).then((value) => setState(() {}))
          },
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30.0,
                          backgroundImage: NetworkImage(
                              "https://www.simplilearn.com/ice9/free_resources_article_thumb/what_is_image_Processing.jpg"),
                          backgroundColor: Colors.transparent,
                        ),
                        SizedBox(
                          width: 15,
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              child: Text(
                                "Slim ayadi",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color.fromARGB(255, 136, 136, 136),
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Container(
                              constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.63),
                              child: Text(
                                "Renseignez vos stats pour le   match entre nous du jeudi 21 juillet",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                            )
                          ],
                        ),

                        // when clicked yelzem bottom bar fiha update
                        Spacer(),
                        SizedBox.fromSize(
                          child: ClipOval(
                            child: Material(
                              color: Color.fromARGB(255, 255, 255, 255),
                              child: InkWell(
                                splashColor: Color.fromARGB(255, 255, 255, 255),
                                onTap: () {
                                  notifaction(context, false);
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    IconTheme(
                                      data: IconThemeData(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          size: 28),
                                      child: Icon(Icons.more_vert),
                                    ),
                                    // <-- Icon
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]))),
        ),
        Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Flexible(
              child: Divider(
                thickness: 0.5,
                color: Color.fromARGB(255, 166, 166, 166),
              ),
            ),
            SizedBox(
              width: 10,
            ),
          ],
        )
      ])
    ]));
  }

  void notifaction(BuildContext context, bool etat) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (context) {
        return Wrap(children: [
          Column(
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 255, 255, 255),
                    ),

                    child: Text(
                      "Tout supprimer",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 194, 68, 68),
                        fontWeight: FontWeight.w400,
                      ),
                    ), //label text,
                  )),
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(197, 58, 200, 110),
                    ),

                    child: Text(
                      "Fermer",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.w400,
                      ),
                    ), //label text,
                  )),
            ],
          )
        ]);
      },
    );
  }
}
