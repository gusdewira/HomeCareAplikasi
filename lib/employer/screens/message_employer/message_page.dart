import 'package:flutter/material.dart';
import 'package:homecare_app/employer/data/models/message_model.dart';
import 'package:homecare_app/employer/providers/message_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

class MessagePage extends ConsumerStatefulWidget {
  final List<MessageModel> initialMessages;
  final int senderId;
  final int conversationId;

  MessagePage(
      {required this.conversationId,
      required this.initialMessages,
      required this.senderId});

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends ConsumerState<MessagePage> {
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
        _refreshMessages();
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

  Future<void> _editMessage(int index, String message) async {
    final TextEditingController editController = TextEditingController(
      text: message,
    );
    final notifier = ref.read(postMessage.notifier);

    final result = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Message'),
          content: TextField(
            controller: editController,
            decoration: const InputDecoration(hintText: 'Edit your message'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (editController.text.isNotEmpty) {
                  Future<bool> ok = notifier.update({
                    "message_text": editController.text,
                    "conversation_id":
                        widget.initialMessages.first.conversation.id
                  }, index);

                  if (await ok) {
                    _refreshMessages();
                    Navigator.of(context).pop(editController.text);
                  }
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteMessage(int index) async {
    final notifier = ref.read(postMessage.notifier);
    Future<bool> ok = notifier.delete(index);

    if (await ok) {
      _refreshMessages();
      Navigator.of(context);
    }
  }

  Future<void> _refreshMessages() async {
    final provider = ref.read(messageProvider.notifier);
    await provider.getMessage();
  }

  @override
  Widget build(BuildContext context) {
    final messagesAsyncValue = ref.watch(messageProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chat Message',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refreshMessages,
                child: messagesAsyncValue.when(
                  data: (List<MessageModel> messages) {
                    var filteredMessages = messages
                        .where((item) => item.senderId == widget.senderId)
                        .toList();

                    var conversationMessage = filteredMessages
                        .where((item) =>
                            item.conversation.id == widget.conversationId)
                        .toList()
                        .reversed
                        .toList();

                    return ListView.builder(
                      itemCount: conversationMessage.length,
                      itemBuilder: (context, index) {
                        final message = conversationMessage[index];
                        return Align(
                          alignment: message.senderId == widget.senderId
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: ChatBubble(
                            text: message.messageText,
                            isSender: message.senderId == widget.senderId,
                            onLongPress: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Wrap(
                                    children: [
                                      ListTile(
                                        leading: const Icon(Icons.edit),
                                        title: const Text('Edit'),
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          _editMessage(
                                              message.id!, message.messageText);
                                        },
                                      ),
                                      ListTile(
                                        leading: const Icon(Icons.delete),
                                        title: const Text('Delete'),
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          _deleteMessage(message.id!);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                  error: (error, _) {
                    return LzNoData(message: 'Oops! $error');
                  },
                  loading: () {
                    return LzLoader.bar(message: 'Loading...');
                  },
                ),
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
                          borderSide:
                              const BorderSide(color: Colors.blueAccent),
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
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isSender;
  final VoidCallback? onLongPress;

  const ChatBubble({
    required this.text,
    required this.isSender,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSender ? Colors.blueAccent : Colors.grey[300],
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(15),
            topRight: const Radius.circular(15),
            bottomLeft: isSender ? const Radius.circular(15) : Radius.zero,
            bottomRight: isSender ? Radius.zero : const Radius.circular(15),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSender ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
