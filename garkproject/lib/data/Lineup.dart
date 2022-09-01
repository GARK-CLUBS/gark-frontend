import 'package:flutter/material.dart';

class Lineup extends StatefulWidget {
  const Lineup({Key? key}) : super(key: key);

  @override
  State<Lineup> createState() => _LineupState();
}

Offset offset = Offset(0.0, 0.0);

List LineupList = [
  {
    "name": "Gardien",
    "top": 330.00,
    "left": 170.00,
    "topprev": 330.00,
    "leftprev": 170.00,
    "offset": Offset(170.00, 330.00),
    "image": "assets/2.jpg",
  },
  {
    "name": "cb",
    "top": 250.00,
    "left": 90.00,
    "topprev": 250.00,
    "leftprev": 90.00,
    "offset": Offset(90.00, 250.00),
    "image": "assets/1.png",

  },
  {
    "name": "cb",
    "top": 250.00,
    "left": 231.00,
    "topprev": 250.00,
    "leftprev": 231.00,
    "offset": Offset(231.00, 250.00),
    "image": "assets/3.png",

  },
  {
    "name": "mc",
    "top": 150.00,
    "left": 151.00,
    "topprev": 150.00,
    "leftprev": 151.00,
    "offset": Offset(151.00, 150.00),
    "image": "assets/4.jpg",

  },
  {
    "name": "at",
    "top": 20.00,
    "left": 201.00,
    "topprev": 20.00,
    "leftprev": 201.00,
    "offset": Offset(201.00, 20.00),
    "image": "assets/5.jpg",

  },
  {
    "name": "at",
    "top": 20.00,
    "left": 121.00,
    "topprev": 20.00,
    "leftprev": 121.00,
    "offset": Offset(121.00, 20.00),
    "image": "assets/3.png",

  },
  {
    "name": "Gardien",
    "top": 330.00,
    "left": 170.00,
    "topprev": 330.00,
    "leftprev": 170.00,
    "offset": Offset(170.00, 330.00),
    "image": "assets/2.jpg",
  },
  {
    "name": "cb",
    "top": 250.00,
    "left": 90.00,
    "topprev": 250.00,
    "leftprev": 90.00,
    "offset": Offset(90.00, 250.00),
    "image": "assets/1.png",

  },
  {
    "name": "cb",
    "top": 250.00,
    "left": 231.00,
    "topprev": 250.00,
    "leftprev": 231.00,
    "offset": Offset(231.00, 250.00),
    "image": "assets/3.png",

  },
  {
    "name": "mc",
    "top": 150.00,
    "left": 151.00,
    "topprev": 150.00,
    "leftprev": 151.00,
    "offset": Offset(151.00, 150.00),
    "image": "assets/4.jpg",

  },
  {
    "name": "at",
    "top": 20.00,
    "left": 201.00,
    "topprev": 20.00,
    "leftprev": 201.00,
    "offset": Offset(201.00, 20.00),
    "image": "assets/5.jpg",

  },

];
  
  List Remplacant1 = [
  {
    "name": "Gardien",
    "top": 330.00,
    "left": 170.00,
    "offset": offset,
    "image": "assets/5.jpg",

  },
  {
    "name": "Gardien",
    "top": 330.00,
    "left": 170.00,
    "offset": offset,
    "image": "assets/4.jpg",

  },
  {
    "name": "Gardien",
    "top": 330.00,
    "left": 170.00,
    "offset": offset,
    "image": " ",

  },
 
];

class _LineupState extends State<Lineup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
