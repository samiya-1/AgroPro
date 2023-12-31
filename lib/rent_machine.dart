import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:helloworld/API.dart';
import 'package:helloworld/pay.dart';
import 'package:helloworld/payment.dart';
import 'package:helloworld/paymentmachinerent.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Rent_Machine extends StatefulWidget {
  final int mid;
  final String price;
  Rent_Machine({ required this.mid, required this.price});

  @override
  State<Rent_Machine> createState() => _Rent_MachineState();
}

class _Rent_MachineState extends State<Rent_Machine> {
  double result = 0;
  TextEditingController quantityController=TextEditingController();
  DateTime datetime = DateTime.now();
  String datetime1='';
  late SharedPreferences prefs;
  late int mid;
  late int user;
  String machine_name='';
  String quantity='';
  String total_amount='';

  bool _isLoading=false;

  void _calculateTotalAmount(String value, String price) {
    double quantity = double.tryParse(value) ?? 0;
    double productPrice = double.tryParse(price) ?? 0;
    setState(() {
      result = (quantity * productPrice)*25/100;
      print("result${result}");
    });
  }

  void Rentmachine()async {

    late int mid=widget.mid;

    prefs = await SharedPreferences.getInstance();
    user=(prefs.getInt('user')?? 0);
    datetime1 = DateFormat("yyyy-MM-dd").format(datetime);
    setState(() {
      _isLoading = true;
    });
    String totalAmount = result.toString();
    var data = {
      "user":user.toString(),
      "machine":mid.toString(),
      "quantity": quantityController.text.trim(),
      "date":datetime1,
      "total_amount": totalAmount,
    };

    print("machine data${data}");
    var res = await Api().authData(data,'/api/addmachinesell');
    var body = json.decode(res.body);
    print('res${body}');
    if(body['success']==true)
    {

      Navigator.push(context, MaterialPageRoute(builder: (context)=>Payment(result: result,)));
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _viewPro();
  }


  int index = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("Rent Machines",style:
          TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
          SizedBox(height: 25,),
          Text("On Buying Items on rent you will have a decrease of 75% of actual price.",style: TextStyle(fontSize: 40,fontWeight: FontWeight.w100),),

          const SizedBox(height: 20),
          Text(machine_name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          const SizedBox(height: 35),
          Expanded(
            child: SingleChildScrollView(
              child: Align(
                alignment: Alignment.center,
                child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),
                    // Container(
                    //   child: Image.network(
                    //     Api().url+ image,
                    //     width: 200,
                    //     height: 200,
                    //   ),
                    // ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: quantityController,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          _calculateTotalAmount(value, widget.price);
                        });
                      },
                      decoration: InputDecoration(
                        labelText: "Enter the quantity",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     setState(() {
                    //       _calculateTotalAmount(quantityController.text.trim(), widget.price);
                    //     });
                    //   },
                    //   style: ElevatedButton.styleFrom(
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(29.0),
                    //     ),
                    //     backgroundColor: Colors.green,
                    //     padding: const EdgeInsets.symmetric(vertical: 15),
                    //   ),
                    //   child: Text(
                    //     "Calculate Total",
                    //     style: TextStyle(
                    //       fontSize: 18,
                    //       color: Colors.white,
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(height: 20),
                    Text(
                      'Total Amount:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      result.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Rentmachine();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(29.0),
                        ),
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: Text(
                        "Buy",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ),
           ] ),

         ] ),
        )
              ),
            )
    ]  ),
    ),
    );
  }
}

