import 'package:axix_parent_app/view/academics_screen/switch%20_child_screen.dart';
import 'package:axix_parent_app/view/academics_screen/widgets/sheet.dart';
import 'package:axix_parent_app/view/academics_screen/widgets/sheet_handle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReportDownloadingBottomSheet extends StatelessWidget {
  const ReportDownloadingBottomSheet({
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
        children: [
          sheetHandle(),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Downloading report card',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
            ),
          ),
          const SizedBox(height: 5),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              report['term']?.toString() ?? '',
              style: const TextStyle(fontSize: 11, color: academicsMuted),
            ),
          ),
          const SizedBox(height: 22),
          const CircularProgressIndicator(color: academicsGreen),
          const SizedBox(height: 14),
          const Text(
            'Preparing your report card...',
            style: TextStyle(fontSize: 12, color: academicsMuted),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}