import 'package:doctor_consultation_app/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "key",
      child: GestureDetector(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.only(top: 0, left: 0, right: 0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(17),
                border: Border.all(color: Color(0xFF5894FA)),
                color: Color(0xFF5894FA).withOpacity(0.4)),
            width: 350,
            height: 40,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20, top: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Material(
                    type: MaterialType.transparency,
                    child: Text(
                      'Search',
                      style: TextStyle(
                          fontSize: 20,
                          color: Color(
                            4278228470,
                          ),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Icon(
                    Icons.search,
                    size: 30,
                    color: Color(4278228470),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
