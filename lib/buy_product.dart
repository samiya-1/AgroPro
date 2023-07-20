import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:helloworld/pay.dart';
import 'package:helloworld/payment.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'API.dart';

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
      Navigator.push(context, MaterialPageRoute(builder: (context) => Pay(result: result,)));
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
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Buy Product",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              product_name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Align(
                  alignment: Alignment.center,
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
                            buyProduct();
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
