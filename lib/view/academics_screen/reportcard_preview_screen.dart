
import 'package:axix_parent_app/view/academics_screen/switch%20_child_screen.dart';
import 'package:axix_parent_app/view/academics_screen/widgets/extra_green_button.dart';
import 'package:axix_parent_app/view/academics_screen/widgets/sheet.dart';
import 'package:axix_parent_app/view/academics_screen/widgets/sheet_handle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../messages_screen/messages_widget/green_button.dart';

class ReportCardPreviewBottomSheet extends StatelessWidget {
  const ReportCardPreviewBottomSheet({
    super.key,
    required this.report,
  });

  final Map<String, dynamic> report;

  @override
  Widget build(BuildContext context) {
    return sheet(
      context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sheetHandle(),
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Report card',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F8FA),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.description_outlined,
                  color: academicsGreen,
                  size: 30,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        report['term']?.toString() ?? 'Report card',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '${report['fileName'] ?? 'Report card PDF'}',
                        style: const TextStyle(
                          fontSize: 11,
                          color: academicsMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'Connect your report-card viewing API here to display the selected PDF.',
            style: TextStyle(fontSize: 12, color: academicsMuted),
          ),
          const SizedBox(height: 18),
          extraGreenButton('Close', () => Navigator.pop(context)),
        ],
      ),
    );
  }
}