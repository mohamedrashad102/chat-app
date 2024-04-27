import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final messageController = TextEditingController();

  bool isSender = true;

  final List<MessageModel> messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kprimaryColor,
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 80, height: 80, child: Image.asset(kscholar)),
            const SizedBox(width: 10),
            const Text('chat'),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ListView.separated(
                itemBuilder: (context, index) => ChatBubble(
                    isSender: messages[index].isSender,
                    message: messages[index].message),
                itemCount: messages.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
              ),
            ),
          ),
          Container(
            color: kprimaryColor,
            child: TextField(
              controller: messageController,
              maxLines: null,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: kprimaryColor)),
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: kprimaryColor)),
                prefixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isSender = !isSender;
                    });
                  },
                  icon: Icon(
                    isSender ? Icons.call_made : Icons.call_received,
                  ),
                ),
                suffixIcon: IconButton(
                    onPressed: () {
                      if (messageController.text.trim().isNotEmpty) {
                        messages.add(
                          MessageModel(
                            isSender: isSender,
                            message: messageController.text,
                          ),
                        );
                        setState(() {
                          messageController.clear();
                        });
                      }
                    },
                    icon: const Icon(
                      Icons.send,
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
