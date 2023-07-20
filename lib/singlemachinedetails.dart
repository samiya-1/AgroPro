import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:helloworld/API.dart';
import 'package:helloworld/buy_machine.dart';
import 'package:helloworld/machinenavbar.dart';
import 'package:helloworld/rent_machine.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Single_Machine extends StatefulWidget {
  final int id;
  Single_Machine({ required this.id});

  @override
  State<Single_Machine> createState() => _Single_MachineState();
}
class _Single_MachineState extends State<Single_Machine> {
  TextEditingController quantityController=TextEditingController();
  late SharedPreferences prefs;
  late int mid;

  String machine_name='';
  String quantity='';
  String image='';
  String price='';
  String cost_of_maintanence='';
  String motor_capacity='';
  String speed='';
  String quality='';
  String warranty='';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _viewPro();
  }

  Future<void> _viewPro() async {
    prefs = await SharedPreferences.getInstance();
    mid =widget.id;
    print('singlemachine ${mid}');
    var res = await Api()
        .getData('/api/singlemachine/' + mid.toString());
    var body = json.decode(res.body);
    print(body);
    setState(() {
      machine_name = body['data']['machine_name'];
      quantity = body['data']['quantity'];
      image=body['data']['image'];
      price=body['data']['price'];
      cost_of_maintanence=body['data']['cost_of_maintanence'];
      motor_capacity=body['data']['motor_capacity'];
      speed=body['data']['speed'];
      quality=body['data']['quality'];
      warranty=body['data']['warranty'];
      print(price);

    });
  }

  int index = 0;

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      //endDrawer: NavBarM(),
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
        child:
        Column(
          children: [
            SizedBox(height: 24,),
            Text(machine_name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
            Container(

                child: Image.network(
                  Api().url+ image,width: 300,
                  height: 300,
                )

            ),

            Row(

              children: [
                Column(
                  children: [
                    Text('Details:\n',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 25,color: Colors.green),),

                SizedBox(height: 10,),
                Row(
                  children: [
                    Text('Quantity:-',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    Text(quantity,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.grey),),
                  ],
                ),

                SizedBox(height: 15,),
                Row(
                  children: [
                    Text('Warranty:-',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    Text(warranty,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.grey),),
                  ],
                ),

                SizedBox(height: 15,),
                Row(
                  children: [
                    Text('Cost of Maintanence:-',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    Text(cost_of_maintanence,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.grey),),
                  ],
                ),


            SizedBox(height: 15,),
            Row(
              children: [
                Text('Motor Capacity:-',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                Text(motor_capacity,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.grey),),
              ],
            ),

            SizedBox(height: 15,),
            Row(
              children: [
                Text('Speed:-',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                Text(speed,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.grey),),
              ],
            ),

            SizedBox(height: 15,),
            Row(
              children: [
                Text('Quality:-',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                Text(quality,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.grey),),
              ],
            ),

            SizedBox(height: 15,),
            Row(
              children: [
                Text('Price:-',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                Text(price,textAlign: TextAlign.justify,style: TextStyle(fontSize: 17),),
              ],
            )
              ]
            ),
          ]
        ),


                SizedBox(height: 15,),
            Column(
              children: [
                SingleChildScrollView(
                  child: Align(
                    child: Center(
                      child: Row(
                        children: [
                          SizedBox(height: 35,width: 20,),
                          ElevatedButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Buy_Machine(mid: mid, price: price,)));
                          },
                            style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29.0)),primary: Colors.green,fixedSize: Size(150, 57)),
                            child: Text("Buy",style: TextStyle(
                                fontSize: 18,color: Colors.white
                            ),),),


                        SizedBox(height: 35,width: 100,),
                        ElevatedButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Rent_Machine(price:price, mid: mid,)));
                        },
                          style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29.0)),primary: Colors.green
                              ,fixedSize: Size(150, 57)),
                          child: Text("Rent",style: TextStyle(
                              fontSize: 18,color: Colors.white
                          ),
                          ),
                        ),
              ]  ),
                    ),
                  ),
                ),

    ],
    ),
        ]),

      ),
    );
  }
}
