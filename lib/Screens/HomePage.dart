import 'package:baatdilki/Components/BottomPanel.dart';
import 'package:baatdilki/Components/header.dart';
import 'package:baatdilki/Screens/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

bool notification_on = false;
TextEditingController searchText = TextEditingController();

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'BlogAppName',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              notification_on
                  ? Icons.notifications
                  : Icons.notifications_outlined,
              color: Color(0xFF57AF00),
            ),
          ),
          IconButton(
            onPressed: () async {
              FirebaseAuth auth = FirebaseAuth.instance;
              await auth.signOut();
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Welcome()));
            },
            icon: Icon(
              Icons.logout,
              color: Color(0xFF57AF00),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Header(
              searchText: searchText,
            ),
            SizedBox(
              height: 12.0,
            ),
            Explore(),
          ],
        ),
      ),
      bottomNavigationBar: BottomPanel(),
    );
  }
}

class Explore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 18.0),
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          Text(
            'Explore',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 36.0,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}
