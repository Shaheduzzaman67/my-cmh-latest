import 'package:flutter/material.dart';
import 'package:my_cmh_updated/common/constants.dart';

class EditTextWidgetWithoutCard extends StatefulWidget {
  EditTextWidgetWithoutCard({
    @required this.labelText,
    @required this.hintText,
    @required this.iconData,
    @required this.onTextChange,
    @required this.onDonePressed,
    this.focusNode,
    this.inputType,
    this.invisiblePass,
    this.validator,
    this.marginLeft,
    this.marginTop,
    this.marginright,
    this.marginBottom,
    this.paddingHori,
    this.paddingVer,
    this.controller,
    this.mColor,
    this.mAutofillHints,
    this.isPass = false,
  });

  final Color? mColor;
  final String? labelText;
  final String? hintText;
  final IconData? iconData;
  final ValueChanged<String>? onTextChange;
  final ValueChanged<String>? onDonePressed;
  final FocusNode? focusNode;
  final TextInputType? inputType;
  bool? invisiblePass;
  final ValueChanged<String>? validator;
  final double? marginLeft;
  final double? marginTop;
  final double? marginright;
  final double? marginBottom;
  final double? paddingHori;
  final double? paddingVer;
  final bool? isPass;
  final TextEditingController? controller;
  final List<String>? mAutofillHints;

  @override
  State<EditTextWidgetWithoutCard> createState() =>
      _EditTextWidgetWithoutCardState();
}

class _EditTextWidgetWithoutCardState extends State<EditTextWidgetWithoutCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.mColor ?? Colors.transparent,
      margin: EdgeInsets.fromLTRB(
        widget.marginLeft ?? 8.0,
        widget.marginTop ?? 12.0,
        widget.marginright ?? 8.0,
        widget.marginBottom ?? 12.0,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: widget.paddingVer ?? 2.0,
          horizontal: widget.paddingHori ?? 10.0,
        ),
        child: TextField(
          obscureText: widget.invisiblePass ?? false,
          keyboardType: widget.inputType,
          autofocus: false,
          autofillHints: widget.mAutofillHints,
          //focusNode: focusNode,
          controller: widget.controller,
          onSubmitted: widget.onDonePressed,
          onChanged: widget.onTextChange,
          decoration: InputDecoration(
            labelText: widget.labelText,
            labelStyle: TextStyle(),
            hintText: widget.hintText,
            icon: widget.iconData == null
                ? null
                : Icon(widget.iconData, color: colorAccent),
            suffixIcon: widget.isPass!
                ? IconButton(
                    icon: Icon(
                      widget.invisiblePass!
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        widget.invisiblePass = !widget.invisiblePass!;
                      });
                    },
                  )
                : null,
            border: UnderlineInputBorder(
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
