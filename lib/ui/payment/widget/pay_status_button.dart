import 'package:flutter/material.dart';

class PaidButton extends StatelessWidget {
  final double dueAmount;
  final VoidCallback onTap;

  const PaidButton({
    Key? key,
    required this.dueAmount,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isPayable = dueAmount > 0;

    return GestureDetector(
      onTap: isPayable ? onTap : null,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          gradient: isPayable
              ? const LinearGradient(
                  colors: [
                    Color(0xFF10B981),
                    Color(0xFF059669),
                  ],
                )
              : const LinearGradient(
                  colors: [
                    Color(0xFF9CA3AF), // gray colors for disabled state
                    Color(0xFF6B7280),
                  ],
                ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: isPayable
              ? [
                  BoxShadow(
                    color: const Color(0xFF10B981).withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!isPayable)
              Icon(
                Icons.check_circle,
                color: Colors.white,
                size: 20,
              ),
            SizedBox(width: 8),
            Text(
              isPayable ? 'Pay' : 'PAID',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
