import 'package:baatdilki/Screens/verifyEmail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool passEnabled = true;
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  signIn(String email, String pass) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => VerifyEmail()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.blue,
          content: Text('Account not found . Please create your account'),
        ));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.blue,
          content: Text('Password is incorrent'),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          size: 20.0,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Text(
                        'Back',
                        style: TextStyle(
                          fontSize: 21.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/logo.png',
                          height: 136.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Text(
                            'Proceed with your',
                            style: TextStyle(
                              fontSize: 32.0,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Text(
                            'Login \n',
                            style: TextStyle(
                              fontSize: 36.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height / 2,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28.0),
                  topRight: Radius.circular(28.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 14.0),
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(
                        color: Colors.black,
                        width: 0.4,
                      ),
                    ),
                    child: TextField(
                      autofocus: false,
                      decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        hintText: 'Email address',
                        alignLabelWithHint: true,
                        contentPadding: EdgeInsets.all(8.0),
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.person_outline,
                          color: Colors.black,
                        ),
                      ),
                      controller: email,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 14.0,
                      vertical: 21.0,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(
                        color: Colors.black,
                        width: 0.4,
                      ),
                    ),
                    child: TextField(
                      autofocus: false,
                      obscureText: passEnabled,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            !passEnabled
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            if (passEnabled) {
                              setState(() {
                                passEnabled = false;
                              });
                            } else {
                              setState(() {
                                passEnabled = true;
                              });
                            }
                          },
                        ),
                        hintText: 'Password',
                        alignLabelWithHint: true,
                        contentPadding: EdgeInsets.all(8.0),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        icon: Icon(
                          Icons.lock,
                          color: Colors.black,
                        ),
                      ),
                      controller: pass,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (email.text.trim() == '') {
                        print('Email is blank');
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Email is blank'),
                          backgroundColor: Colors.blue[800],
                        ));
                      } else if (!email.text.contains('@ ') &&
                          !email.text.contains('.com')) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Invalid email address.'),
                          backgroundColor: Colors.blue[800],
                        ));
                      } else if (pass.text.trim() == '') {
                        print('Password is blank');
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Password is blank'),
                          backgroundColor: Colors.blue[800],
                        ));
                      } else {
                        print('Creating ...');
                        signIn(email.text.trim(), pass.text.trim());
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 48.0,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 14.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: Colors.blue,
                          border: Border.all(
                            color: Colors.black,
                            width: 0.6,
                          )),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  InkWell(
                    child: Text(
                      'Or forgot password ?',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
