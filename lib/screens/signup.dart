import 'dart:io';

import 'package:doctor_consultation_app/constant.dart';
import 'package:doctor_consultation_app/screens/home_doctor.dart';
import 'package:doctor_consultation_app/screens/home_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:gradient_text/gradient_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _description = TextEditingController();

  String type;
  String department;

  final picker = ImagePicker();
  File image;

  String imgurl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(color: Colors.grey[900]),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Align(
                  alignment: Alignment.topRight,
                  child: Image.asset(
                    "assets/blob.jpeg",
                  )),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 180, left: 30),
                      child:
                          // Text('Login',
                          //     style: TextStyle(
                          //         fontSize: 40,
                          //         fontWeight: FontWeight.bold,
                          //         color: Colors.black87)),
                          GradientText("SignUp",
                              gradient: LinearGradient(colors: [
                                Color(4294493271),
                                Color(4294681407)
                              ]),
                              style: TextStyle(
                                  fontSize: 37,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87))),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Text('Please signup to continue',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Color(4288914861))),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 8.0, left: 30, right: 30),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'Name',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Color(4288914861), fontSize: 18),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Material(
                          borderRadius: BorderRadius.circular(10.0),
                          elevation: 2,
                          color: Colors.white,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 6.0,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: TextFormField(
                                controller: _name,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: 14.0),
                                  prefixIcon: Icon(
                                    Icons.person_outline,
                                    color: Color(4288914861),
                                  ),
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'Email',
                              style: TextStyle(
                                  color: Color(4288914861), fontSize: 18),
                            )),
                        SizedBox(
                          height: 5,
                        ),
                        Material(
                          elevation: 3,
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: TextFormField(
                              controller: _email,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14.0),
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  color: Color(4288914861),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'Password',
                              style: TextStyle(
                                  color: Color(4288914861), fontSize: 18),
                            )),
                        SizedBox(
                          height: 5,
                        ),
                        Material(
                          elevation: 3,
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: TextFormField(
                              controller: _password,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14.0),
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: Color(4288914861),
                                ),
                              ),
                              obscureText: true,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'About You ',
                              style: TextStyle(
                                  color: Color(4288914861), fontSize: 18),
                            )),
                        SizedBox(
                          height: 5,
                        ),
                        Material(
                          elevation: 3,
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: TextFormField(
                              controller: _description,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14.0),
                                prefixIcon: Icon(
                                  Icons.receipt_long_outlined,
                                  color: Color(4288914861),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'Profile Photo',
                              style: TextStyle(
                                  color: Color(4288914861), fontSize: 18),
                            )),
                        SizedBox(
                          height: 5,
                        ),
                        GestureDetector(
                          onTap: () async {
                            final pickedimage = await picker.getImage(
                                source: ImageSource.gallery);

                            if (pickedimage != null) {
                              setState(() {
                                image = File(pickedimage.path);
                              });
                            }
                          },
                          child: Container(
                              width: double.infinity,
                              height: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: kWhiteColor),
                              child: image == null
                                  ? Icon(
                                      Icons.upload_file,
                                      color: Colors.grey,
                                      size: 100,
                                    )
                                  : Container(
                                      height: 150,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: FileImage(image),
                                              fit: BoxFit.cover),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: kWhiteColor),
                                    )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'User Type',
                              style: TextStyle(
                                  color: Color(4288914861), fontSize: 18),
                            )),
                        SizedBox(
                          height: 5,
                        ),
                        Theme(
                            data: ThemeData.dark(),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Radio<String>(
                                        value: "Patient",
                                        groupValue: type,
                                        onChanged: (value) {
                                          setState(() {
                                            type = value;
                                          });
                                        }),
                                    Text(
                                      "Patient",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: kWhiteColor,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Radio(
                                        value: "Doctor",
                                        groupValue: type,
                                        onChanged: (value) {
                                          setState(() {
                                            type = value;
                                          });
                                        }),
                                    Text(
                                      "Doctor",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: kWhiteColor,
                                      ),
                                    )
                                  ],
                                ),
                                type == "Doctor"
                                    ? Column(
                                        children: [
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Text(
                                                'Department',
                                                style: TextStyle(
                                                    color: Color(4288914861),
                                                    fontSize: 18),
                                              )),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Theme(
                                              data: ThemeData.dark(),
                                              child: Column(children: [
                                                Row(
                                                  children: [
                                                    Radio<String>(
                                                        value: "Neurology",
                                                        groupValue: department,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            department = value;
                                                          });
                                                        }),
                                                    Text(
                                                      "Neurology",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: kWhiteColor,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Radio(
                                                        value: "Dentist",
                                                        groupValue: department,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            department = value;
                                                          });
                                                        }),
                                                    Text(
                                                      "Dentist",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: kWhiteColor,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Radio(
                                                        value: "ENT",
                                                        groupValue: department,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            department = value;
                                                          });
                                                        }),
                                                    Text(
                                                      "ENT",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: kWhiteColor,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Radio(
                                                        value: "Cardiology",
                                                        groupValue: department,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            department = value;
                                                          });
                                                        }),
                                                    Text(
                                                      "Cardiology",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: kWhiteColor,
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ]))
                                        ],
                                      )
                                    : Container()
                              ],
                            )),
                        SizedBox(
                          height: 40,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () async {
                              final ref = FirebaseStorage.instance
                                  .ref()
                                  .child('${DateTime.now()}user_image');

                              await ref.putFile(image).onComplete;
                              imgurl = await ref.getDownloadURL();
                              print("Image URL: " + imgurl);
                              auth
                                  .createUserWithEmailAndPassword(
                                      email: _email.text,
                                      password: _password.text)
                                  .then((value) async {
                                String uid = value.user.uid;
                                if (type == "Doctor") {
                                  Firestore.instance
                                      .collection("doctors")
                                      .document(value.user.uid)
                                      .setData({
                                    "description": _description.text,
                                    "name": _name.text,
                                    "imgurl": imgurl,
                                    "email": _email.text,
                                    "type": type,
                                    "department": department,
                                    "status": "Free",
                                    "rating": 1
                                  }).then((v) {
                                    Firestore.instance
                                        .collection(department)
                                        .document(value.user.uid)
                                        .setData({
                                      "description": _description.text,
                                      "name": _name.text,
                                      "imgurl": imgurl,
                                      "email": _email.text,
                                      "type": type,
                                      "department": department,
                                      "status": "Free",
                                      "rating": 1
                                    });
                                  });
                                } else
                                  Firestore.instance
                                      .collection("patient")
                                      .document(uid)
                                      .setData({
                                    "description": _description.text,
                                    "name": _name.text,
                                    "imgurl": imgurl,
                                    "email": _email.text,
                                    "type": type,
                                  });

                                Firestore.instance
                                    .collection("all")
                                    .document(uid)
                                    .setData({
                                  "description": _description.text,
                                  "name": _name.text,
                                  "imgurl": imgurl,
                                  "email": _email.text,
                                  "type": type,
                                  "department": department
                                });
                                type == "Doctor"
                                    ? await Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) =>
                                                DoctorHome(value.user.uid)),
                                        (route) => false)
                                    : await Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) =>
                                                HomeScreen(value.user.uid)),
                                        (route) => false);
                              });
                            },
                            child: Container(
                              height: 50,
                              width: 180,
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'SignUp ',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Icon(
                                        Icons.arrow_forward_rounded,
                                        color: Colors.white,
                                      )
                                    ],
                                  )),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  gradient: LinearGradient(colors: [
                                    Color(4294493271),
                                    Color(4294681407)
                                  ])),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  FirebaseAuth auth = FirebaseAuth.instance;
}
