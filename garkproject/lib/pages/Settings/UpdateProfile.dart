import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

TextEditingController dateinput = TextEditingController();

class _UpdateProfileState extends State<UpdateProfile> {
  // late PickedFile _imageFile;
  // final ImagePicker _picker = ImagePicker();

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
              'Mon compte',
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
        child: Column(children: [
      SizedBox(
        height: 20,
      ),
      Align(
        alignment: Alignment(-0.8, 0),
        child: Text(
          "Mes informations",
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: 18,
            color: Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      SizedBox(
        height: 15,
      ),
      Stack(
        children: [
          Center(
            child: Material(
              color: Color.fromARGB(255, 145, 195, 236),
              elevation: 8,
              shape: CircleBorder(),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: InkWell(
                splashColor: Colors.black26,
                onTap: () {},
                child: Ink.image(
                  image: NetworkImage(
                      'https://sportbusiness.club/wp-content/uploads/2020/05/Football-Club-FC-Barcelone-1-678x381.jpg'),
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0.0,
            right: 150.0,
            child: CircleAvatar(
                radius: 16,
                backgroundColor: Color.fromARGB(255, 179, 179, 179),
                child: Align(
                  alignment: Alignment(-1, 1),
                  child: IconButton(
                    icon: Icon(
                      Icons.camera_alt,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: ((builder) => bottomsheet()),
                      );
                    },
                  ),
                )),
          ),
        ],
      ),
      Container(
          height: 400,
          width: MediaQuery.of(context).size.width - 10,
          margin: EdgeInsets.symmetric(horizontal: 0),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 30),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 354,
            child: Column(children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nom:',
                  labelStyle: TextStyle(
                      color: Color.fromARGB(221, 146, 146, 146),
                      fontSize: 17,
                      fontFamily: 'AvenirLight'),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(221, 190, 190, 190),
                          width: 2.0)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 0, 0, 0), width: 2.0)),
                ),
                style: TextStyle(
                    color: Color.fromARGB(221, 255, 255, 255),
                    fontSize: 17,
                    fontFamily: 'AvenirLight'),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Prenom:',
                  labelStyle: TextStyle(
                      color: Color.fromARGB(221, 146, 146, 146),
                      fontSize: 17,
                      fontFamily: 'AvenirLight'),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(221, 190, 190, 190),
                          width: 2.0)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 0, 0, 0), width: 2.0)),
                ),
                style: TextStyle(
                    color: Color.fromARGB(221, 255, 255, 255),
                    fontSize: 17,
                    fontFamily: 'AvenirLight'),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email:',
                  labelStyle: TextStyle(
                      color: Color.fromARGB(221, 146, 146, 146),
                      fontSize: 17,
                      fontFamily: 'AvenirLight'),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(221, 190, 190, 190),
                          width: 2.0)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 0, 0, 0), width: 2.0)),
                ),
                style: TextStyle(
                    color: Color.fromARGB(221, 255, 255, 255),
                    fontSize: 17,
                    fontFamily: 'AvenirLight'),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Telephone:',
                  labelStyle: TextStyle(
                      color: Color.fromARGB(221, 146, 146, 146),
                      fontSize: 17,
                      fontFamily: 'AvenirLight'),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(221, 190, 190, 190),
                          width: 2.0)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 0, 0, 0), width: 2.0)),
                ),
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 17,
                    fontFamily: 'AvenirLight'),
              ),
              TextField(
                controller: dateinput, //editing controller of this TextField
                decoration: InputDecoration(
                  labelText: "Année d'arrivée",
                  labelStyle: const TextStyle(
                      color: Color.fromARGB(221, 146, 146, 146),
                      fontWeight: FontWeight.w400,
                      fontSize: 17),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(221, 190, 190, 190),
                          width: 2.0)),
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
            ]),
          )),
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
      )),
    ]));
  }

  // void takePhoto(ImageSource source) async {
  //   final pickedFile = await _picker.getImage(
  //     source: source,
  //   );
  //   setState(() {
  //   //  _imageFile = pickedFile!;
  //   });
  // }

  Widget bottomsheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile photo ",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: <Widget>[
              FlatButton.icon(
                  onPressed: () {
                    // takePhoto(
                    //   ImageSource.gallery,
                    // );
                  },
                  icon: Icon(Icons.image),
                  label: Text("Gallery")),
              FlatButton.icon(
                  onPressed: () {
                    // takePhoto(
                    //   ImageSource.camera,
                    // );
                  },
                  icon: Icon(Icons.camera),
                  label: Text("Camera"))
            ],
          )
        ],
      ),
    );
  }
}
