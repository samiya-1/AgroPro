import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helloworld/feedback_details.dart';

class Feed_Message extends StatefulWidget {
  const Feed_Message({Key? key}) : super(key: key);

  @override
  State<Feed_Message> createState() => _Feed_MessageState();
}

class _Feed_MessageState extends State<Feed_Message> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("Images/Thankyou.jpg",
              height: 200,
              width: 200,
              alignment: Alignment.topCenter,),
            Padding(padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              child: Text("Thank you For your Feedback",textAlign: TextAlign.center,selectionColor: Colors.green,),

            ),

            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>feedbackdetails(),));
            },
              style:ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),primary: Colors.green,fixedSize: Size(200, 50)),
              child: Text("OK",style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}
