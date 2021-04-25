import 'package:doctor_consultation_app/screens/home_doctor.dart';
import 'package:doctor_consultation_app/screens/scan_document_and_send.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:star_rating/star_rating.dart';

import '../constant.dart';

class AskSend extends StatefulWidget {
  String patient_uid;
  String name;
  String department;
  AskSend(this.patient_uid, this.name, this.department);

  @override
  _AskSendState createState() => _AskSendState();
}

class _AskSendState extends State<AskSend> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(4293390330),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 0.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 300,
              child: Stack(
                children: [
                  Center(
                    child: Lottie.network(
                        "https://assets9.lottiefiles.com/packages/lf20_mzpoibze.json",
                        width: 700),
                  ),
                  Container(
                      width: double.infinity,
                      height: 300,
                      child: Center(
                          child: Image.asset(
                        "assets/wait2.gif",
                        height: 600,
                      )),
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.7),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)))),
                ],
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text("Your patient is wating... ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w500)),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: Center(
                child: Text("Send the prescription  ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(4279980225),
                        fontSize: 23,
                        fontWeight: FontWeight.w500)),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (builder) => ScanDocument(widget.patient_uid,
                            widget.name, widget.department)));
                  },
                  child: Container(
                    width: 150,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.withOpacity(0.3)),
                    child: Center(
                      child: Text(
                        "Proceed",
                        style: GoogleFonts.montserrat(
                            color: Colors.grey[800],
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () async {
                    final man = FirebaseAuth.instance;
                    final getuid = await man.currentUser();
                    String uid = getuid.uid;
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => DoctorHome(uid)),
                        (route) => false);
                  },  
                  child: Container(
                    width: 150,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.withOpacity(0.3)),
                    child: Center(
                      child: Text(
                        "Skip",
                        style: GoogleFonts.montserrat(
                            color: Colors.grey[800],
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                )
              ],
            ),
            // SizedBox(
            //   height: 240,
            // ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20.0, left: 10, right: 10),
        child: Container(
          width: MediaQuery.of(context).size.width - 10,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(4279980225)),
          child: Center(
            child: Text(
              "Report Patient",
              style: TextStyle(
                  color: kWhiteColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}
