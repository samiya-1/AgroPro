 import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:helloworld/API.dart';

class MarketPrice extends StatefulWidget {
   MarketPrice({Key? key}) : super(key: key);

  @override
  State<MarketPrice> createState() => _ClassNotifyState();
}

class _ClassNotifyState extends State<MarketPrice> {

  List _loaddata=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }
  _fetchData() async {
    var res = await Api()
        .getData('/api/allmarketprice');
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
          title: Text('Market prices',),

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
                        child: Icon(Icons.price_change,color: Colors.green,size: 36,),
                      ),
                      SizedBox(width: 16,),
                      Expanded(
                        flex: 6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row( children:[
                              Text("product name:"),
                              Text(_loaddata[index]['product_name'],style: TextStyle(fontSize: 16),textAlign: TextAlign.justify,),
                           ]
                            ),
                            Row( children:[
                              Text("date:"),
                              Text(_loaddata[index]['date'],style: TextStyle(fontSize: 16),textAlign: TextAlign.justify,),
                            ]
                            ),
                            Row( children:[
                              Text("unit:"),
                              Text(_loaddata[index]['unit'],style: TextStyle(fontSize: 16),textAlign: TextAlign.justify,),
                            ]
                            ),
                            Row( children:[
                              Text("price:"),
                              Text(_loaddata[index]['price'],style: TextStyle(fontSize: 16),textAlign: TextAlign.justify,),
                            ]
                            ),

                          ],
                        ),
                      ),
                      SizedBox(width: 14,),
                      Text("change:"),
                      Text(_loaddata[index]['change'],style: TextStyle(fontSize: 15))
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
