import 'dart:async';
import 'package:baatdilki/Screens/addDetails.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyEmail extends StatefulWidget {
  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  late Timer timer;
  late User user;
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    user = auth.currentUser!;
    timer = Timer.periodic(Duration(seconds: 3), (_) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/gif/clock.gif',
              height: 156.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: Text(
                'Please verify your email by clicking on get link ,\n if already verified press next',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async {
                    await user.sendEmailVerification();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 36.0,
                    width: MediaQuery.of(context).size.width / 4,
                    margin: EdgeInsets.symmetric(
                      horizontal: 4.0,
                      vertical: 18.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Text(
                      'Get link',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 12.0,
                ),
                InkWell(
                  onTap: () async {
                    await user.reload();
                    bool res = user.emailVerified;
                    if (res == true) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  addUserDetails(user: user)));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.yellow,
                          content: Text(
                            'Please verify your email that has been sent to ${user.email}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 36.0,
                    width: MediaQuery.of(context).size.width / 4,
                    margin: EdgeInsets.symmetric(
                      horizontal: 4.0,
                      vertical: 18.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Text(
                      'Next',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser!;
    await user.reload();
    if (user.emailVerified) {
      timer.cancel();
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => addUserDetails(user: user)));
    }
  }
}
