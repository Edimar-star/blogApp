import 'package:flutter/material.dart';

class Components {

  static Widget textFieldContainer(Widget child, BuildContext context) => Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    width: MediaQuery.of(context).size.width * 0.8,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.deepPurple.shade50,
      borderRadius: BorderRadius.circular(29)
    ),
    child: child,
  );

  static Widget roundedButton(String text, Future<dynamic> Function() press, BuildContext context) => Container(
    width: MediaQuery.of(context).size.width * 0.8,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(29),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          backgroundColor: Colors.deepPurple[300],
        ),
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  );

}