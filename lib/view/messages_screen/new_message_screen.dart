
import 'package:axix_parent_app/view/messages_screen/chat_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewMessageBottomSheet extends ConsumerStatefulWidget {
  const NewMessageBottomSheet({super.key});

  @override
  ConsumerState<NewMessageBottomSheet> createState() =>
      _NewMessageBottomSheetState();
}

class _NewMessageBottomSheetState
    extends ConsumerState<NewMessageBottomSheet> {
  final TextEditingController searchController =
  TextEditingController();

  final List<Map<String, dynamic>> teachers = [
    {
      'name': 'Mr. Adebayo Okafor',
      'role': 'Class teacher',
      'initials': 'MA',
      'color': const Color(0xFFB42318),
    },
    {
      'name': 'Dr. Eze',
      'role': 'Chemistry - Physics',
      'initials': 'DE',
      'color': const Color(0xFF635BFF),
    },
    {
      'name': 'Mr. Bello',
      'role': 'Mathematics',
      'initials': 'MB',
      'color': const Color(0xFF2C93FF),
    },
  ];

  final List<Map<String, dynamic>> offices = [
    {
      'name': 'Bursary',
      'role': 'Fees and payments',
    },
    {
      'name': 'Admin office',
      'role': 'Records, transport, general',
    },
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;

    final filteredTeachers = teachers.where((teacher) {
      final query = searchController.text.toLowerCase();
      return teacher['name'].toString().toLowerCase().contains(query) ||
          teacher['role'].toString().toLowerCase().contains(query);
    }).toList();

    final filteredOffices = offices.where((office) {
      final query = searchController.text.toLowerCase();
      return office['name'].toString().toLowerCase().contains(query) ||
          office['role'].toString().toLowerCase().contains(query);
    }).toList();

    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.85,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 18, 18, 12),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'New message',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF101828),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      borderRadius: BorderRadius.circular(20),
                      child: const Padding(
                        padding: EdgeInsets.all(4),
                        child: Icon(
                          Icons.close,
                          size: 20,
                          color: Color(0xFF667085),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'About Adaeze · SS1B',
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xFF98A2B3),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // Search field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: TextField(
                  controller: searchController,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: 'Search teachers or offices',
                    hintStyle: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF98A2B3),
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 19,
                      color: Color(0xFF98A2B3),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: Color(0xFFE4E7EC),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: Color(0xFFE4E7EC),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Scrollable contacts
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(18, 0, 18, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'TEACHERS',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF98A2B3),
                        ),
                      ),

                      const SizedBox(height: 8),

                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFFECEFF2),
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Column(
                          children: [
                            for (int i = 0;
                            i < filteredTeachers.length;
                            i++)
                              _contactTile(
                                name: filteredTeachers[i]['name'],
                                role: filteredTeachers[i]['role'],
                                initials: filteredTeachers[i]['initials'],
                                color: filteredTeachers[i]['color'] as Color,
                                showDivider:
                                i < filteredTeachers.length - 1,
                              ),
                            if (filteredTeachers.isEmpty)
                              _emptyResult(),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      const Text(
                        'OFFICES',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF98A2B3),
                        ),
                      ),

                      const SizedBox(height: 8),

                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFFECEFF2),
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Column(
                          children: [
                            for (int i = 0;
                            i < filteredOffices.length;
                            i++)
                              _contactTile(
                                name: filteredOffices[i]['name'],
                                role: filteredOffices[i]['role'],
                                isOffice: true,
                                showDivider:
                                i < filteredOffices.length - 1,
                              ),
                            if (filteredOffices.isEmpty)
                              _emptyResult(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _contactTile({
    required String name,
    required String role,
    String? initials,
    Color? color,
    bool isOffice = false,
    bool showDivider = true,
  }) {
    return InkWell(
      onTap: () {
        // Close the bottom sheet when a contact is selected.
        Navigator.pop(context);


        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ChatScreen(name: name,
                role: role, initials: initials!, avatarColor: color as Color)
          ),
        );
        // Navigate to your chat screen here if required.
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          border: showDivider
              ? const Border(
            bottom: BorderSide(
              color: Color(0xFFECEFF2),
            ),
          )
              : null,
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 13,
              backgroundColor: isOffice
                  ? const Color(0xFFF2F4F7)
                  : color,
              child: isOffice
                  ? const Icon(
                Icons.apartment,
                size: 14,
                color: Color(0xFF667085),
              )
                  : Text(
                initials ?? '',
                style: const TextStyle(
                  fontSize: 9,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF344054),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    role,
                    style: const TextStyle(
                      fontSize: 9,
                      color: Color(0xFF98A2B3),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              size: 18,
              color: Color(0xFF98A2B3),
            ),
          ],
        ),
      ),
    );
  }

  Widget _emptyResult() {
    return const Padding(
      padding: EdgeInsets.all(14),
      child: Text(
        'No results found',
        style: TextStyle(
          fontSize: 11,
          color: Color(0xFF98A2B3),
        ),
      ),
    );
  }
}