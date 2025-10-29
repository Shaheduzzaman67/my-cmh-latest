import 'package:flutter/material.dart';
import 'package:my_cmh_updated/common/constants.dart';

class EditTextWidget extends StatelessWidget {
  const EditTextWidget({
    @required this.labelText,
    @required this.hintText,
    @required this.iconData,
    @required this.onTextChange,
    @required this.onDonePressed,
    this.focusNode,
    this.inputType,
  });

  final String? labelText;
  final String? hintText;
  final IconData? iconData;
  final VoidCallback? onTextChange;
  final VoidCallback? onDonePressed;
  final FocusNode? focusNode;
  final TextInputType? inputType;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
        child: TextField(
          keyboardType: inputType,
          autofocus: true,
          //focusNode: focusNode,
          onSubmitted: (value) => onDonePressed,
          onChanged: (value) => onTextChange!,
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(),
            hintText: hintText,
            icon: Icon(iconData, color: colorAccent),
            border: new UnderlineInputBorder(
              borderSide: new BorderSide(color: Colors.red),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: colorAccent),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: colorAccent),
            ),
          ),
        ),
      ),
    );
  }
}
