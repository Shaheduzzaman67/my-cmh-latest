import 'package:flutter/material.dart';

class RoomSelectionContainer extends StatelessWidget {
  final String roomName;
  final bool isSelected;
  final Color accentColor;

  const RoomSelectionContainer({
    Key? key,
    required this.roomName,
    required this.isSelected,
    this.accentColor = const Color(0xFF2196F3), // Default accent color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? accentColor : Colors.white,
        border: Border.all(
          color: const Color(0xffE2E2E2),
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 5,
        bottom: 5,
      ),
      child: Center(
        child: Text(
          roomName,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
