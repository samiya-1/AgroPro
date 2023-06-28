import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:helloworld/API.dart';
import 'package:helloworld/feedback%20Message.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
class Rating extends StatefulWidget {
   Rating({Key? key}) : super(key: key);

  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  TextEditingController feedbackController=TextEditingController();
  DateTime datetime = DateTime.now();
  String datetime1='';
  late SharedPreferences prefs;
  late int user;
  bool _isLoading=false;
  void AddFeedback()
  async {
    datetime1 = DateFormat("yyyy-MM-dd").format(datetime);
    prefs = await SharedPreferences.getInstance();
    user = (prefs.getInt('user')?? 0);
    setState(() {
      _isLoading = true;
    });

    var data = {
      "feedback": feedbackController.text.trim(),
      "date": datetime1,
      "user":user.toString(),
    };

    print(" data${data}");
    var res = await Api().authData(data,'/api/feedback');
    var body = json.decode(res.body);
    print(body);
    if(body['success']==true)
    {

      Navigator.push(context, MaterialPageRoute(builder: (context)=>Feed_Message()));
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
        title: Text('Feedback'),
      ),

      body:  SingleChildScrollView(
        child: Column(
            children: [
              const SizedBox(height: 35,),
              Container(
                height: size.height*.35,
                child:
                Image.asset('Images/feedback.jpg',
                  fit: BoxFit.fill
                  ,
                )
              ),
              //  SizedBox(height: 35,),
              // Text('Rating'),
            // RatingBar.builder(
            //   initialRating: 3,
            //   minRating: 1,
            //   direction: Axis.horizontal,
            //   allowHalfRating: true,
            //   itemCount: 5,
            //   itemPadding:
            //   EdgeInsets.symmetric(horizontal: 4.0),
            //   itemBuilder: (context, _) => Icon(
            //     Icons.star,
            //     color: Colors.green,
            //   ),
            //   onRatingUpdate: (rating) {
            //     print(rating);
            //   },
            // ),

              Padding(
                padding: const EdgeInsets.only(left: 12,right: 12,top: 20),
                child: Container(
                  height: 350.0,
                  child: Stack(

                    children: [
                       TextField(
                controller: feedbackController,
                        maxLines: 10,
                        decoration:  InputDecoration(
                          hintText: 'Enter your feedback if any',
                          hintStyle: TextStyle(
                              fontSize: 15,
                              color: Colors.black54
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),

                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          child: ElevatedButton(
                            onPressed: (){
                              AddFeedback();
                            },
                            child: Text('Submit',style: TextStyle(fontSize: 19),),
                            style: ElevatedButton.styleFrom(fixedSize: Size(100, 55),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29.0)),primary: Colors.green),
                          ),
                        ),
                      )
                    ],
                  ),

                ),


              ),
            ],
          ),
      ),


    );
  }
}
