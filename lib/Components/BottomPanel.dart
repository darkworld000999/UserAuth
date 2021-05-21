import 'package:baatdilki/Components/BottomButton.dart';
import 'package:baatdilki/Screens/profilePage.dart';
import 'package:flutter/material.dart';

class BottomPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(21.0),
          topRight: Radius.circular(21.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 4.0,
            offset: Offset(0.0, -2.0),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.ideographic,
        children: [
          BottomBtn(
            icon: Icon(Icons.home_outlined),
            tap: () {},
          ),
          BottomBtn(
            icon: Icon(
              Icons.add_circle,
              size: 56.0,
              color: Color(0xFFFE5732),
            ),
            tap: () {},
          ),
          BottomBtn(
            icon: Icon(Icons.person_outline),
            tap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfilePage()));
            },
          ),
        ],
      ),
    );
  }
}
