import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:helloworld/API.dart';
import 'package:helloworld/payment.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Buy_Product extends StatefulWidget {
  final int pid;
  final String price;

  Buy_Product({required this.pid, required this.price });

  @override
  State<Buy_Product> createState() => _Buy_ProductState();
}

class _Buy_ProductState extends State<Buy_Product> {
  double result = 0;
  TextEditingController quantityController = TextEditingController();
  DateTime datetime = DateTime.now();
  String datetime1 = '';
  late SharedPreferences prefs;
  late int pid;
  late int user;
  String product_name = '';
  String quantity = '';
  String image='';
  String total_amount = '';
  bool _isLoading = false;

  void _calculateTotalAmount(String value, String price) {
    double quantity = double.tryParse(value) ?? 0;
    double productPrice = double.tryParse(price) ?? 0;
    setState(() {
      result = quantity * productPrice;
      print("result${result}");
    });
  }

  void buyProduct() async {
    late int pid = widget.pid;

    prefs = await SharedPreferences.getInstance();
    user = (prefs.getInt('user') ?? 0);
    datetime1 = DateFormat("yyyy-MM-dd").format(datetime);
    setState(() {
      _isLoading = true;
    });

    double quantity = double.tryParse(quantityController.text.trim()) ?? 0;
   // _calculateTotalAmount(quantityController.text.trim(), price);

    String totalAmount = result.toString();
    var data = {
      "user": user.toString(),
      "product": pid.toString(),
      "quantity": quantityController.text.trim(),
      "date": datetime1,
      "image": image,
      "total_amount": totalAmount,
    };

    print("User data: $data");
    var res = await Api().authData(data, '/api/Productbooking');
    var body = json.decode(res.body);
    print('Response: $body');

    if (body['success'] == true) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Payment(result: result,)));
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );
    } else {
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );
    }
  }

  @override
  void initState() {
    super.initState();
   // _viewPro();
  }

  int index = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              "Buy Product",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.normal),
            ),

            const SizedBox(height: 45),
            Text(
              product_name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            const SizedBox(height: 35),
            Expanded(
              child: SingleChildScrollView(
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      Container(
                          child: Image.network(
                            Api().url+ image,width: 200,height: 200,
                          )

                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: quantityController,
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  setState(() {
                                   // _calculateTotalAmount(value, price);
                                  });
                                },
                                decoration: InputDecoration(
                                  labelText: "Enter the quantity",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _calculateTotalAmount(quantityController.text.trim(), widget.price);
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(29.0),
                              ),
                              backgroundColor: Colors.green,
                              fixedSize: const Size(50, 57),
                            ),
                            child: Text(
                              "Get ",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 45),
                      Text(
                        'The amount to be paid:',
                      ),

                      Text(
                        result.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 45),
                      ElevatedButton(
                        onPressed: () {
                          buyProduct();
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(29.0),
                          ),
                          backgroundColor: Colors.green,
                          fixedSize: const Size(50, 57),
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
            ),
          ],
        ),
      ),
    );
  }
}
