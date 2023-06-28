import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:helloworld/API.dart';
import 'package:helloworld/AllUserChats.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
class chats extends StatefulWidget {
  const chats({Key? key}) : super(key: key);

  @override
  State<chats> createState() => _chatsState();
}

class _chatsState extends State<chats> {
  TextEditingController complaintController=TextEditingController();
  DateTime datetime = DateTime.now();
  String datetime1='';
  late SharedPreferences prefs;
  late int user;
  bool _isLoading=false;
  void Addchat()

  async {
    datetime1 = DateFormat("yyyy-MM-dd").format(datetime);
    prefs = await SharedPreferences.getInstance();
    user = (prefs.getInt('user')?? 0);

    setState(() {
      _isLoading = true;
    });

    var data = {
      "chat": complaintController.text.trim(),
      "date": datetime1,
      "user":user.toString(),
    };

    print(" data${data}");
    var res = await Api().authData(data,'/api/chat');
    var body = json.decode(res.body);
    print(body);
    if(body['success']==true)
    {

      Navigator.push(context, MaterialPageRoute(builder: (context)=>Chat_Details()));
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );
    }
    else
    {
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );

    }
  }
  TextEditingController dateInput = TextEditingController();


  @override
  void initState() {
    dateInput.text = ""; //set the initial value of text field
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('chat'),
      ),

      body:  SingleChildScrollView(
        child: Column(
          children: [
            // Container(
            //   height: size.height*.35,
            //   child:
            //   Image.asset('Images/img_14.png',
            //     fit: BoxFit.cover,
            //   ),
            // ),
            Padding(
                padding:  EdgeInsets.only(left: 12,right: 12,top: 20),
                child: Container(
                    height: 350.0,
                    child: Stack(
                        children: [
                          TextField(
                            controller: complaintController,
                            maxLines: 10,
                            decoration: InputDecoration(
                              hintText: 'enter your message here!',
                              hintStyle: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),

                            ),
                          ),
                        ]
                    )
                )
            ),
            // Container(

            //
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                child: ElevatedButton(
                  onPressed: (){
                    Addchat();
                  },
                  child: Text('Send',style: TextStyle(fontSize: 19),),
                  style: ElevatedButton.styleFrom(fixedSize: Size(230, 55),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29.0)),primary: Colors.green),
                ),
              ),

            )],
        ),

      ),
    );
  }
}

// Example code to display an alert dialog after sending a chat
void showChatSentAlertDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Chat Sent'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              // Perform some action when the user taps the button
              Navigator.pop(context);
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}
