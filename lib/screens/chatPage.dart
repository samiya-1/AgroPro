import 'package:flutter/material.dart';
import 'package:helloworld/widgets/conversationList.dart';

import '../widgets/chats.dart';
import '../models/chatusersmodel.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}
class _ChatPageState extends State<ChatPage> {
  List<ChatUsers> chatUsers = [
  ChatUsers(text: "Jane Russel", secondaryText: "Awesome Setup", image: "Images/img.png", time: "Now", name: 'Afeefa', messageText: 'hello ', imageURL: 'Images/img.png'),
  ChatUsers(text: "Jane Russel",
  secondaryText: "Awesome Setup",
  image: "Images/img_3.png",
  time: "10.30am",
  name: 'Aparna',
  messageText: 'how are you', imageURL: 'Images/img_3.png'),
    ChatUsers(text: "Jane Russel",
        secondaryText: "Awesome Setup",
        image: "Images/Images/img_4.png",
        time: "Now",
        name: 'Mushrifa',
        messageText: 'you there? ', imageURL: 'Images/img_4.png'),
    ChatUsers(text: "Jane Russel",
        secondaryText: "Awesome Setup",
        image: "Images/Images/img_6.png",
        time: "yesterday",
        name: 'Kavya',
        messageText: 'call me ', imageURL: 'Images/img_6.png'),
 ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 16,right: 16,top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Conversations",style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),),
                    Container(
                      padding: EdgeInsets.only(left: 8,right: 8,top: 2,bottom: 2),
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.pink[50],
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.add,color: Colors.green,size: 20,),
                          SizedBox(width: 2,),
                          Text("Add New",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                          Padding(
                            padding: EdgeInsets.only(top: 16,left: 16,right: 16),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "Search...",
                                hintStyle: TextStyle(color: Colors.grey.shade600),
                                prefixIcon: Icon(Icons.search,color: Colors.grey.shade600, size: 20,),
                                filled: true,
                                fillColor: Colors.grey.shade100,
                                contentPadding: EdgeInsets.all(8),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade100
                                    )
                                ),
                              ),
                            ),
                          ),
                        ],

                      ),

                    )
                  ],
                ),
              ),
            ),
            ListView.builder(
              itemCount: chatUsers.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 16),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index){
                return ConversationList(
                  name: chatUsers[index].name,
                  messageText: chatUsers[index].messageText,
                  imageUrl: chatUsers[index].imageURL,
                  time: chatUsers[index].time,
                  isMessageRead: (index == 0 || index == 3)?true:false,
                );
              },
            ),
            // ListView.builder(
            //   itemCount: chatUsers.length,
            //   shrinkWrap: true,
            //   padding: EdgeInsets.only(top: 16),
            //   physics: NeverScrollableScrollPhysics(),
            //   itemBuilder: (context, index){
            //     return GestureDetector(
            //       onTap: (){
            //         Navigator.push(context, MaterialPageRoute(builder: (context)=>Chats()));
            //       },
            //       child: ConversationList(
            //         name: chatUsers[index].name,
            //         messageText: chatUsers[index].messageText,
            //         imageUrl: chatUsers[index].imageURL,
            //         time: chatUsers[index].time,
            //         isMessageRead: (index == 0 || index == 3)?true:false,
            //       ),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );

  }

}