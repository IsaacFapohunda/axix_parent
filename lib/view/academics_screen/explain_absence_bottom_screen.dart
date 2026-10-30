
import 'dart:ui';

import 'package:axix_parent_app/view/academics_screen/switch%20_child_screen.dart';
import 'package:axix_parent_app/view/academics_screen/widgets/extra_green_button.dart';
import 'package:axix_parent_app/view/academics_screen/widgets/outlined_text.dart';
import 'package:axix_parent_app/view/academics_screen/widgets/sheet.dart';
import 'package:axix_parent_app/view/academics_screen/widgets/sheet_handle.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../messages_screen/messages_widget/field_label.dart';

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


  //uncomment to allow to pick file

  //this will work on flutter upgrade
  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null && mounted) {
      setState(() => attachment = result.files.single);
    }
  }


  Future<void> submit() async {
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
    return sheet(
      context,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            sheetHandle(),
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
            const FieldLabel('Day'),
            const SizedBox(height: 7),
            outlinedText(widget.date, readOnly: true),
            const SizedBox(height: 16),
            const FieldLabel('Reason'),
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
            const FieldLabel('Note to the class teacher'),
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
              onTap: pickFile,
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
            extraGreenButton(
              submitting ? 'Submitting...' : 'Submit explanation',
              submitting ? null : submit,
            ),
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
          ],
        ),
      ),
    );
  }
}