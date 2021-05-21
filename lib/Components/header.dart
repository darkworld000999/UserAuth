import 'package:baatdilki/Components/Authors.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  TextEditingController searchText;
  Header({required this.searchText});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 2.0),
      decoration: BoxDecoration(
        color: Color(0xFFFCFAFA),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Find',
            style: TextStyle(
              color: Colors.blueGrey[900],
              fontWeight: FontWeight.w600,
              fontSize: 28.0,
            ),
          ),
          Text(
            'Your Topic\n',
            style: TextStyle(
              color: Colors.blueGrey[900],
              fontSize: 28.0,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0.0, 3.0),
                  color: Colors.grey.shade200,
                  blurRadius: 6,
                  spreadRadius: 1.4,
                ),
              ],
            ),
            child: ListTile(
              leading: IconButton(
                icon: Icon(
                  Icons.search,
                  color: Color(0xFF3A3491),
                ),
                onPressed: () {},
              ),
              title: TextField(
                controller: searchText,
                autofocus: false,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search for author , post or tag',
                ),
              ),
            ),
          ),
          Authors(),
        ],
      ),
    );
  }
}
