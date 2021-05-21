import 'package:flutter/material.dart';

class AuthorsBox extends StatelessWidget {
  List<Widget> widgets = [];
  Color bgcolor;
  AuthorsBox({required this.widgets, required this.bgcolor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 84.0,
      height: 78.0,
      margin: EdgeInsets.only(right: 12.0),
      padding: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: bgcolor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: widgets,
      ),
    );
  }
}
