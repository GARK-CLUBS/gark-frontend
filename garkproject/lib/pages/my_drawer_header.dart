import 'package:flutter/material.dart';

class MyHeaderDrawer extends StatefulWidget {
  @override
  _MyHeaderDrawerState createState() => _MyHeaderDrawerState();
}

class _MyHeaderDrawerState extends State<MyHeaderDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 2, 0, 50),
      width: double.infinity,
      height: 250,
      padding: EdgeInsets.only(top: 50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(
                    "https://sportbusiness.club/wp-content/uploads/2020/05/Football-Club-FC-Barcelone-1-678x381.jpg"),
              ),
            ),
          ),
          Text(
            "FC Barcelona",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          Text(
            "Barcelona@Barcelona.es",
            style: TextStyle(
              color: Colors.grey[200],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
