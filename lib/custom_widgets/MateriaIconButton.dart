import 'package:flutter/material.dart';
import 'package:my_cmh_updated/common/constants.dart';

class MaterialIconButton extends StatelessWidget {
  MaterialIconButton({
    this.mChild,
    @required this.onClicked,
    @required this.width,
    @required this.height,
    this.mColor = colorPrimary,
    this.margin,
    this.circle,
  });

  final Widget? mChild;
  final VoidCallback? onClicked;
  final double? width;
  final double? height;
  final Color? mColor;
  final EdgeInsets? margin;
  final double? circle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: RawMaterialButton(
        child: mChild,
        onPressed: onClicked!,
        elevation: 2.0,
        constraints: BoxConstraints.tightFor(width: width, height: height),
        //shape: CircleBorder(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(circle ?? 70.0),
        ),
        fillColor: mColor,
      ),
    );
  }
}
