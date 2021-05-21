import 'dart:async';
import 'dart:io';
import 'package:baatdilki/Screens/HomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class addUserDetails extends StatefulWidget {
  User user;
  addUserDetails({required this.user});
  @override
  _addUserDetailsState createState() => _addUserDetailsState();
}

class _addUserDetailsState extends State<addUserDetails> {
  final auth = FirebaseAuth.instance;
  File? _image;
  ImagePicker picker = ImagePicker();
  bool male = true;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool female = false;
  bool loading = true;
  DateTime dob = DateTime.now();
  FirebaseStorage storage = FirebaseStorage.instance;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadPic() async {
    Reference storageRef = storage
        .ref()
        .child('Profile_Picture')
        .child(widget.user.email!)
        .child('profileImage.jpg');
    UploadTask uploadTask = storageRef.putFile(_image!);
    var imageUrl = await (await uploadTask).ref.getDownloadURL();
    String url = imageUrl.toString();
    return url;
  }

  Future<bool> updateUserData(Map<String, dynamic> data) async {
    await firestore.collection('users').doc(widget.user.email).update(data);
    return true;
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: dob,
      firstDate: DateTime(1947, 1, 1),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        dob = picked;
      });
    }
  }

  exist() {
    firestore.collection('users').doc(widget.user.email).get().then((value) {
      if (value.exists) {
        if (value.data()!['profile_url'] != null) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        } else {
          setState(() {
            loading = false;
          });
        }
      }
    });
  }

  @override
  void initState() {
    exist();
    super.initState();
  }

  @override
  void dispose() {
    setState(() {
      loading = false;
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: loading
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.blue,
                ),
              )
            : Center(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 32.0,
                        child: Text(
                          'Select your profile image',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black45,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      _image != null
                          ? InkWell(
                              onTap: getImage,
                              child: CircleAvatar(
                                backgroundColor: Colors.grey[400],
                                radius: 56.0,
                                backgroundImage: FileImage(_image!),
                              ),
                            )
                          : InkWell(
                              onTap: getImage,
                              child: CircleAvatar(
                                backgroundColor: Colors.grey[400],
                                radius: 56.0,
                                child: Icon(
                                  Icons.add_a_photo,
                                  color: Colors.black,
                                  size: 36.0,
                                ),
                              ),
                            ),
                      SizedBox(
                        height: 36.0,
                      ),
                      SizedBox(
                        height: 32.0,
                        child: Text(
                          'Select your gender',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black45,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                male = true;
                                female = false;
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 132.0,
                              height: 42.0,
                              color: male ? Colors.blue : Colors.blue[100],
                              child: Text(
                                'Male',
                                style: TextStyle(
                                  fontSize: 21.0,
                                  fontWeight: FontWeight.bold,
                                  color: male ? Colors.white : Colors.black45,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                male = false;
                                female = true;
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 132.0,
                              height: 42.0,
                              color: female ? Colors.blue : Colors.blue[100],
                              child: Text(
                                'Female',
                                style: TextStyle(
                                  fontSize: 21.0,
                                  fontWeight: FontWeight.bold,
                                  color: female ? Colors.white : Colors.black45,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 28.0,
                      ),
                      SizedBox(
                        height: 32.0,
                        child: Text(
                          'Select your date of birth',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black45,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          await _selectDate(context);
                        },
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          margin: EdgeInsets.only(
                            left: 36.0,
                            right: 36.0,
                            bottom: 28.0,
                          ),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 0.8,
                            ),
                          ),
                          child: Text(
                            dob.year.toString() +
                                ' - ' +
                                dob.month.toString() +
                                ' - ' +
                                dob.day.toString(),
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          if (dob.day == DateTime.now().day &&
                              dob.month == DateTime.now().month &&
                              dob.year == DateTime.now().year) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.yellow,
                                content: Text(
                                  'Please select valid Date of Birth',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            );
                          } else {
                            setState(() {
                              loading = true;
                            });
                            String url = await uploadPic();
                            Map<String, dynamic> data = {
                              'DOB': dob,
                              'gender': male ? 'male' : 'female',
                              'profile_url': url,
                            };
                            bool task = await updateUserData(data);
                            if (task == true) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()));
                            } else {
                              setState(() {
                                loading = false;
                              });
                            }
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 42.0,
                          margin: EdgeInsets.symmetric(horizontal: 28.0),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Text(
                            'Confirm',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ));
  }

  bool checkDOB() {
    if (dob.day == DateTime.now().day &&
        dob.month == DateTime.now().month &&
        dob.year == DateTime.now().year) {
      return false;
    } else {
      return true;
    }
  }
}
