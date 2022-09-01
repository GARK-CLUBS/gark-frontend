import 'package:flutter/material.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    this.text,
    this.text2,
    this.image,
  }) : super(key: key);
  final String? text, image, text2;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image.asset(
          image!,
          height: (185),
          width: (255),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          text!,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          text2!,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: Color.fromARGB(255, 183, 183, 183),
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
