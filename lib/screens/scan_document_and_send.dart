import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_consultation_app/screens/home_doctor.dart';
import 'package:doctor_consultation_app/screens/home_screen.dart';
import 'package:doctor_consultation_app/screens/login.dart';
import 'package:fade/fade.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:lottie/lottie.dart';

import '../constant.dart';
import '../cropper.dart';

class ScanDocument extends StatefulWidget {
  String patient_uid;
  String name;

  String department;
  ScanDocument(this.patient_uid, this.name, this.department);
  @override
  _ScanDocumentState createState() => _ScanDocumentState();
}

class _ScanDocumentState extends State<ScanDocument> {
  scandoc() async {
    Cropper cropper = Cropper();

    final taken = await picker.getImage(source: ImageSource.camera);
    if (taken != null) {
      setState(() {
        image = File(taken.path);
      });
      var cropped = await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatioPresets: Platform.isAndroid
              ? [
                  CropAspectRatioPreset.square,
                  CropAspectRatioPreset.ratio3x2,
                  CropAspectRatioPreset.original,
                  CropAspectRatioPreset.ratio4x3,
                  CropAspectRatioPreset.ratio16x9
                ]
              : [
                  CropAspectRatioPreset.original,
                  CropAspectRatioPreset.square,
                  CropAspectRatioPreset.ratio3x2,
                  CropAspectRatioPreset.ratio4x3,
                  CropAspectRatioPreset.ratio5x3,
                  CropAspectRatioPreset.ratio5x4,
                  CropAspectRatioPreset.ratio7x5,
                  CropAspectRatioPreset.ratio16x9
                ],
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.black45,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          iosUiSettings: IOSUiSettings(
            title: 'Cropper',
          ));
      if (cropped != null) {}
      setState(() {
        image = cropped;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scandoc();
  }

  bool isdialogseen = false;
  final picker = ImagePicker();
  File image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(4293390330),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              image == null
                  ? Container()
                  : Container(
                      height: MediaQuery.of(context).size.height - 140,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                          image: DecorationImage(
                              image: FileImage(image), fit: BoxFit.cover)),
                    ),
              SizedBox(
                height: 70,
              ),
              GestureDetector(
                onTap: () async {
                  setState(() {
                    isdialogseen = true;
                  });
                  final man = FirebaseAuth.instance;
                  final getuid = await man.currentUser();
                  final uid = getuid.uid;
                  final ref = FirebaseStorage.instance
                      .ref()
                      .child('${DateTime.now()}prescription');

                  await ref.putFile(image).onComplete;
                  final imgurl = await ref.getDownloadURL();
                  await Firestore.instance
                      .collection("patient")
                      .document(widget.patient_uid)
                      .collection("medicines")
                      .add({
                    "imgurl": imgurl,
                    "doctor_name": widget.name,
                    "department": widget.department,
                    "date": DateTime.now()
                  }).then((value) => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => DoctorHome(uid)),
                          (route) => false));
                },
                child: Container(
                    width: MediaQuery.of(context).size.width - 10,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(4279980225)),
                    child: Center(
                        child: Text(
                      "Send Prescription",
                      style: TextStyle(
                          color: kWhiteColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ))),
              ),
            ],
          ),
          isdialogseen != true
              ? Container()
              : Container(
                  width: 230,
                  height: 230,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Lottie.network(
                          "https://assets3.lottiefiles.com/packages/lf20_F7WfWB.json",
                          height: 200),
                      Padding(
                        padding: const EdgeInsets.only(top: 150.0),
                        child: Text(
                          "Please Wait....",
                          style:
                              TextStyle(fontSize: 18, color: kTitleTextColor),
                        ),
                      )
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
