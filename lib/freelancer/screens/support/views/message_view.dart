import 'package:flutter/material.dart';
import 'package:homecare_app/employer/data/models/message_model.dart';
import 'package:homecare_app/employer/providers/message_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatPage extends ConsumerStatefulWidget {
  final List<MessageModel> initialMessages;
  final int senderId;

  ChatPage({required this.initialMessages, required this.senderId});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  late List<MessageModel> _messages;
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _messages = List.from(widget.initialMessages);
  }

  Future<void> _sendMessage() async {
    final notifier = ref.read(postMessage.notifier);

    if (_messageController.text.isNotEmpty) {
      Future<bool> ok = notifier.create({
        "message_text": _messageController.text,
        "conversation_id": widget.initialMessages.first.conversation.id
      });

      if (await ok) {
        final mess = MessageModel(
          senderId: widget.senderId,
          messageText: _messageController.text,
          conversation: widget.initialMessages.first.conversation,
        );

        setState(() {
          _messages = [mess, ..._messages];
        });

        _messageController.clear();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chat Message',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(10),
              children: _messages.reversed.map((message) {
                return Align(
                  alignment: message.senderId == widget.senderId
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: ChatBubble(
                    text: message.messageText,
                    isSender: message.senderId == widget.senderId,
                  ),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: "Type a message",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(color: Colors.blueAccent),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  color: Colors.blueAccent,
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isSender;

  const ChatBubble({required this.text, required this.isSender});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isSender ? Colors.blueAccent : Colors.grey[300],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
          bottomLeft: isSender ? Radius.circular(15) : Radius.zero,
          bottomRight: isSender ? Radius.zero : Radius.circular(15),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSender ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
