import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_consultation_app/constant.dart';
import 'package:doctor_consultation_app/screens/photoview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class PrescriptionsScreen extends StatefulWidget {
  @override
  _PrescriptionsScreenState createState() => _PrescriptionsScreenState();
}

class _PrescriptionsScreenState extends State<PrescriptionsScreen> {
  getpatientuid() async {
    final man = FirebaseAuth.instance;
    final getuid = await man.currentUser();
    setState(() {
      uid = getuid.uid;
    });
    print(uid);
  }

  String uid;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getpatientuid();
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(4293390330),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 10),
                child: Text("Your Prescriptions",
                    style: TextStyle(
                      letterSpacing: 0.3,
                      fontWeight: FontWeight.w500,
                      fontSize: 30,
                      color: kTitleTextColor,
                    )),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                  child: StreamBuilder(
                    stream: Firestore.instance
                        .collection("patient")
                        .document(uid)
                        .collection("medicines")
                        .orderBy("date", descending: true)
                        .snapshots(),
                    builder: (ctx, snapshot) {
                      return snapshot.data == null
                          ? Container()
                          : snapshot.data.documents.length == 0
                              ? Column(children: [
                                  Lottie.asset("assets/load.json", width: 1000),
                                  Text("No Prescriptions Yet ",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: "good",
                                          color: kTitleTextColor,
                                          fontSize: 25))
                                ])
                              : ListView.separated(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (ctx, i) {
                                    var info = snapshot.data.documents[i];

                                    return GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        width: double.infinity,
                                        height: 120,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: Color(4294770174)),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 90,
                                              height: 90,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          info['imgurl']),
                                                      fit: BoxFit.cover)),
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  info["doctor_name"],
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 18),
                                                ),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Text(
                                                  info["department"],
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.grey,
                                                      fontSize: 13),
                                                ),
                                                SizedBox(height: 13),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (c) =>
                                                                Photo(info[
                                                                    "imgurl"])));
                                                  },
                                                  child: Container(
                                                    width: 200,
                                                    height: 30,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        color:
                                                            Color(4279980225)),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Center(
                                                          child: Text(
                                                            "View Precription",
                                                            style: TextStyle(
                                                                color:
                                                                    kWhiteColor,
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Icon(
                                                          Icons
                                                              .arrow_forward_rounded,
                                                          color: kWhiteColor,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (ctx, i) => SizedBox(
                                        height: 20,
                                      ),
                                  itemCount: snapshot.data.documents.length);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
