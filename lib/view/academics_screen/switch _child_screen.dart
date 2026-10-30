
import 'package:axix_parent_app/view/academics_screen/widgets/sheet.dart';
import 'package:axix_parent_app/view/academics_screen/widgets/sheet_handle.dart';
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
    return sheet(
      context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sheetHandle(),
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