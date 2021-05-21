import 'package:baatdilki/Screens/verifyEmail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController Cpass = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool passEnabled = true;
  bool CpassEnabled = true;
  bool loading = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  Future<bool> uploadUserData(Map<String, dynamic> data) async {
    await firestore.collection('users').doc(email.text.trim()).set(data);
    return true;
  }

  signup(String email, String pass) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      Map<String, dynamic> data = {
        'username': username.text.trim(),
        'email_address': email,
        'DOB': null,
        'gender': null,
        'profile_url': null,
      };
      bool uploaded = await uploadUserData(data);
      setState(() {
        loading = false;
      });
      if (uploaded) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => VerifyEmail()));
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        loading = false;
      });
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text('The password is too weak'),
        ));
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text('The email address is already in-use'),
        ));
      }
    } catch (e) {
      setState(() {
        loading = false;
      });
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade200,
      body: SafeArea(
        child: loading
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              )
            : Stack(
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
                                  'Join now by ',
                                  style: TextStyle(
                                    fontSize: 32.0,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: Text(
                                  'Creating your new account \n',
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
                    height: MediaQuery.of(context).size.height * 0.56,
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
                              hintText: 'Username',
                              alignLabelWithHint: true,
                              contentPadding: EdgeInsets.all(8.0),
                              border: InputBorder.none,
                              icon: Icon(
                                Icons.person,
                                color: Colors.black,
                              ),
                            ),
                            controller: username,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            left: 14.0,
                            right: 14.0,
                            top: 21.0,
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
                            decoration: InputDecoration(
                              focusedBorder: InputBorder.none,
                              hintText: 'Email address',
                              alignLabelWithHint: true,
                              contentPadding: EdgeInsets.all(8.0),
                              border: InputBorder.none,
                              icon: Icon(
                                Icons.email,
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
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 14.0,
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
                            controller: Cpass,
                            autofocus: false,
                            obscureText: CpassEnabled,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  !CpassEnabled
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  if (CpassEnabled) {
                                    setState(() {
                                      CpassEnabled = false;
                                    });
                                  } else {
                                    setState(() {
                                      CpassEnabled = true;
                                    });
                                  }
                                },
                              ),
                              hintText: 'Confirm Password',
                              alignLabelWithHint: true,
                              contentPadding: EdgeInsets.all(8.0),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              icon: Icon(
                                Icons.lock,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 18.0,
                        ),
                        InkWell(
                          onTap: () {
                            if (username.text.trim() == '') {
                              print('Username is blank');
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('Username is blank'),
                                backgroundColor: Colors.red[800],
                              ));
                            } else if (email.text.trim() == '') {
                              print('Email is blank');
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('Email is blank'),
                                backgroundColor: Colors.red[800],
                              ));
                            } else if (!email.text.contains('@')) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('Invalid email addresss.'),
                                backgroundColor: Colors.red[800],
                              ));
                            } else if (!email.text.contains('.com')) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('Invalid email addresss.'),
                                backgroundColor: Colors.red[800],
                              ));
                            } else if (pass.text.trim() == '') {
                              print('Pass Blank');
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('Password is blank'),
                                backgroundColor: Colors.red[800],
                              ));
                            } else if (Cpass.text.trim() == '') {
                              print('Confirm pass is blank');
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('Confirm Password is blank'),
                                backgroundColor: Colors.red[800],
                              ));
                            } else if (pass.text.trim() != Cpass.text.trim()) {
                              print('Password  does not match');
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('Password does not match'),
                                backgroundColor: Colors.red[800],
                              ));
                            } else {
                              setState(() {
                                loading = true;
                              });
                              print('creating...');
                              signup(email.text.trim(), Cpass.text.trim());
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 48.0,
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 14.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                color: Colors.red,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 0.6,
                                )),
                            child: Text(
                              'Create',
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
                        Text(
                          "By clicking on ' create ' you will be agree \nto our terms and conditions.",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
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
