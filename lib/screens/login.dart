import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_consultation_app/screens/home_doctor.dart';
import 'package:doctor_consultation_app/screens/home_screen.dart';
import 'package:doctor_consultation_app/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

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
                  child: Image.asset("assets/blob.jpeg")),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 150, left: 30),
                      child:
                          // Text('Login',
                          //     style: TextStyle(
                          //         fontSize: 40,
                          //         fontWeight: FontWeight.bold,
                          //         color: Colors.black87)),
                          GradientText("Login",
                              gradient: LinearGradient(colors: [
                                Color(4294493271),
                                Color(4294681407)
                              ]),
                              style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87))),
                  Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (con) => Signin()));
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 0),
                              child: Text('Dont have an account ?',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Color(4288914861))),
                            ),
                            GradientText("  SignUp",
                                gradient: LinearGradient(colors: [
                                  Color(4294493271),
                                  Color(4294681407)
                                ]),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Color(4288914861))),
                          ],
                        ),
                      )),
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
                            'Email',
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
                                )),
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
                          height: 40,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              auth
                                  .signInWithEmailAndPassword(
                                      email: _email.text,
                                      password: _password.text)
                                  .then((value) async {
                                String type;
                                await Firestore.instance
                                    .collection("all")
                                    .document(value.user.uid)
                                    .get()
                                    .then((v) async {
                                  setState(() {
                                    type = v.data['type'];
                                    print(type);
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
                                        'Login ',
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
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

FirebaseAuth auth = FirebaseAuth.instance;
