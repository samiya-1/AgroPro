// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:helloworld/cartadditional.dart';
// import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// class cartitemsample extends StatefulWidget {
//   const cartitemsample({Key? key}) : super(key: key);
//
//   @override
//   State<cartitemsample> createState() => _cartitemsampleState();
// }
// String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
// class _cartitemsampleState extends State<cartitemsample> {
//   // ApiService client = ApiService();
//   bool _isLoading = false;
//   var product;
//   late SharedPreferences prefs;
//   List<CartModel> cart=[];
//   bool isLoading = false;
//   late int user_id, cart_id;
//   late int qty;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     fetchCart();
//   }
//
//
//   Future<void> fetchCart() async {
//     prefs = await SharedPreferences.getInstance();
//     user_id = (prefs.getInt('user_id') ?? 0);
//
//     var response = await Api().getData(
//         '/api/singlecart/' + user_id.toString());
//     if (response.statusCode == 200) {
//       var items =json.decode(response.body);
//       print(("cat items${items}"));
//       //  var parsedData = json.decode(items);
//       List<dynamic> cartData = items['data'];
//       cart = cartData
//           .where((item) => item['cart_status'] == '0')
//           .map((item) => CartModel.fromJson(item))
//           .toList();
//       setState(() {
//         cart;
//       });
//
//     }
//     else {
//       setState(() {
//         cart = [];
//         Fluttertoast.showToast(
//           msg: "Currently there is no data available",
//           backgroundColor: Colors.grey,
//         );
//       });
//     }
//   }
//
//   _deleteData(int id) async {
//     var res = await Api().deleteData('/api/deletecart/' + id.toString());
//     if (res.statusCode == 200) {
//       var items =json.decode(res.body);
//       setState(() {
//         print("items${items}");
//         Navigator.pushReplacement(
//             context, MaterialPageRoute(builder: (context) => cartitemsample()));
//         Fluttertoast.showToast(
//           msg: "Removed from cart",
//           backgroundColor: Colors.grey,
//         );
//       });
//
//     } else {
//       setState(() {
//         cart = [];
//         Fluttertoast.showToast(
//           msg: "Currently there is no data available",
//           backgroundColor: Colors.grey,
//         );
//       });
//     }
//   }
//
//   _increment(int id) async {
//     setState(() {
//       var _isLoading = true;
//     });
//
//     var res = await Api().putsData('/api/cart_increment/' + id.toString());
//     var body = json.decode(res.body);
//     print(body);
//     if (body['success'] == true) {
//       print(body);
//       setState(() {
//         // qty++;
//         Navigator.pushReplacement(
//             context, MaterialPageRoute(builder: (context) => cartitemsample()));
//       });
//       /*   Fluttertoast.showToast(
//         msg: body['message'].toString(),
//         backgroundColor: Colors.grey,
//       );*/
//
//     } else {
//       // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       //   content: Text("message",
//       //     style: TextStyle(fontSize: 16),
//       //   ),
//       // ));
//       Fluttertoast.showToast(
//         msg: body['message'].toString(),
//         backgroundColor: Colors.grey,
//       );
//     }
//   }
//
//   _decrement(int id) async {
//     setState(() {
//       var _isLoading = true;
//     });
//
//     var res = await Api().putsData('/api/cart_decrement/' + id.toString());
//     var body = json.decode(res.body);
//     print(body);
//     if (body['success'] == true) {
//       print(body);
//       setState(() {
//         //  qty--;
//         Navigator.pushReplacement(
//             context, MaterialPageRoute(builder: (context) => cartitemsample()));
//       });
//       /*  Fluttertoast.showToast(
//         msg: body['message'].toString(),
//         backgroundColor: Colors.grey,
//       );*/
//
//     } else {
//       Fluttertoast.showToast(
//         msg: body['message'].toString(),
//         backgroundColor: Colors.grey,
//       );
//     }
//   }
//
//   Future PlaceOrders() async {
//     prefs = await SharedPreferences.getInstance();
//     user_id = (prefs.getInt('user_id') ?? 0);
//     print('login_id_complaint ${user_id}');
//     setState(() {
//       _isLoading = true;
//     });
//
//     var data = {
//       "user": user_id.toString(),
//       "order_dt":formattedDate
//
//     };
//     print(data);
//     var res = await Api().authData(data,'/api/order');
//     var body = json.decode(res.body);
//     print(body);
//     if (body['success'] == true) {
//       cart.clear();
//
//       // Navigator.pushReplacement(
//       //     context, MaterialPageRoute(builder: (context) =>PlaceOrder()));
//       print(body);
//       Fluttertoast.showToast(
//         msg: body['message'].toString(),
//         backgroundColor: Colors.grey,
//       );
//     }
//     else{
//       Fluttertoast.showToast(
//         msg: body['message'].toString(),
//         backgroundColor: Colors.grey,
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text('My Cart'),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 10),
//             child: Icon(
//               Icons.shopping_cart_rounded,
//               color: Colors.white,
//             ),
//           ),
//         ],
//         centerTitle: true,
//       ),
//       body:cart.isEmpty
//           ? EmptyCartImage() // Show empty cart image
//           : ListView.builder(
//         shrinkWrap: true,
//         itemCount: cart.length,
//         itemBuilder: (context, index) {
//           product = cart[index];
//           // final firstWord = cart[index].name.split(' ').first;
//           cart_id = cart[index].id;
//           qty= cart[index].quantity ;
//           return Card(
//               child: Padding(
//                 padding:
//                 const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       height: 150,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8),
//                           color: Colors.grey[200]),
//                       child: Column(
//                         children: [
//                           Container(
//                             height: 80,
//                             width: 120,
//                             decoration: BoxDecoration(
//                               image: DecorationImage(
//                                 image: NetworkImage(
//                                     Api().url + cart[index].imageUrl),
//                                 fit: BoxFit.fill,
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 5),
//                           Text(
//                             cart[index].name,
//                           ),
//                           SizedBox(height: 5),
//                           Text(
//                             "₹"+cart[index].price.toString(),
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 15),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Column(
//                       children: [
//                         IconButton(
//                           icon: Icon(
//                             Icons.delete,color: Colors.red,
//                           ),
//                           onPressed: () {
//                             setState(() {
//                               _deleteData(cart_id);
//
//                             });
//                           },
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Container(
//                               width: 30,
//                               height: 30,
//                               child: FloatingActionButton(
//                                 onPressed: () {
//                                   setState(() {
//                                     _decrement(cart[index].id);
//                                   });
//                                 },
//                                 backgroundColor: Colors.green,
//                                 child:
//                                 Icon(Icons.remove, color: Colors.white),
//                               ),
//                             ),
//                             SizedBox(
//                               width: 10,
//                             ),
//                             Text(
//                               '${qty}'.toString(),
//                             ),
//                             SizedBox(
//                               width: 10,
//                             ),
//                             Container(
//                               width: 30,
//                               height: 30,
//                               child: FloatingActionButton(
//                                 onPressed: () {
//                                   setState(() {
//
//                                     _increment(cart[index].id);
//
//                                   });
//                                 },
//                                 backgroundColor: Colors.green,
//                                 child: Icon(Icons.add, color: Colors.white),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ));
//         },),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Material(
//           color: Colors.yellow,
//           child: InkWell(
//             onTap: () {
//               PlaceOrders();
//             },
//             child: const SizedBox(
//               height: kToolbarHeight,
//               width: double.infinity,
//               child: Center(
//                 child: Text(
//                   'Place Order',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }