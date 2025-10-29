import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  RoundIconButton({this.mChild, @required this.onClicked, this.width, this.height, @required this.color});

  final Widget? mChild;
  final VoidCallback? onClicked;
  double? width = 66.0;
  double? height = 66.0;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: mChild,
      onPressed: onClicked!,
      elevation: 6.0,
      constraints: BoxConstraints.tightFor(
        width: width,
        height: height,
      ),
      //shape: CircleBorder(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100.0),
      ),
      fillColor: color,
    );
  }
}