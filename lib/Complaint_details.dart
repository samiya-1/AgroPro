import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:helloworld/API.dart';
import 'package:helloworld/complaint.dart';

class Complaint_Details extends StatefulWidget {
   Complaint_Details({Key? key}) : super(key: key);
   @override
   State<Complaint_Details> createState() => _Complaint_DetailsState();
}
class _Complaint_DetailsState extends State<Complaint_Details> {

   List _loaddata=[];
   @override
   void initState() {
     // TODO: implement initState
     super.initState();
     _fetchData();
   }
  _fetchData() async {
    var res = await Api()
        .getData('/api/alluser_complaint');
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
          title: Text('Complaint_Details',),

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
                        child: Icon(Icons.dangerous,color: Colors.green,size: 36,),
                      ),
                      SizedBox(width: 16,),
                      Expanded(
                        flex: 6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text(_loaddata[index]['complaint'],style: TextStyle(fontSize: 16),textAlign: TextAlign.justify,),

                          ],
                        ),
                      ),
                      SizedBox(width: 14,),

                      Text(_loaddata[index]['date'],style: TextStyle(fontSize: 15))
                    ],
                  ),
                  SizedBox(height: 12,),
                  Row(
                    children: [
                      Text("Reply: "),
                      Text(_loaddata[index]['reply'],style: TextStyle(fontSize: 15))
                    ],
                  ),
                  Divider(
                    color: Colors.grey[300],
                    thickness: 2,
                  )
                ],
              ),
            );
          },


        ),


    floatingActionButton: FloatingActionButton.extended(
    onPressed: () {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Complaint(),));

    },
    label: const Text('New'),
    icon: const Icon(Icons.add),
    backgroundColor: Colors.green,
    ),

    );
  }
}
