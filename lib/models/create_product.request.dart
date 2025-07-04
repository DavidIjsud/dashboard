import 'dart:convert';

import 'package:petshopdashboard/models/network_request.dart';

class CreateProductRequest extends NetworkRequest {
  final String name;
  final num price;
  final int totalInStock;
  final String detailOfProduct;
  final String categoryId;
  final String urlRequest;

  CreateProductRequest({
    required this.name,
    required this.price,
    required this.totalInStock,
    required this.detailOfProduct,
    required this.categoryId,
    required this.urlRequest,
  }) : super(url: urlRequest);

  @override
  String get body => json.encode({
    'productName': name,
    'price': price,
    'totalInStock': totalInStock,
    'detailOfProduct': detailOfProduct,
    'category': categoryId,
  });
}
