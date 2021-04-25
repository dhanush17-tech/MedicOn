import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_consultation_app/screens/all_doctors.dart';
import 'package:doctor_consultation_app/screens/detail_screen.dart';
import 'package:doctor_consultation_app/screens/join_meeting.dart';
import 'package:doctor_consultation_app/screens/prescription.dart';
import 'package:doctor_consultation_app/screens/scan_document_and_send.dart';
import 'package:fade/fade.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_text/gradient_text.dart';

import 'asksend.dart';

class HomeScreen extends StatefulWidget {
  String uid;
  HomeScreen(this.uid);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  getname() {
    Firestore.instance
        .collection("patient")
        .document(widget.uid)
        .get()
        .then((value) => setState(() {
              name = value.data["name"];
            }));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getname();
  }

  String name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(4293390330),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Column(children: [
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20)),
                      color: Color(4279980225)),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 40.0),
                        child: Row(
                          children: [
                            Text(
                              "Hello There, \n$name",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 23,
                                  color: Color(4294507261),
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Image.asset(
                              "assets/hi.png",
                              width: 160,
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => PrescriptionsScreen()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 177.0),
                          child: Container(
                            width: double.infinity,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(4294310399).withOpacity(0.96)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text(
                                    "View Prescriptions",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Color(4279980225)
                                            .withOpacity(0.76)),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(Icons.arrow_forward_rounded,
                                    color: Color(4279980225).withOpacity(0.76))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Categories",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 15,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) =>
                                            AllDoctors("Neurology")));
                              },
                              child: Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Color(4294770174)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/brain.png",
                                      scale: 5,
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Text(
                                      "Neurology",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) => AllDoctors(
                                              "ENT",
                                            )));
                              },
                              child: Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Color(4294770174)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/throat.png",
                                      scale: 2,
                                    ),
                                    SizedBox(
                                      height: 13,
                                    ),
                                    Text(
                                      "ENT",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) => AllDoctors(
                                              "Dentist",
                                            )));
                              },
                              child: Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Color(4294770174)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/teeth.png",
                                      scale: 4,
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Text(
                                      "Dentist",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) => AllDoctors(
                                              "Cardiology",
                                            )));
                              },
                              child: Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Color(4294770174)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/heart.png",
                                      scale: 6,
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Text(
                                      "Cardiology",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "All Doctors",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 0,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 0),
                        child: StreamBuilder(
                            stream: Firestore.instance
                                .collection("doctors")
                                .snapshots(),
                            builder: (context, snapshot) {
                              return snapshot.data == null
                                  ? Container()
                                  : ListView.separated(
                                      separatorBuilder: (ctx, i) => SizedBox(
                                        height: 10,
                                      ),
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: snapshot.data.documents.length,
                                      itemBuilder: (ctx, i) {
                                        var info = snapshot.data.documents[i];
                                        return GestureDetector(
                                          onTap: info['status'] == "Busy"
                                              ? null
                                              : () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              DetailScreen(
                                                                info["name"],
                                                                info[
                                                                    "description"],
                                                                info["imgurl"],
                                                                info["rating"],
                                                                info.documentID
                                                                    .toString(),
                                                                info[
                                                                    "department"],
                                                              )));
                                                },
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
                                                info['status'] == "Busy"
                                                    ? Stack(
                                                        alignment:
                                                            Alignment.center,
                                                        children: [
                                                          Container(
                                                            width: 90,
                                                            height: 90,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15),
                                                                image: DecorationImage(
                                                                    image: NetworkImage(
                                                                        info[
                                                                            "imgurl"]),
                                                                    fit: BoxFit
                                                                        .cover)),
                                                          ),
                                                          Container(
                                                            width: 90,
                                                            height: 90,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15),
                                                                color: Colors
                                                                    .black87
                                                                    .withOpacity(
                                                                        0.6)),
                                                            child: Center(
                                                              child: Text(
                                                                "Busy",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    : Container(
                                                        width: 90,
                                                        height: 90,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                            image: DecorationImage(
                                                                image: NetworkImage(
                                                                    info[
                                                                        'imgurl']),
                                                                fit: BoxFit
                                                                    .cover)),
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
                                                       "Dr.${info["name"]}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 18),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      info["department"],
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.grey,
                                                          fontSize: 13),
                                                    ),
                                                    SizedBox(height: 20),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        info['status'] == "Busy"
                                                            ? Text(
                                                                info['status'],
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ))
                                                            : Text(
                                                                info['status'],
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .green,
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                )),
                                                      ],
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                            }),
                      )
                    ],
                  ),
                ),
              ]),
            ],
          ),
        ));
  }

  bool issee = true;
}
// import 'package:doctor_consultation_app/components/category_card.dart';
// import 'package:doctor_consultation_app/components/doctor_card.dart';
// import 'package:doctor_consultation_app/components/search_bar.dart';
// import 'package:doctor_consultation_app/constant.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: kBackgroundColor,
//       body: SafeArea(
//         bottom: false,
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 30),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     SvgPicture.asset('assets/icons/menu.svg'),
//                     SvgPicture.asset('assets/icons/profile.svg'),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 30),
//                 child: Text(
//                   'Find Your Desired\nDoctor',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 28,
//                     color: kTitleTextColor,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 30),
//                 child: SearchBar(),
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 30),
//                 child: Text(
//                   'Categories',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: kTitleTextColor,
//                     fontSize: 18,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               buildCategoryList(),
//               SizedBox(
//                 height: 20,
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 30),
//                 child: Text(
//                   'Top Doctors',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: kTitleTextColor,
//                     fontSize: 18,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               buildDoctorList(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   buildCategoryList() {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Row(
//         children: <Widget>[
//           SizedBox(
//             width: 30,
//           ),
//           CategoryCard(
//             'Dental\nSurgeon',
//             'assets/icons/dental_surgeon.png',
//             kBlueColor,
//           ),
//           SizedBox(
//             width: 10,
//           ),
//           CategoryCard(
//             'Heart\nSurgeon',
//             'assets/icons/heart_surgeon.png',
//             kYellowColor,
//           ),
//           SizedBox(
//             width: 10,
//           ),
//           CategoryCard(
//             'Eye\nSpecialist',
//             'assets/icons/eye_specialist.png',
//             kOrangeColor,
//           ),
//           SizedBox(
//             width: 30,
//           ),
//         ],
//       ),
//     );
//   }

//   buildDoctorList() {
//     return Padding(
//       padding: EdgeInsets.symmetric(
//         horizontal: 30,
//       ),
//       child: Column(
//         children: <Widget>[
//           DoctorCard(
//             'Dr. Stella Kane',
//             'Heart Surgeon - Flower Hospitals',
//             'assets/images/doctor1.png',
//             kBlueColor,
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           DoctorCard(
//             'Dr. Joseph Cart',
//             'Dental Surgeon - Flower Hospitals',
//             'assets/images/doctor2.png',
//             kYellowColor,
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           DoctorCard(
//             'Dr. Stephanie',
//             'Eye Specialist - Flower Hospitals',
//             'assets/images/doctor3.png',
//             kOrangeColor,
//           ),
//           SizedBox(
//             height: 20,
//           ),
//         ],
//       ),
//     );
//   }
// }
//