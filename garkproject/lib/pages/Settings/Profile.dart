import 'package:flutter/material.dart';
import 'package:garkproject/data/TacheAssigneddata.dart';
import 'package:garkproject/pages/Settings/Setting.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          Column(children: <Widget>[
            Stack(children: <Widget>[
              Container(
                height: 170,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 2, 0, 50),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(36),
                      bottomRight: Radius.circular(36),
                    )),
              ),
              Center(
                child: Container(
                    height: 180,
                    width: MediaQuery.of(context).size.width - 40,
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 15,
                              spreadRadius: 5)
                        ]),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(children: [
                        Spacer(),
                        Column(
                          children: [
                            SizedBox(height: 20),

                            Text(
                              "Slim Ayadi ",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                            // a blue line
                            /*  Container(
                            height: 5,
                            width: 190,
                            color: Color.fromARGB(255, 2, 0, 50),
                          ),*/
                            SizedBox(height: 05),
                            Text(
                              "Joueur-Coach",
                              style: TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),

                            SizedBox(height: 05),
                            Text(
                              "2021-2022",
                              style: TextStyle(
                                fontSize: 12,
                                color: Color.fromARGB(255, 96, 96, 96),
                              ),
                            ),
                            SizedBox(height: 20),
                            IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Taille",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color.fromARGB(255, 96, 96, 96),
                                    ),
                                  ),
                                  VerticalDivider(
                                    color: Colors.black,
                                    thickness: 1,
                                  ),
                                  Text(
                                    "N° de maillot",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color.fromARGB(255, 96, 96, 96),
                                    ),
                                  ),
                                  VerticalDivider(
                                    color: Colors.black,
                                    thickness: 1,
                                  ),
                                  Text(
                                    "License",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color.fromARGB(255, 96, 96, 96),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 50,
                            ),
                            Column(children: [
                              IconButton(
                                  icon: const Icon(Icons.settings),
                                  color: Color.fromARGB(255, 168, 168, 168),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (c) => Setting()));
                                  })
                            ]),
                          ],
                        )
                      ]),
                    )),
              ),
              Center(
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://sportbusiness.club/wp-content/uploads/2020/05/Football-Club-FC-Barcelone-1-678x381.jpg"),
                          fit: BoxFit.cover)),
                ),
              ),
            ]),
            Align(
              alignment: Alignment(-0.8, 0),
              child: Text(
                "Mes résultats",
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                height: 180,
                width: MediaQuery.of(context).size.width - 40,
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 3)
                    ]),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment(0, -0.5),
                      child: Text(
                        "0",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 34,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment(0, -0.5),
                      child: Text(
                        "match joué",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 139, 139, 139),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Row(
                      children: [
                        Spacer(),
                        SizedBox(
                          height: 70,
                          width: 70,
                          child: Stack(fit: StackFit.expand, children: [
                            CircularProgressIndicator(
                              value: 0,
                              backgroundColor: Colors.grey,
                              strokeWidth: 8,
                            ),
                            Center(
                                child: Text(
                              "0 \n victoires",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                          ]),
                        ),
                        Spacer(),
                        SizedBox(
                          height: 70,
                          width: 70,
                          child: Stack(fit: StackFit.expand, children: [
                            CircularProgressIndicator(
                              value: 0,
                              backgroundColor: Colors.grey,
                              strokeWidth: 8,
                            ),
                            Center(
                                child: Text(
                              "0 \n defaite",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                          ]),
                        ),
                        Spacer(),
                        SizedBox(
                          height: 70,
                          width: 70,
                          child: Stack(fit: StackFit.expand, children: [
                            CircularProgressIndicator(
                              value: 0,
                              backgroundColor: Colors.grey,
                              strokeWidth: 8,
                            ),
                            Center(
                                child: Text(
                              "0 \n null",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                          ]),
                        ),
                        Spacer(),
                      ],
                    )
                  ],
                )),
            SizedBox(
              height: 10,
            ),
            // avantages garkclub
            // Align(
            //   alignment: Alignment(-0.8, 0),
            //   child: Text(
            //     "Avantages GarkCLUB",
            //     textAlign: TextAlign.right,
            //     style: TextStyle(
            //       fontSize: 16,
            //       color: Color.fromARGB(255, 0, 0, 0),
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            // Expanded(
            //   child: ListView(
            //     scrollDirection: Axis.horizontal,
            //     children: [
            //       Container(
            //           margin:
            //               const EdgeInsets.only(left: 15, bottom: 190, right: 10),
            //           width: 344,
            //           height: 109,
            //           color: Color.fromARGB(255, 193, 55, 55),
            //           alignment: Alignment.center,
            //           child: const Text(
            //             '2',
            //             style: TextStyle(fontSize: 10),
            //           )),
            //       Container(
            //           margin:
            //               const EdgeInsets.only(left: 15, bottom: 190, right: 15),
            //           width: 344,
            //           height: 109,
            //           color: Color.fromARGB(255, 78, 34, 34),
            //           alignment: Alignment.center,
            //           child: const Text(
            //             '2',
            //             style: TextStyle(fontSize: 10),
            //           )),
            //     ],
            //   ),
            // ),
            Align(
              alignment: Alignment(-0.8, 0.5),
              child: Text(
                "Mes statistiques",
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),

            Row(
              children: [
                Container(
                    height: 80,
                    width: 110,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              spreadRadius: 3)
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "2",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 29),
                            ),
                            Text("buts")
                          ]),
                    )),
                Container(
                    height: 80,
                    width: 110,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              spreadRadius: 3)
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "2",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 29),
                            ),
                            Text("pd")
                          ]),
                    )),
              ],
            ),

            SizedBox(
              height: 10,
            ),

            Align(
              alignment: Alignment(-0.8, 0.5),
              child: Text(
                "Homme du match",
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                height: 140,
                width: MediaQuery.of(context).size.width - 40,
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 3)
                    ]),
                child: Column(children: [
                  SizedBox(
                    height: 20,
                  ),
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 30.0,
                        backgroundImage: NetworkImage(
                            "https://www.simplilearn.com/ice9/free_resources_article_thumb/what_is_image_Processing.jpg"),
                        backgroundColor: Colors.transparent,
                      ),
                      Positioned(
                          bottom: -10,
                          right: -10,
                          child: RawMaterialButton(
                            constraints: BoxConstraints.tight(Size(26, 26)),
                            onPressed: () {},
                            fillColor: Color.fromARGB(255, 255, 238, 57),
                            child: IconTheme(
                              data: IconThemeData(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  size: 16),
                              child: Icon(Icons.star),
                            ),
                            shape: CircleBorder(),
                          )),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 7),
                    child: Column(
                      children: [
                        Text(
                          "Slim Ayadi",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          "1 voix sur 1 votants",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 122, 122, 122)),
                        ),
                      ],
                    ),
                  ),
                ])),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment(-0.8, 0.5),
              child: Text(
                "Mes notes",
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                height: 100,
                width: MediaQuery.of(context).size.width - 40,
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 3)
                    ]),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset("assets/statss.PNG"),
                      Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Max.",
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "-",
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Moy.",
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "-",
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Min.",
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "-",
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                    ])),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment(-0.8, 0.5),
              child: Text(
                "Mes derniers matchs",
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                height: 76,
                width: MediaQuery.of(context).size.width - 40,
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 3)
                    ]),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 18.0, horizontal: 10),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: TacheassignedList.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return InkWell(
                            onTap: () {
                              print("edit tache");
                            },
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Stack(
                                      children: [
                                        CircleAvatar(
                                          radius: 20.0,
                                          child: Text(
                                              TacheassignedList[index]["etat"],
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18)),
                                          backgroundColor:
                                              TacheassignedList[index]
                                                          ["color"] ==
                                                      "green"
                                                  ? Colors.green
                                                  : Colors.red,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                              ],
                            ));
                      }),
                )),
            SizedBox(
              height: 20,
            ),
          ])
        ],
      ),
    ));
  }
}
