import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:helloworld/API.dart';

import 'methodTechnique_Details.dart';

class Method_Technique extends StatefulWidget {
  const Method_Technique({Key? key}) : super(key: key);

  @override
  State<Method_Technique> createState() => _ClassNotifyState();
}

class _ClassNotifyState extends State<Method_Technique> {
  List _loaddata=[];

  var id;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }
  _fetchData() async {
    var res = await Api()
        .getData('/api/allmethod');
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
          title: Text('Method and Techniques',),

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
                      SizedBox(width: 16,),
                      Expanded(
                        flex: 6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text(_loaddata[index]['fertilizer_name'],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily: AutofillHints.username),textAlign: TextAlign.justify,),
                            SizedBox(height: 20,),
                            Text(_loaddata[index]['details'],style: TextStyle(fontSize: 16),textAlign: TextAlign.justify,),

                          ],
                        ),
                      ),
                      SizedBox(width: 14,),

                      // Text(_loaddata[index]['measurement'],style: TextStyle(fontSize: 15))

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
