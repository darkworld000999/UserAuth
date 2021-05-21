import 'package:baatdilki/Screens/CreateAccount.dart';
import 'package:baatdilki/Screens/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[200],
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome To ',
              style: TextStyle(
                fontSize: 36.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(),
              child: Image.asset(
                'assets/images/logo.png',
                width: 200.0,
                height: 200.0,
              ),
            ),
            SizedBox(
              height: 18.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  'SomeDomain',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '\t.com',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: Container(
                height: 56.0,
                width: 360.0,
                margin: EdgeInsets.only(
                  top: 12.0,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 0.8,
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green,
                      offset: Offset(0.0, 1.2),
                      blurRadius: 2.0,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 21.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 18.0,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreateAccount()));
              },
              child: Container(
                height: 56.0,
                width: 360.0,
                margin: EdgeInsets.symmetric(
                  vertical: 12.0,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black45,
                    width: 0.8,
                  ),
                  color: Colors.green[600],
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.shade900,
                      offset: Offset(0.0, 1.2),
                      blurRadius: 2.0,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'Create New Account',
                    style: TextStyle(
                      fontSize: 21.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            // SizedBox(
            //   child: Text(
            //     'Or ',
            //     style: TextStyle(
            //       fontWeight: FontWeight.w600,
            //       fontSize: 18.0,
            //     ),
            //   ),
            //   height: 24.0,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Image.asset(
            //       'assets/images/google-button.png',
            //       height: 72.0,
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
