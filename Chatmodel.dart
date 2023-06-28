import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Message> messages = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchMessages();
  }

  Future<void> fetchMessages() async {
    setState(() {
      isLoading = true;
    });

    // Call your backend API to fetch messages
    // Pass the starting point and number of messages to fetch
    // Example: List<Message> newMessages = await yourApi.getMessages(startIndex, count);

    // Simulating API call delay
    await Future.delayed(Duration(seconds: 2));

    // Dummy messages for demonstration
    List<Message> newMessages = [
      Message(sender: 'User1', text: 'Hello'),
      Message(sender: 'User2', text: 'Hi'),
      Message(sender: 'User1', text: 'How are you?'),
    ];

    setState(() {
      messages.addAll(newMessages);
      isLoading = false;
    });
  }

  Future<void> loadMoreMessages() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    // Determine the starting point and number of messages to fetch
    // Example: int startIndex = messages.length;
    //          int count = 10;

    // Call your backend API to fetch more messages
    // Example: List<Message> moreMessages = await yourApi.getMessages(startIndex, count);

    // Simulating API call delay
    await Future.delayed(Duration(seconds: 2));

    // Dummy messages for demonstration
    List<Message> moreMessages = [
      Message(sender: 'User2', text: 'I\'m good, thanks!'),
      Message(sender: 'User1', text: 'That\'s great to hear!'),
    ];

    setState(() {
      messages.addAll(moreMessages);
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(messages[index].sender),
                  subtitle: Text(messages[index].text),
                );
              },
            ),
          ),
          isLoading
              ? CircularProgressIndicator() // Show a loading indicator while fetching messages
              : ElevatedButton(
            onPressed: loadMoreMessages,
            child: Text('Load More'),
          ),
        ],
      ),
    );
  }
}

class Message {
  final String sender;
  final String text;

  Message({required this.sender, required this.text});
}
