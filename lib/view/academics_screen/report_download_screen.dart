
import 'package:axix_parent_app/view/academics_screen/switch%20_child_screen.dart';
import 'package:axix_parent_app/view/academics_screen/widgets/extra_green_button.dart';
import 'package:axix_parent_app/view/academics_screen/widgets/sheet.dart';
import 'package:axix_parent_app/view/academics_screen/widgets/sheet_handle.dart';
import 'package:flutter/material.dart';

import '../messages_screen/messages_widget/green_button.dart';

class ReportDownloadResultBottomSheet extends StatelessWidget {
  const ReportDownloadResultBottomSheet({
    super.key,
    required this.success,
    required this.report,
    this.onRetry,
    this.onOpen,
    this.onShare,
  });

  final bool success;
  final Map<String, dynamic> report;
  final VoidCallback? onRetry;
  final VoidCallback? onOpen;
  final VoidCallback? onShare;

  @override
  Widget build(BuildContext context) {
    return sheet(
      context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          sheetHandle(),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close),
            ),
          ),
          Icon(
            success ? Icons.check_circle : Icons.cancel,
            color: success ? academicsGreen : const Color(0xFFE94B45),
            size: 54,
          ),
          const SizedBox(height: 12),
          Text(
            success ? 'Report card downloaded' : 'Download failed',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            success
                ? 'Your report card has been saved to your phone.'
                : 'The report card could not be saved. Check your connection and try again.',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, color: academicsMuted),
          ),
          const SizedBox(height: 20),
          if (success) ...[
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onShare,
                    child: const Text('Share'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onOpen,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: academicsGreen,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Open PDF'),
                  ),
                ),
              ],
            ),
          ] else ...[
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: extraGreenButton('Try again', onRetry),
                ),
              ],
            ),
          ],
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}