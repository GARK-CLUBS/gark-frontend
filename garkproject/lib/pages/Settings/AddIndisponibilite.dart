import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddIndisponibilite extends StatefulWidget {
  const AddIndisponibilite({Key? key}) : super(key: key);

  @override
  State<AddIndisponibilite> createState() => _AddIndisponibiliteState();
}
int? selected;

TextEditingController dateinput = TextEditingController();
TextEditingController dateinput1 = TextEditingController();
String? dropdownMotif = null;
var itemsMotif = [
  'Vacances',
  'Malade',
  'Blessé',
  'Autre motif',
];

class _AddIndisponibiliteState extends State<AddIndisponibilite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
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
              'Nouvelle indisponibilités',
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
              height: 20,
            ),
            Align(
              alignment: Alignment(-1, 0),
              child: Text(
                "Informations",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextField(
              controller: dateinput, //editing controller of this TextField
              decoration: InputDecoration(
                labelText: "Du (inclus)*",
                labelStyle: const TextStyle(
                    color: Color.fromARGB(221, 146, 146, 146),
                    fontWeight: FontWeight.w400,
                    fontSize: 17),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(221, 190, 190, 190), width: 2.0)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 0, 0, 0), width: 2.0)),
              ),
              readOnly:
                  true, //set it true, so that user will not able to edit text
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(
                        2000), //DateTime.now() - not to allow to choose before today.
                    lastDate: DateTime(2101));

                if (pickedDate != null) {
                  print(
                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                  print(
                      formattedDate); //formatted date output using intl package =>  2021-03-16
                  //you can implement different kind of Date Format here according to your requirement

                  setState(() {
                    dateinput.text =
                        formattedDate; //set output date to TextField value.
                  });
                } else {
                  print("Date is not selected");
                }
              },
            ),
            TextField(
              controller: dateinput1, //editing controller of this TextField
              decoration: InputDecoration(
                labelText: "Au (inclus)*",
                labelStyle: const TextStyle(
                    color: Color.fromARGB(221, 146, 146, 146),
                    fontWeight: FontWeight.w400,
                    fontSize: 17),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(221, 190, 190, 190), width: 2.0)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 0, 0, 0), width: 2.0)),
              ),
              readOnly:
                  true, //set it true, so that user will not able to edit text
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(
                        2000), //DateTime.now() - not to allow to choose before today.
                    lastDate: DateTime(2101));

                if (pickedDate != null) {
                  print(
                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                  print(
                      formattedDate); //formatted date output using intl package =>  2021-03-16
                  //you can implement different kind of Date Format here according to your requirement

                  setState(() {
                    dateinput1.text =
                        formattedDate; //set output date to TextField value.
                  });
                } else {
                  print("Date is not selected");
                }
              },
            ),
            SizedBox(height: 10,),
                        Align(
              alignment: Alignment(-1, 0),
              child: Text(
                "Motif*",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 146, 146, 146),
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            SizedBox(height: 10,),

          gridv(),
            SizedBox(height: 10,),

            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Détails :',
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
          ]))),
          SizedBox(height: 150,), 
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
                "Enregistrer",
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
    ]));
  }
    Widget gridv() {
    final List<MenuData> menu = [
      MenuData(Icons.pool , 'Menu 1'),
      MenuData(Icons.sick, 'Menu 2'),
      MenuData(Icons.accessible_forward, 'Menu 3'),
      MenuData(Icons.create, 'Menu 4'),
      
    ];
    return Container(
        child: Scrollbar(
      thickness: 3,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              GridView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: menu.length,
                
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
 childAspectRatio: (1 / .4),

                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0),
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 0.2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: index == selected
                          ? BorderSide(
                              color: Color.fromARGB(255, 91, 188, 47)
                                  .withOpacity(0.60),
                              width: 2,
                            )
                          : new BorderSide(
                              width: 1,
                              color: Color.fromARGB(255, 144, 144, 144)
                                  .withOpacity(0.60),
                            ),
                    ),
                    child: InkWell(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            menu[index].icon,
                            size: 30,
                          ),
                        ],
                      ),
                      onTap: () => {
                        setState(() {
                          selected = index;
                        })
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class MenuData {
  MenuData(this.icon, this.title);
  final IconData icon;
  final String title;
}
