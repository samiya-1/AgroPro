import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helloworld/Home.dart';
import 'package:helloworld/products.dart';

class Pay_Message extends StatefulWidget {  const Pay_Message({Key? key}) : super(key: key);

  @override
  State<Pay_Message> createState() => _Pay_MessageState();
}

class _Pay_MessageState extends State<Pay_Message> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    backgroundColor: Colors.white,
    body:  Center(
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      Image.asset("Images/tick.png",
        height: 100,
        width: 100,
        alignment: Alignment.topCenter,),
      Padding(padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      child: Text("Your payment was done successfully",textAlign: TextAlign.center,selectionColor: Colors.green,),

      ),

      ElevatedButton(onPressed: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Products(),));
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
