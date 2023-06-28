import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:helloworld/API.dart';
import 'package:helloworld/buy_product.dart';
import 'package:helloworld/productnavbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Single_Product extends StatefulWidget {
  final int id;

  Single_Product({ required this.id});

  @override
  State<Single_Product> createState() => _Single_ProductState();
}
class _Single_ProductState extends State<Single_Product> {
  TextEditingController quantityController=TextEditingController();

  late SharedPreferences prefs;
  late int pid;

  String product_name='';
  String quantity='';
  String image='';
  String price='';
  String quality='';
  String freshness='';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _viewPro();
  }

  Future<void> _viewPro() async {
    prefs = await SharedPreferences.getInstance();
    pid =widget.id;
    print('singleproduct ${pid}');
    var res = await Api()
        .getData('/api/singleProduct/' + pid.toString());
    var body = json.decode(res.body);
    print(body);
    setState(() {
      product_name = body['data']['product_name'];
      quantity = body['data']['quantity'];
      image=body['data']['image'];
      price=body['data']['price'];
      quality=body['data']['quality'];
      freshness=body['data']['freshness'];
      print(price);

    });
  }
  // List<Map<String, dynamic>> _loaddata = [
  //   {'image': 'image'},
  //   {'image': 'image'},
  //   // Add more data entries as needed
  // ];
  int index = 0;


  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      //endDrawer: NavBarP(),
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body:
      SingleChildScrollView(
        child:
        Column(
          children: [
            SizedBox(height: 10,),
            Container(
                child: Image.network(
                  Api().url+ image,width: 200,height: 200,
                )

            ),

            SizedBox(height: 24,),
            Text(product_name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text('Details:',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.green),),
                    SizedBox(height: 15,),
                    Text('quantity:-'),
                    Text(quantity,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.grey),),
                    SizedBox(height: 15,),
                    Text('price:-'),
                    Text(price,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.grey),),
                    SizedBox(height: 15,),
                    Text('quality:-'),
                    Text(quality,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.grey),),
                    Text('freshness:-'),
                    Text(freshness,textAlign: TextAlign.justify,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.grey),),
                  ],
                ),


              ],
            ),
            SizedBox(height: 30,),
            Column(
              children: [
                SingleChildScrollView(
                  child: Align(
                    child: Center(
                      child: Row(
                        children: [
                        SizedBox(height: 35,width: 100,),
                         ElevatedButton(onPressed: (){
                          // registerUser();
                           Navigator.push(context, MaterialPageRoute(builder: (context)=>Buy_Product(pid: pid,price:price)));
                        },
                          style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),primary: Colors.green,fixedSize: Size(200, 57)),
                          child: Text("Buy",style: TextStyle(
                              fontSize: 18,color: Colors.white
                          ),),),

        ]  ),
    ),
    ),
    ),
    ],
    ),


    ]

    )
    )

    );
  }
}
