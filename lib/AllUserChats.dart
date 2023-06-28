import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:helloworld/API.dart';
import 'package:helloworld/chats.dart';

class Chat_Details extends StatefulWidget {
  Chat_Details({Key? key}) : super(key: key);
  @override
  State<Chat_Details> createState() => _Chat_DetailsState();
}
class _Chat_DetailsState extends State<Chat_Details> {

  List _loaddata=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }
  _fetchData() async {
    var res = await Api()
        .getData('/api/alluser');
    if (res.statusCode == 200) {
      var items = json.decode(res.body)['data'];
      print(items);
      setState(() {
        _loaddata = items;

      });
    } else {
      setState(() {
        _loaddata =[];
        Fluttertoast.showToast(
          msg:"Currently there is no data available",
          backgroundColor: Colors.grey,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Chat Details',),

      ),

      body: ListView.builder(
        shrinkWrap: true,
        itemCount: _loaddata.length,
        itemBuilder: (context,index){

          return Padding(
            padding: const EdgeInsets.only(top: 16,right: 12,left: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.verified_user_rounded,color: Colors.green,size: 36,),
                    ),
                    SizedBox(width: 16,),
                    Expanded(
                      flex: 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(_loaddata[index]['name'],style: TextStyle(fontSize: 16),textAlign: TextAlign.justify,),

                        ],
                      ),
                    ),
                    SizedBox(width: 14,),
                    ElevatedButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => chats()));
                      },
                      child: Text('Message',style: TextStyle(fontSize: 19),),
                      style: ElevatedButton.styleFrom(fixedSize: Size(200, 55),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),primary: Colors.green),
                    ),
                   // Text(_loaddata[index]['date'],style: TextStyle(fontSize: 15))
                  ],
                ),
                SizedBox(height: 12,),
                Divider(
                  color: Colors.grey[300],
                  thickness: 2,
                ),

              ],
            ),
          );
        },


      ),


    );
  }
}


















// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:helloworld/API.dart';
// import 'package:helloworld/Complaint_Message.dart';
// import 'package:helloworld/chats.dart';
// import 'package:intl/intl.dart';












// import 'package:shared_preferences/shared_preferences.dart';
// class Single_Chat extends StatefulWidget {
//   const Single_Chat({Key? key}) : super(key: key);
//
//   @override
//   State<Single_Chat> createState() => _Single_ChatState();
// }
//
// class _Single_ChatState extends State<Single_Chat> {
//   TextEditingController messageController=TextEditingController();
//   DateTime datetime = DateTime.now();
//   String datetime1='';
//   late SharedPreferences prefs;
//   late int user;
//   bool _isLoading=false;
//   void Addchat()
//
//   async {
//     datetime1 = DateFormat("yyyy-MM-dd").format(datetime);
//     prefs = await SharedPreferences.getInstance();
//     user = (prefs.getInt('user')?? 0);
//
//     setState(() {
//       _isLoading = true;
//     });
//
//     var data = {
//       "complaint": messageController.text.trim(),
//       "date": datetime1,
//       "user":user.toString(),
//     };
//
//     print(" data${data}");
//     var res = await Api().authData(data,'/api/user_complaint/id');
//     var body = json.decode(res.body);
//     print(body);
//     if(body['success']==true)
//     {
//
//       Navigator.push(context, MaterialPageRoute(builder: (context)=>Chat_Details()));
//       Fluttertoast.showToast(
//         msg: body['message'].toString(),
//         backgroundColor: Colors.grey,
//       );
//     }
//     else
//     {
//       Fluttertoast.showToast(
//         msg: body['message'].toString(),
//         backgroundColor: Colors.grey,
//       );
//
//     }
//   }
//   TextEditingController dateInput = TextEditingController();
//
//   @override
//   void initState() {
//     dateInput.text = ""; //set the initial value of text field
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     var size=MediaQuery.of(context).size;
//     return Scaffold(
//
//       appBar: AppBar(
//         backgroundColor: Colors.green,
//         title: Text('chat'),
//       ),
//
//       body:  SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               height: size.height*.35,
//               child:
//               Image.asset('Images/img_14.png',
//                 fit: BoxFit.cover,
//               ),
//             ),
//             Padding(
//                 padding:  EdgeInsets.only(left: 12,right: 12,top: 20),
//                 child: Container(
//                     height: 350.0,
//                     child: Stack(
//                         children: [
//                           TextField(
//                             controller: messageController,
//                             maxLines: 10,
//                             decoration: InputDecoration(
//                               hintText: 'Enter your Message',
//                               hintStyle: TextStyle(
//                                   fontSize: 15,
//                                   color: Colors.grey
//                               ),
//                               border: OutlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.grey),
//                               ),
//
//                             ),
//                           ),
//                         ]
//                     )
//                 )
//             ),
//             // Container(
//
//            // itemCount: _loaddata.length,
//             //Text(_loaddata[index]['reply'],style: TextStyle(fontSize: 16),textAlign: TextAlign.justify,),
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: Container(
//                 child:
//                 ElevatedButton(
//                   onPressed: (){
//                     Addchat();
//                   },
//                   child: Text('Submit',style: TextStyle(fontSize: 19),),
//                   style: ElevatedButton.styleFrom(fixedSize: Size(230, 55),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29.0)),primary: Colors.green),
//                 ),
//               ),
//
//             )],
//         ),
//
//       ),
//     );
//   }
// }
