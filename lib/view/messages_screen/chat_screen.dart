
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String name;
  final String role;
  final String initials;
  final Color avatarColor;

  const ChatScreen({
    super.key,
    required this.name,
    required this.role,
    required this.initials,
    required this.avatarColor,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageController = TextEditingController();

  final List<Map<String, dynamic>> chatMessages = [
    {
      'text':
      'Good morning sir. Adaeze said she’s struggling with motion problems in Physics. Is there anything we can do at home?',
      'sent': false,
      'time': '8:02',
    },
    {
      'text': 'Good morning ma',
      'sent': true,
      'time': '8:02',
    },
    {
      'text':
      'Good morning Mrs. Nwosu. She’s doing well overall - Physics just needs more practice. Dr. Eze runs extra sessions on Thursday prep for SS1.',
      'sent': false,
      'time': '8:02',
    },
    {
      'text': 'Thank you sir, much appreciated.',
      'sent': true,
      'time': '8:03',
    },
    {
      'text': 'Will she need the textbook for Friday?',
      'sent': true,
      'time': '8:04',
    },
  ];

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  void sendMessage() {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      chatMessages.add({
        'text': text,
        'sent': true,
        'time': TimeOfDay.now().format(context),
      });
      messageController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios_new, size: 16),
                  ),
                  CircleAvatar(
                    radius: 14,
                    backgroundColor: widget.avatarColor,
                    child: Text(
                      widget.initials,
                      style: const TextStyle(fontSize: 9, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          widget.role,
                          style: const TextStyle(
                            fontSize: 9,
                            color: Color(0xFF98A2B3),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'TODAY',
                style: TextStyle(fontSize: 8, color: Color(0xFF98A2B3)),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: chatMessages.length,
                itemBuilder: (context, index) {
                  final item = chatMessages[index];
                  final sent = item['sent'] as bool;

                  return Align(
                    alignment:
                    sent ? Alignment.centerRight : Alignment.centerLeft,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.sizeOf(context).width * 0.78,
                      ),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 9),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: sent
                              ? const Color(0xFF1A7A4A)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                item['text'] as String,
                                style: TextStyle(
                                  fontSize: 10,
                                  height: 1.4,
                                  color: sent
                                      ? Colors.white
                                      : const Color(0xFF344054),
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item['time'] as String,
                              style: TextStyle(
                                fontSize: 8,
                                color: sent
                                    ? Colors.white70
                                    : const Color(0xFF98A2B3),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
              color: Colors.white,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.attach_file,
                      size: 19,
                      color: Color(0xFF98A2B3),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      onSubmitted: (_) => sendMessage(),
                      style: const TextStyle(fontSize: 11),
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        hintStyle: const TextStyle(
                          fontSize: 10,
                          color: Color(0xFF98A2B3),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF7F7F7),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 7),
                  InkWell(
                    onTap: sendMessage,
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.all(9),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A7A4A),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.send,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}