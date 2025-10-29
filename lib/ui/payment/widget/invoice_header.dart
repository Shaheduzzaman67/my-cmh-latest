import 'package:flutter/material.dart';

class InvoiceHeader extends StatelessWidget {
  final String title;
  final String tag;
  final Color tagColor;
  final Color tagBackgroundColor;

  const InvoiceHeader({
    Key? key,
    required this.title,
    required this.tag,
    this.tagColor = const Color(0xFF3B82F6),
    this.tagBackgroundColor = const Color(0xFF3B82F6),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1F2937),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: tagBackgroundColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            tag,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: tagColor,
            ),
          ),
        ),
      ],
    );
  }
}
