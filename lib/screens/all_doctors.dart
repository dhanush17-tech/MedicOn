import 'package:doctor_consultation_app/constant.dart';
import 'package:doctor_consultation_app/screens/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lottie/lottie.dart';

class AllDoctors extends StatefulWidget {
  String depart;

  AllDoctors(
    this.depart,
  );
  @override
  _AllDoctorsState createState() => _AllDoctorsState();
}

class _AllDoctorsState extends State<AllDoctors> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.depart);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(4293390330),
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              leadingWidth: 0,
              stretch: false,
              expandedHeight: 50,
              pinned: false,
              backgroundColor: Colors.transparent,
              title: Padding(
                padding: const EdgeInsets.only(top: 8.0, right: 0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    widget.depart,
                    style: TextStyle(
                      letterSpacing: 0.3,
                      fontWeight: FontWeight.w500,
                      fontSize: 30,
                      color: kTitleTextColor,
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: StreamBuilder(
                    stream: Firestore.instance
                        .collection(widget.depart)
                        .snapshots(),
                    builder: (context, snapshot) {
                      return snapshot.data == null
                          ? Container()
                          : snapshot.data.documents.length == 0
                              ? Column(children: [
                                  Lottie.asset("assets/load.json", width: 1000),
                                  Text("No Doctors In This\n Department ",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: "good",
                                          color: kTitleTextColor,
                                          fontSize: 25))
                                ])
                              : ListView.separated(
                                  itemCount: snapshot.data.documents.length,
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  separatorBuilder: (ctx, i) => SizedBox(
                                    height: 10,
                                  ),
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
                                                            info["description"],
                                                            info["imgurl"],
                                                            info["rating"],
                                                            info.documentID
                                                                .toString(),
                                                            info["department"],
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
                                                    alignment: Alignment.center,
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
                                                                fontSize: 20,
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
                                                                .circular(15),
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
                                                        ? Text(info['status'],
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ))
                                                        : Text(info['status'],
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.green,
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
              ),
            ]))
          ],
        ),
      ),
    );
  }
}
