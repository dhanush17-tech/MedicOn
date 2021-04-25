import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class Photo extends StatefulWidget {
  String url;
  Photo(this.url);
  @override
  _PhotoState createState() => _PhotoState();
}

class _PhotoState extends State<Photo> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: PhotoView(
      imageProvider: NetworkImage(widget.url),
    ));
  }
}
