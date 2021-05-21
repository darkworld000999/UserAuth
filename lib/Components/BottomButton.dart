import 'package:flutter/material.dart';

class BottomBtn extends StatelessWidget {
  Icon icon;
  Function tap;
  BottomBtn({required this.icon, required this.tap});
  @override
  Widget build(BuildContext context) {
    return IconButton(
      highlightColor: Colors.lightGreenAccent,
      color: Colors.grey[800],
      iconSize: 36.0,
      onPressed: () {
        tap;
      },
      icon: icon,
    );
  }
}
