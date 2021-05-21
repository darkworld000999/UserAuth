import 'package:flutter/material.dart';

import 'AuthorBox.dart';

class Authors extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 92.0,
      margin: EdgeInsets.only(top: 12.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (BuildContext context, int person) {
          if (person == 0) {
            return AuthorsBox(widgets: [
              SizedBox(height: 6.0),
              Text(
                'All',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ], bgcolor: Color(0xFF342FAE));
          }
          return AuthorsBox(
            bgcolor: Colors.white,
            widgets: [
              CircleAvatar(
                child: Icon(Icons.person),
              ),
              SizedBox(height: 6.0),
              Text(
                'Author name',
                style: TextStyle(
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          );
        },
      ),
    );
  }
}
