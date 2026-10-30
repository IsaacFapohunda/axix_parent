import 'package:flutter/material.dart';

import '../report_download_screen.dart';
import '../report_downloading_screen.dart';
import '../reportcard_preview_screen.dart';
import '../switch _child_screen.dart';


class ReportCardsTab extends StatefulWidget {
  const ReportCardsTab({
    super.key,
    required this.childName,
  });

  final String childName;

  @override
  State<ReportCardsTab> createState() => _ReportCardsTabState();
}

class _ReportCardsTabState extends State<ReportCardsTab> {
  // Replace these dummy records with your report-card API response.
  final List<Map<String, dynamic>> reports = [
    {
      'id': 'report-1',
      'term': 'First Term · 2025/2026',
      'fileName': 'Adaeze_Nwosu_SS1B_First_Term_2025-26.pdf',
      'published': '10 Apr 2026',
      'size': '412 KB',
      'isLatest': true,
      'isWithheld': false,
      'status': 'ready',
    },
    {
      'id': 'report-2',
      'term': 'Third Term · 2024/2025',
      'fileName': 'Adaeze_Nwosu_Third_Term_2025.pdf',
      'published': '25 Jul 2025',
      'size': '398 KB',
      'isLatest': false,
      'isWithheld': false,
      'status': 'ready',
    },
    {
      'id': 'report-3',
      'term': 'Second Term · 2024/2025',
      'fileName': 'Adaeze_Nwosu_Second_Term_2025.pdf',
      'published': '04 Apr 2025',
      'size': '405 KB',
      'isLatest': false,
      'isWithheld': false,
      'status': 'ready',
    },
    {
      'id': 'report-4',
      'term': 'First Term · 2024/2025',
      'fileName': 'Adaeze_Nwosu_First_Term_2024.pdf',
      'published': '13 Dec 2024',
      'size': '391 KB',
      'isLatest': false,
      'isWithheld': false,
      'status': 'ready',
    },
  ];

  // Set from the API when the latest report is withheld.
  bool latestReportWithheld = false;

  // Connect these callbacks to your existing payment and PDF services.
  Future<bool> Function(Map<String, dynamic> report)? downloadReport;
  VoidCallback? onPayOutstandingFees;
  void Function(Map<String, dynamic> report)? onOpenPdf;
  void Function(Map<String, dynamic> report)? onSharePdf;

  Future<void> openPreview(Map<String, dynamic> report) async {
    if (report['isWithheld'] == true) {
      showWithheldMessage();
      return;
    }

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ReportCardPreviewBottomSheet(report: report),
    );
  }

  void showWithheldMessage() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.lock_outline,
                  color: Color(0xFFE89A25),
                  size: 42,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Report card is withheld',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'The report card will be released once the outstanding fees are paid.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF7B8490),
                  ),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: onPayOutstandingFees == null
                        ? null
                        : () {
                      Navigator.pop(context);
                      onPayOutstandingFees!();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF197B4B),
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Pay outstanding fees'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _downloadReport(Map<String, dynamic> report) async {
    if (report['isWithheld'] == true ||
        (report['isLatest'] == true && latestReportWithheld)) {
      showWithheldMessage();
      return;
    }

    // First show the downloading sheet.
    final downloadingRoute = showModalBottomSheet<void>(
      context: context,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (_) => ReportDownloadingBottomSheet(report: report),
    );

    // Give Flutter time to display the downloading sheet.
    await Future<void>.delayed(const Duration(milliseconds: 350));

    bool success = false;

    try {
      if (downloadReport != null) {
        success = await downloadReport!(report);
      } else {
        // Demo only: no real PDF is downloaded until the API is connected.
        await Future<void>.delayed(const Duration(seconds: 2));
        success = false;
      }
    } catch (_) {
      success = false;
    }

    if (!mounted) return;

    // Close the downloading sheet before opening the result sheet.
    Navigator.of(context).pop();
    await downloadingRoute;

    if (!mounted) return;

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ReportDownloadResultBottomSheet(
        success: success,
        report: report,
        onRetry: () {
          Navigator.pop(context);
          _downloadReport(report);
        },
        onOpen: () {
          Navigator.pop(context);
          onOpenPdf?.call(report);
        },
        onShare: () {
          Navigator.pop(context);
          onSharePdf?.call(report);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final latest = reports.first;

    final withheld =
        latestReportWithheld || latest['isWithheld'] == true;

    return ListView(
      padding: const EdgeInsets.fromLTRB(14, 4, 14, 24),
      children: [
        if (withheld)
          _withheldCard(latest)
        else
          _latestReadyCard(latest),
        const SizedBox(height: 20),
        Row(
          children: [
            const Expanded(
              child: Text(
                'All report cards',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Text(
              '${reports.length}',
              style: const TextStyle(
                color: Color(0xFF197B4B),
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE9EDF0)),
          ),
          child: Column(
            children: reports.map((report) {
              final isWithheld = report['isWithheld'] == true ||
                  (report['isLatest'] == true && latestReportWithheld);

              return reportRow(report, isWithheld);
            }).toList(),
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Report cards are issued as signed PDFs. Scores and remarks are on the PDF only.',
          style: TextStyle(
            fontSize: 10,
            height: 1.5,
            color: Color(0xFF8993A1),
          ),
        ),
      ],
    );
  }

  Widget _latestReadyCard(Map<String, dynamic> report) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF6EF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD4EBDD)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.description_outlined,
                color: Color(0xFF197B4B),
                size: 25,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'First Term report card is ready',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Signed by the principal · ${report['published']}',
                      style: const TextStyle(
                        fontSize: 9,
                        color: Color(0xFF7B8490),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton.icon(
              onPressed: () => _downloadReport(report),
              icon: const Icon(Icons.download, size: 15),
              label: const Text(
                'Download report card',
                style: TextStyle(fontSize: 11),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF197B4B),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget reportRow(Map<String, dynamic> report, bool withheld) {
    return InkWell(
      onTap: () => openPreview(report),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xFFECEFF2)),
          ),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.description_outlined,
              color: Color(0xFF8A94A1),
              size: 21,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    report['term']?.toString() ?? '',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Published ${report['published']} · PDF · ${report['size']}',
                    style: const TextStyle(
                      fontSize: 9,
                      color: Color(0xFF8993A1),
                    ),
                  ),
                  if (withheld) ...[
                    const SizedBox(height: 4),
                    const Text(
                      'Withheld',
                      style: TextStyle(
                        color: Color(0xFFB87916),
                        fontSize: 10,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            // Only this icon starts a download.
            IconButton(
              tooltip: withheld ? 'Report withheld' : 'Download report card',
              onPressed: withheld
                  ? showWithheldMessage
                  : () => _downloadReport(report),
              icon: Icon(
                withheld ? Icons.lock_outline : Icons.download_outlined,
                color: withheld
                    ? const Color(0xFFE89A25)
                    : const Color(0xFF197B4B),
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _withheldCard(Map<String, dynamic> report) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF7E8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFFE5B4)),
      ),
      child: Column(
        children: [
          const Row(
            children: [
              Icon(Icons.lock_outline, color: Color(0xFFE89A25)),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Report card is withheld',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Released once outstanding fees are paid.',
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(0xFFB87916),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton(
              onPressed: () {
                if (onPayOutstandingFees != null) {
                  onPayOutstandingFees!();
                } else {
                  showWithheldMessage();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF197B4B),
                foregroundColor: Colors.white,
              ),
              child: const Text('Pay outstanding fees'),
            ),
          ),
        ],
      ),
    );
  }
}