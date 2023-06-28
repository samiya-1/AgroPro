import 'dart:io';

import 'package:flutter/foundation.dart';

class Product {
  final String productName;
  final String quantity;
  final double price;
  final String quality;
  final String freshness;

  Product({
    required this.productName,
    required this.quantity,
    required this.price,
    required this.quality,
    required this.freshness,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productName: json['product_name'],
      quantity: json['quantity'],
      price: json['price'].toDouble(),
      quality: json['quality'],
      freshness: json['freshness'],
    );
  }

  get id => pid;
}
