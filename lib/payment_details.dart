import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:helloworld/API.dart';

class Pay_Details extends StatefulWidget {
  const Pay_Details({Key? key}) : super(key: key);

  @override
  State<Pay_Details> createState() => _Pay_DetailsState();
}

class _Pay_DetailsState extends State<Pay_Details> {
  List _loaddata=[];

  get prefs => null;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }
  _fetchData() async {
    var user = (prefs.getInt('user') ?? 0);
    var res = await Api().getData('/api/allpayment/$user');
    if (res.statusCode == 200) {
      var items = json.decode(res.body)['data'];
      print(items);
      setState(() {
        _loaddata = items;

      });
    } else {
      setState(() {
        _loaddata = [];
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
          title: Text('Payment Details',),
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
                        child: Icon(Icons.notifications_outlined,color: Colors.green,size: 36,),
                      ),
                      SizedBox(width: 16,),
                      Expanded(
                        flex: 6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(_loaddata[index]['payment_method'],style: TextStyle(fontSize: 16),textAlign: TextAlign.justify,),
                            Text(_loaddata[index]['amount'],style: TextStyle(fontSize: 16),textAlign: TextAlign.justify,),
                           // Text(_loaddata[index]['user'],style: TextStyle(fontSize: 16),textAlign: TextAlign.justify,),



                          ],
                        ),
                      ),
                      Text(_loaddata[index]['date'],style: TextStyle(fontSize: 16),textAlign: TextAlign.justify,),

                    ],

                  ),
                  SizedBox(height: 12,),
                  Divider(
                    color: Colors.grey[300],
                    thickness: 2,
                  )
                ],
              ),
            );
          },


        )



    );
  }
}
