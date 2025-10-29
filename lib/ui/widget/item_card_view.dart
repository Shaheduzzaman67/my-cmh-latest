import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemWidget extends StatelessWidget {
  final String name;
  final String? image;
  final double? fontSize;

  const ItemWidget({Key? key, required this.name, this.image, this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.transparent,
      child: Stack(
        children: <Widget>[
          // Background image container
          Container(
            color: Colors.transparent,
            width: width * 0.53,
            height: height * 0.16,
            child: Image.asset(
              'images/regular.png',
              fit: BoxFit.contain,
              width: 50,
              height: 50,
            ),
          ),
          // Overlay text and optional image
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      name,
                      style: GoogleFonts.nunitoSans(
                        color: Colors.black,
                        fontSize: fontSize ?? 14,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  if (image != null)
                    Container(
                      margin: const EdgeInsets.only(right: 15),
                      child: Image.asset(
                        image!,
                        fit: BoxFit.contain,
                        width: 30,
                        height: 40,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
