
import 'package:flutter/material.dart';

import 'messages_widget/field_label.dart';
import 'messages_widget/green_button.dart';

class RequestMeetingBottomSheet extends StatefulWidget {
  const RequestMeetingBottomSheet({super.key});

  @override
  State<RequestMeetingBottomSheet> createState() =>
      _RequestMeetingBottomSheetState();
}

class _RequestMeetingBottomSheetState
    extends State<RequestMeetingBottomSheet> {
  final formKey = GlobalKey<FormState>();
  final topicController = TextEditingController();
  final messageController = TextEditingController();

  String selectedPerson = 'Class teacher';
  String selectedMethod = 'In person';
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  void dispose() {
    topicController.dispose();
    messageController.dispose();
    super.dispose();
  }

  InputDecoration fieldDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        fontSize: 12,
        color: Color(0xFF98A2B3),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 12,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Color(0xFFE4E7EC),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Color(0xFFE4E7EC),
        ),
      ),
    );
  }

  Future<void> chooseDate() async {
    final now = DateTime.now();

    final date = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year, now.month, now.day),
      lastDate: DateTime(now.year + 2),
    );

    if (date != null) {
      setState(() => selectedDate = date);
    }
  }

  Future<void> chooseTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time != null) {
      setState(() => selectedTime = time);
    }
  }

  void submitRequest() {
    if (!formKey.currentState!.validate()) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Demo only: meeting request has not been submitted.',
        ),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.9,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(22),
          ),
        ),
        child: SafeArea(
          top: false,
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Request a meeting',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF101828),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Arrange a meeting with your child’s school.',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF667085),
                    ),
                  ),
                  const SizedBox(height: 20),

                  const FieldLabel('Meet with'),
                  DropdownButtonFormField<String>(
                    value: selectedPerson,
                    decoration: fieldDecoration('Select a person'),
                    items: const [
                      DropdownMenuItem(
                        value: 'Class teacher',
                        child: Text('Class teacher'),
                      ),
                      DropdownMenuItem(
                        value: 'Subject teacher',
                        child: Text('Subject teacher'),
                      ),
                      DropdownMenuItem(
                        value: 'School management',
                        child: Text('School management'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => selectedPerson = value);
                      }
                    },
                  ),

                  const SizedBox(height: 16),
                  FieldLabel('Meeting topic',),
                  TextFormField(
                    controller: topicController,
                    decoration: fieldDecoration(
                      'What would you like to discuss?',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a meeting topic';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),
                  const FieldLabel('Preferred date'),
                  InkWell(
                    onTap: chooseDate,
                    child: InputDecorator(
                      decoration: fieldDecoration('Choose a date'),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              selectedDate == null
                                  ? 'Choose a date'
                                  : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                              style: TextStyle(
                                fontSize: 12,
                                color: selectedDate == null
                                    ? const Color(0xFF98A2B3)
                                    : const Color(0xFF344054),
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.calendar_today_outlined,
                            size: 17,
                            color: Color(0xFF667085),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
                  const FieldLabel('Preferred time'),
                  InkWell(
                    onTap: chooseTime,
                    child: InputDecorator(
                      decoration: fieldDecoration('Choose a time'),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              selectedTime == null
                                  ? 'Choose a time'
                                  : selectedTime!.format(context),
                              style: TextStyle(
                                fontSize: 12,
                                color: selectedTime == null
                                    ? const Color(0xFF98A2B3)
                                    : const Color(0xFF344054),
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.access_time,
                            size: 18,
                            color: Color(0xFF667085),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
                  const FieldLabel('Meeting method'),
                  DropdownButtonFormField<String>(
                    value: selectedMethod,
                    decoration: fieldDecoration('Choose a method'),
                    items: const [
                      DropdownMenuItem(
                        value: 'In person',
                        child: Text('In person'),
                      ),
                      DropdownMenuItem(
                        value: 'Phone call',
                        child: Text('Phone call'),
                      ),
                      DropdownMenuItem(
                        value: 'Virtual meeting',
                        child: Text('Virtual meeting'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => selectedMethod = value);
                      }
                    },
                  ),

                  const SizedBox(height: 16),
                  const FieldLabel('Additional message'),
                  TextFormField(
                    controller: messageController,
                    maxLines: 3,
                    decoration: fieldDecoration(
                      'Add any additional information',
                    ),
                  ),

                  const SizedBox(height: 24),
                  greenButton(
                    label: 'Send request',
                    icon: Icons.send_outlined,
                    onTap: submitRequest,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}