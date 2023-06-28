import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:helloworld/API.dart';
import 'package:shared_preferences/shared_preferences.dart';

class method_Details extends StatefulWidget {

  final int id;

  method_Details({ required this.id});


  @override
  State<method_Details> createState() => _method_DetailsState();
}

class _method_DetailsState extends State<method_Details> {

  late SharedPreferences prefs;
  late int mtid;
  String title='';
  String content='';



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _viewPro();
  }

  Future<void> _viewPro() async {
    prefs = await SharedPreferences.getInstance();

    mtid =widget.id;
    print('methodupdate ${mtid}');
    var res = await Api()
        .getData('/api/singlemethod' + mtid.toString());
    var body = json.decode(res.body);
    print(body);
    setState(() {
      title = body['data']['fertilizer_name'];
      content = body['data']['details'];
      print(content);

    });
  }

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10,),
            // Container(
            //     height: size.height*.40,
            //     child: Image.network(
            //       Api().url+ image,
            //     )
            //
            // ),
            SizedBox(height: 24,),
            Text(title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Details : ',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 10,color: Colors.grey),),
                SizedBox(width: 10),
                // Text(orphanage_name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.grey),),
              ],
            ),
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(content,textAlign: TextAlign.justify,style: TextStyle(fontSize: 17),),
            ),
          ],
        ),
      ),

    );
  }
}
