
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_colors.dart';

class ParentSettingsScreen extends ConsumerStatefulWidget {
  const ParentSettingsScreen({
    super.key,
    this.onBack,
  });

  final VoidCallback? onBack;

  @override
  ConsumerState<ParentSettingsScreen> createState() =>
      _ParentSettingsScreenState();
}

class _ParentSettingsScreenState
    extends ConsumerState<ParentSettingsScreen> {
  final Map<String, bool> notifications = {
    'Attendance - late or absent': true,
    'New invoices and receipts': true,
    'Report cards': true,
    'Messages from teachers': true,
    'School events and notices': false,
  };

  final List<String> languages = [
    'English',
    'French',
    'Yoruba',
    'Igbo',
    'Hausa',
    'Spanish',
    'Arabic',
  ];

  String language = 'English';
  String defaultChild = 'Adaeze Nwosu';
  String receiptEmail = 'ngozi.nwosu@gmail.com';
  bool requirePin = true;

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(appThemeProvider);

    return Scaffold(
      backgroundColor: theme.scaffoldColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: widget.onBack ?? () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 17,
            color: Color(0xFF20252D),
          ),
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Settings',
              style: TextStyle(
                color: Color(0xFF20252D),
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'Ngozi Nwosu',
              style: TextStyle(
                color: Color(0xFF89919D),
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _settingsHeading('Notify me about'),
          ...notifications.keys.map(
                (title) => _switchRow(
              title,
              notifications[title]!,
                  (value) {
                setState(() => notifications[title] = value);
              },
            ),
          ),
          const SizedBox(height: 18),
          _settingsHeading('Preferences'),
          _settingsDropdown<String>(
            title: 'Language',
            value: language,
            items: languages,
            onChanged: (value) {
              if (value != null) {
                setState(() => language = value);
              }
            },
          ),
          _settingsDropdown<String>(
            title: 'Default child',
            value: defaultChild,
            items: const ['Adaeze Nwosu', 'Chidi Nwosu'],
            onChanged: (value) {
              if (value != null) {
                setState(() => defaultChild = value);
              }
            },
          ),
          _settingsTextRow(
            'Receipts sent to',
            receiptEmail,
            onTap: _editReceiptEmail,
          ),
          const SizedBox(height: 18),
          _settingsHeading('Security'),
          _switchRow(
            'Ask for PIN before payments',
            requirePin,
                (value) => setState(() => requirePin = value),
          ),
        ],
      ),
    );
  }

  Widget _settingsHeading(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _switchRow(
      String title,
      bool value,
      ValueChanged<bool> onChanged,
      ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 3,
      ),
      margin: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 12),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF1A7A4A),
          ),
        ],
      ),
    );
  }

  Widget _settingsDropdown<T>({
    required String title,
    required T value,
    required List<T> items,
    required ValueChanged<T?> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 12),
            ),
          ),
          DropdownButton<T>(
            value: value,
            underline: const SizedBox.shrink(),
            icon: const Icon(Icons.keyboard_arrow_down, size: 17),
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF20252D),
            ),
            items: items.map((item) {
              return DropdownMenuItem<T>(
                value: item,
                child: Text(item.toString()),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _settingsTextRow(
      String title,
      String value, {
        required VoidCallback onTap,
      }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontSize: 12),
              ),
            ),
            Flexible(
              child: Text(
                value,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 11),
              ),
            ),
            const SizedBox(width: 5),
            const Icon(Icons.chevron_right, size: 17),
          ],
        ),
      ),
    );
  }

  Future<void> _editReceiptEmail() async {
    final controller = TextEditingController(text: receiptEmail);

    final result = await showDialog<String>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Receipt email'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            labelText: 'Email address',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(
              dialogContext,
              controller.text.trim(),
            ),
            child: const Text('Save'),
          ),
        ],
      ),
    );

    controller.dispose();

    if (result != null &&
        result.isNotEmpty &&
        mounted) {
      setState(() => receiptEmail = result);
    }
  }
}