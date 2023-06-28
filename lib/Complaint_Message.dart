import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helloworld/Complaint_details.dart';
import 'package:helloworld/complaint.dart';

class Comp_Message extends StatefulWidget {
  const Comp_Message({Key? key}) : super(key: key);

  @override
  State<Comp_Message> createState() => _Comp_MessageState();
}

class _Comp_MessageState extends State<Comp_Message> {
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
              child: Text("Thank you for your complaint.we will try to resolve your problem",textAlign: TextAlign.center,selectionColor: Colors.green,),

            ),

            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Complaint_Details(),));
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
