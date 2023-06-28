import 'package:flutter/material.dart';
import 'package:helloworld/screens/chatPage.dart';

class Homepage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChatPage(),
      /*Container(
    child: Center(child: Text("Chat")),
    ),*/
    bottomNavigationBar: BottomNavigationBar(
    selectedItemColor: Colors.green,
    unselectedItemColor: Colors.grey.shade600,
    selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
    unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
    type: BottomNavigationBarType.fixed,
    items: const [
    BottomNavigationBarItem(
    icon: Icon(Icons.message),
    //title: Text("Chats"),
    ),
    BottomNavigationBarItem(
    icon: Icon(Icons.group_work),
    //title: Text("Channels"),
    ),
    BottomNavigationBarItem(
    icon: Icon(Icons.account_box),
    //title: Text("Profile"),
    ),
    ],
    ),
    );

  }
}