import 'package:flutter/material.dart';
import 'package:my_cmh_updated/common/date_time_utils.dart';

class InvoiceUserInfo extends StatelessWidget {
  final String invoiceNo;
  final String invoiceDate;
  final String patientname;
  final String? wardName;

  const InvoiceUserInfo({
    Key? key,
    required this.invoiceNo,
    required this.invoiceDate,
    required this.patientname,
    this.wardName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            patientname,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            invoiceNo,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.normal,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 14, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Text(
                DateTimeUtils.extractDate(invoiceDate),
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ),
          if (wardName != null && wardName!.isNotEmpty) ...[
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  'Ward Name: ',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    wardName ?? '',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    textAlign: TextAlign.end,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
