import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_consultation_app/constant.dart';
import 'package:doctor_consultation_app/screens/join_meeting.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:timeago/timeago.dart' as timeago;

class DoctorHome extends StatefulWidget {
  String doctor_uid;
  DoctorHome(this.doctor_uid);

  @override
  _DoctorHomeState createState() => _DoctorHomeState();
}

class _DoctorHomeState extends State<DoctorHome> {
  checkinfo() async {
    await Firestore.instance
        .collection("all")
        .document(widget.doctor_uid)
        .get()
        .then((value) {
      setState(() {
        department = value.data["department"];
        name = value.data["name"];
        print(widget.doctor_uid);
        print(department);
      });
    });
  }

  String department;
  String name;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkinfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        department == null
            ? Container()
            : StreamBuilder(
                stream: Firestore.instance
                    .collection(department)
                    .document(widget.doctor_uid)
                    .snapshots(),
                builder: (context, snashot) {
                  return snashot.data == null
                      ? Container()
                      : Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 280,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(snashot.data["imgurl"]),
                                  alignment: Alignment.topCenter,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 260.0),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  height:
                                      MediaQuery.of(context).size.height - 260,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20),
                                      ),
                                      color: Colors.white),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0, bottom: 0),
                                            child: Text(
                                              "Today's Visits",
                                              style: TextStyle(
                                                  fontSize: 21,
                                                  fontWeight: FontWeight.bold,
                                                  color: kTitleTextColor),
                                            ),
                                          ),
                                        ),
                                        StreamBuilder(
                                          stream: Firestore.instance
                                              .collection(department)
                                              .document(widget.doctor_uid)
                                              .collection("calls")
                                              .orderBy("date", descending: true)
                                              .snapshots(),
                                          builder: (ctx, snap) {
                                            return snap.data == null
                                                ? Container()
                                                : snap.data.documents.length ==
                                                        0
                                                    ? Column(children: [
                                                        Lottie.asset(
                                                            "assets/load.json",
                                                            width: 1000),
                                                        Text(
                                                            "No Appoinments Yet ",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "good",
                                                                color:
                                                                    kTitleTextColor,
                                                                fontSize: 25))
                                                      ])
                                                    : ListView.separated(
                                                        physics:
                                                            NeverScrollableScrollPhysics(),
                                                        shrinkWrap: true,
                                                        itemBuilder: (ctx, i) {
                                                          var length = snap.data
                                                              .documents.length;

                                                          var info = snap.data
                                                              .documents[i];
                                                          var date = DateTime
                                                              .parse(info[
                                                                      "date"]
                                                                  .toDate()
                                                                  .toString());
                                                          String formattedDate =
                                                              DateFormat(
                                                                      'yyyy-MM-dd ')
                                                                  .format(date);
                                                          print(formattedDate);
                                                          print(snap
                                                              .data
                                                              .documents[
                                                                  length - 1]
                                                              .documentID);
                                                          return info["isseen"] ==
                                                                  false
                                                              ? GestureDetector(
                                                                  onTap: () {},
                                                                  child:
                                                                      Container(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            10),
                                                                    width: double
                                                                        .infinity,
                                                                    height: 120,
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                15),
                                                                        color: Color(
                                                                            4293390330)),
                                                                    child: Row(
                                                                      children: [
                                                                        Container(
                                                                          width:
                                                                              90,
                                                                          height:
                                                                              90,
                                                                          decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(15),
                                                                              image: DecorationImage(image: NetworkImage(info['imgurl']), fit: BoxFit.cover)),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              15,
                                                                        ),
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            SizedBox(
                                                                              height: 10,
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(left: 4.0),
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Text(
                                                                                    info["patient_name"],
                                                                                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: 18,
                                                                                  ),
                                                                                  Container(
                                                                                    width: 120,
                                                                                    child: Align(
                                                                                      alignment: Alignment.topRight,
                                                                                      child: Text(
                                                                                        "${timeago.format(info["date"].toDate())}",
                                                                                        textAlign: TextAlign.end,
                                                                                        style: TextStyle(fontSize: 13, color: Color(4279980225).withOpacity(0.76)),
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 2,
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(left: 4.0),
                                                                              child: Text(
                                                                                formattedDate,
                                                                                style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey, fontSize: 13),
                                                                              ),
                                                                            ),
                                                                            SizedBox(height: 13),
                                                                            GestureDetector(
                                                                              onTap: () {
                                                                                print(snap.data.documents[i].documentID);
                                                                                Firestore.instance.collection(department).document(widget.doctor_uid).setData({
                                                                                  "status": "Busy"
                                                                                }, merge: true);
                                                                                Firestore.instance
                                                                                    .collection(department)
                                                                                    .document(widget.doctor_uid)
                                                                                    .collection("calls")
                                                                                    .document(snap.data.documents[i].documentID)
                                                                                    .setData({
                                                                                      "isseen": true,
                                                                                    }, merge: true)
                                                                                    .then((value) => print("happyyyyyy"))
                                                                                    .then((value) => Navigator.push(context, MaterialPageRoute(builder: (builder) => JoinMeeting(department, snap.data.documents[i]["joinid"], name, widget.doctor_uid))));
                                                                              },
                                                                              child: Container(
                                                                                width: 200,
                                                                                height: 30,
                                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Color(4279980225)),
                                                                                child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  children: [
                                                                                    Center(
                                                                                      child: Text(
                                                                                        "Consult Patient",
                                                                                        style: TextStyle(color: kWhiteColor, fontSize: 15, fontWeight: FontWeight.w500),
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: 5,
                                                                                    ),
                                                                                    Icon(
                                                                                      Icons.arrow_forward_rounded,
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
                                                                )
                                                              : Stack(
                                                                  children: [
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {},
                                                                      child:
                                                                          Container(
                                                                        padding:
                                                                            EdgeInsets.all(10),
                                                                        width: double
                                                                            .infinity,
                                                                        height:
                                                                            120,
                                                                        decoration: BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(15),
                                                                            color: Color(4293390330)),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Container(
                                                                              width: 90,
                                                                              height: 90,
                                                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), image: DecorationImage(image: NetworkImage(info['imgurl']), fit: BoxFit.cover)),
                                                                            ),
                                                                            SizedBox(
                                                                              width: 15,
                                                                            ),
                                                                            Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                SizedBox(
                                                                                  height: 10,
                                                                                ),
                                                                                Padding(
                                                                                  padding: const EdgeInsets.only(left: 4.0),
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      Text(
                                                                                        info["patient_name"],
                                                                                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: 18,
                                                                                      ),
                                                                                      Container(
                                                                                        width: 120,
                                                                                        child: Align(
                                                                                          alignment: Alignment.topRight,
                                                                                          child: Text(
                                                                                            "${timeago.format(info["date"].toDate())}",
                                                                                            textAlign: TextAlign.end,
                                                                                            style: TextStyle(fontSize: 13, color: Color(4279980225).withOpacity(0.76)),
                                                                                          ),
                                                                                        ),
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 2,
                                                                                ),
                                                                                Padding(
                                                                                  padding: const EdgeInsets.only(left: 4.0),
                                                                                  child: Text(
                                                                                    formattedDate,
                                                                                    style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey, fontSize: 13),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(height: 13),
                                                                                GestureDetector(
                                                                                  onTap: () {},
                                                                                  child: Container(
                                                                                    width: 200,
                                                                                    height: 30,
                                                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Color(4279980225)),
                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        Center(
                                                                                          child: Text(
                                                                                            "Consult Patient",
                                                                                            style: TextStyle(color: kWhiteColor, fontSize: 15, fontWeight: FontWeight.w500),
                                                                                          ),
                                                                                        ),
                                                                                        SizedBox(
                                                                                          width: 5,
                                                                                        ),
                                                                                        Icon(
                                                                                          Icons.arrow_forward_rounded,
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
                                                                    ),
                                                                    Container(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              10),
                                                                      width: double
                                                                          .infinity,
                                                                      height:
                                                                          120,
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(
                                                                              15),
                                                                          color: Colors
                                                                              .grey
                                                                              .withOpacity(0.6)),
                                                                    )
                                                                  ],
                                                                );
                                                        },
                                                        separatorBuilder:
                                                            (ctx, i) =>
                                                                SizedBox(
                                                                  height: 20,
                                                                ),
                                                        itemCount: snap.data
                                                            .documents.length);
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                })
      ],
    ));
  }
}
