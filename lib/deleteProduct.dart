// // Example code for deleting a product
// import 'dart:io';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import 'Product.dart';
// import 'package:http/http.dart' as http;
//
// class DeleteProduct extends StatefulWidget {
//   // ...
//
//   @override
//   _DeleteProductState createState() => _DeleteProductState();
// }
//
// class _DeleteProductState extends State<DeleteProduct> {
//   List<Product> products = []; // Assuming you have a list of products
//
//   Future<void> deleteProduct(int user) async {
//
//     try {
//       // Send a DELETE request to your API endpoint with the product ID
//       final response = await http.delete(Uri.parse('your_api_url/products/$productId'));
//
//       if (response.statusCode == 200) {
//         // Delete operation was successful
//         setState(() {
//           products.removeWhere((product) => product.id == pid);
//         });
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text('Product deleted successfully.'),
//         ));
//       } else {
//         // Delete operation failed
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text('Failed to delete product.'),
//         ));
//       }
//     } catch (e) {
//       // Error occurred during delete operation
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('An error occurred.'),
//       ));
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: products.length,
//       itemBuilder: (context, index) {
//         final product = products[index];
//         return ListTile(
//           title: Text(product.productName),
//           trailing: IconButton(
//             icon: Icon(Icons.delete),
//             onPressed: () {
//               showDialog(
//                 context: context,
//                 builder: (context) => AlertDialog(
//                   title: Text('Confirm Delete'),
//                   content: Text('Are you sure you want to delete this product?'),
//                   actions: [
//                     TextButton(
//                       child: Text('Cancel'),
//                       onPressed: () => Navigator.pop(context),
//                     ),
//                     TextButton(
//                       child: Text('Delete'),
//                       onPressed: () {
//                         deleteProduct(product.id);
//                         Navigator.pop(context);
//                       },
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }
