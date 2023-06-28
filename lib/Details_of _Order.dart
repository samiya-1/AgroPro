import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class List_orders extends StatefulWidget {
  const List_orders({Key? key}) : super(key: key);

  @override
  State<List_orders> createState() => _List_ordersState();
}

class _List_ordersState extends State<List_orders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Order Details")),
      body: ListView.builder(
          itemCount: 9,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
                leading: const Icon(Icons.list),
                trailing: const Text(
                  "GFG",
                  style: TextStyle(color: Colors.green, fontSize: 15),
                ),
                title: Text("order name $index"));
          }),
    );
  }
}
