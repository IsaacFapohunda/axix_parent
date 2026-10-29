
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

const Color academicsGreen = Color(0xFF197B4B);
const Color academicsText = Color(0xFF18212B);
const Color academicsMuted = Color(0xFF7B8490);

class SwitchChildBottomSheet extends StatelessWidget {
  const SwitchChildBottomSheet({
    super.key,
    required this.children,
    required this.selectedChild,
  });

  final List<Map<String, String>> children;
  final String selectedChild;

  @override
  Widget build(BuildContext context) {
    return _sheet(
      context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sheetHandle(),
          const Text(
            'Switch child',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 5),
          const Text(
            'Choose a child to view their academics.',
            style: TextStyle(fontSize: 12, color: academicsMuted),
          ),
          const SizedBox(height: 18),
          ...children.map((child) {
            final selected = child['name'] == selectedChild;

            return InkWell(
              onTap: () => Navigator.pop(context, child),
              child: Container(
                margin: const EdgeInsets.only(bottom: 9),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: selected
                      ? const Color(0xFFEAF6EF)
                      : Colors.white,
                  border: Border.all(
                    color: selected
                        ? academicsGreen
                        : const Color(0xFFE8EBEF),
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 17,
                      backgroundColor: const Color(0xFF2D91FF),
                      child: Text(
                        child['initials'] ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            child['name'] ?? '',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            child['class'] ?? '',
                            style: const TextStyle(
                              fontSize: 11,
                              color: academicsMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      selected
                          ? Icons.check_circle
                          : Icons.circle_outlined,
                      color: selected ? academicsGreen : academicsMuted,
                      size: 20,
                    ),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}

class ExplainAbsenceBottomSheet extends StatefulWidget {
  const ExplainAbsenceBottomSheet({
    super.key,
    required this.date,
    this.onSubmit,
  });

  final String date;
  final Future<void> Function({
  required String reason,
  required String note,
  PlatformFile? attachment,
  })? onSubmit;

  @override
  State<ExplainAbsenceBottomSheet> createState() =>
      _ExplainAbsenceBottomSheetState();
}

class _ExplainAbsenceBottomSheetState
    extends State<ExplainAbsenceBottomSheet> {
  final TextEditingController noteController = TextEditingController();

  final List<String> reasons = [
    'Illness',
    'Medical appointment',
    'Family emergency',
    'Travel',
    'Other',
  ];

  String selectedReason = 'Illness';
  PlatformFile? attachment;
  bool submitting = false;

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null && mounted) {
      setState(() => attachment = result.files.single);
    }
  }

  Future<void> _submit() async {
    setState(() => submitting = true);

    try {
      await widget.onSubmit?.call(
        reason: selectedReason,
        note: noteController.text.trim(),
        attachment: attachment,
      );

      if (mounted) Navigator.pop(context, true);
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not submit the explanation.')),
        );
      }
    } finally {
      if (mounted) setState(() => submitting = false);
    }
  }

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _sheet(
      context,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _sheetHandle(),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Explain an absence',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, size: 20),
                ),
              ],
            ),
            const Text(
              'The class teacher will review it.',
              style: TextStyle(fontSize: 11, color: academicsMuted),
            ),
            const SizedBox(height: 18),
            const _FieldLabel('Day'),
            const SizedBox(height: 7),
            _outlinedText(widget.date, readOnly: true),
            const SizedBox(height: 16),
            const _FieldLabel('Reason'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 7,
              runSpacing: 8,
              children: reasons.map((reason) {
                final selected = reason == selectedReason;

                return ChoiceChip(
                  label: Text(reason),
                  selected: selected,
                  onSelected: (_) =>
                      setState(() => selectedReason = reason),
                  selectedColor: academicsText,
                  backgroundColor: Colors.white,
                  labelStyle: TextStyle(
                    fontSize: 11,
                    color: selected ? Colors.white : academicsText,
                  ),
                  side: BorderSide(
                    color: selected
                        ? academicsText
                        : const Color(0xFFE2E6EA),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            const _FieldLabel('Note to the class teacher'),
            const SizedBox(height: 7),
            TextField(
              controller: noteController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Explain the reason for the absence...',
                hintStyle: const TextStyle(fontSize: 12),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(9),
                  borderSide: const BorderSide(color: Color(0xFFE2E6EA)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(9),
                  borderSide: const BorderSide(color: Color(0xFFE2E6EA)),
                ),
              ),
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: _pickFile,
              borderRadius: BorderRadius.circular(9),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFFDCE2E7),
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.attach_file,
                      size: 18,
                      color: academicsGreen,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        attachment?.name ??
                            'Attach a doctor’s note (optional)',
                        style: const TextStyle(fontSize: 11),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Icon(Icons.upload_file, size: 18),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            _greenButton(
              submitting ? 'Submitting...' : 'Submit explanation',
              submitting ? null : _submit,
            ),
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
          ],
        ),
      ),
    );
  }
}

class ReportCardPreviewBottomSheet extends StatelessWidget {
  const ReportCardPreviewBottomSheet({
    super.key,
    required this.report,
  });

  final Map<String, dynamic> report;

  @override
  Widget build(BuildContext context) {
    return _sheet(
      context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sheetHandle(),
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
          _greenButton('Close', () => Navigator.pop(context)),
        ],
      ),
    );
  }
}

class ReportDownloadingBottomSheet extends StatelessWidget {
  const ReportDownloadingBottomSheet({
    super.key,
    required this.report,
  });

  final Map<String, dynamic> report;

  @override
  Widget build(BuildContext context) {
    return _sheet(
      context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _sheetHandle(),
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
    return _sheet(
      context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _sheetHandle(),
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
                  child: _greenButton('Try again', onRetry),
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

Widget _sheet(BuildContext context, {required Widget child}) {
  return Container(
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
    ),
    padding: EdgeInsets.fromLTRB(
      20,
      10,
      20,
      20 + MediaQuery.of(context).viewPadding.bottom,
    ),
    child: SafeArea(
      top: false,
      child: child,
    ),
  );
}

Widget _sheetHandle() {
  return Center(
    child: Container(
      width: 38,
      height: 4,
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: const Color(0xFFD9DEE3),
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
    );
  }
}

Widget _outlinedText(String value, {bool readOnly = false}) {
  return TextField(
    readOnly: readOnly,
    controller: TextEditingController(text: value),
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9),
        borderSide: const BorderSide(color: Color(0xFFE2E6EA)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(9),
        borderSide: const BorderSide(color: Color(0xFFE2E6EA)),
      ),
    ),
  );
}

Widget _greenButton(String label, VoidCallback? onPressed) {
  return SizedBox(
    width: double.infinity,
    height: 44,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: academicsGreen,
        foregroundColor: Colors.white,
        disabledBackgroundColor: const Color(0xFF9DBDAB),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
      ),
    ),
  );
}