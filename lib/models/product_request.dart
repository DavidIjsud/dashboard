import 'dart:convert';

import 'package:petshopdashboard/models/network_request.dart';

class ProductRequest extends NetworkRequest {
  ProductRequest({
    required this.urlProducts,
    this.searchTerm,
    this.selectedCategoryId,
    this.stockMin,
    this.stockMax,
    this.priceMin,
    this.priceMax,
    this.isSuspended,
  }) : super(url: urlProducts);

  final String urlProducts;
  final String? searchTerm;
  final String? selectedCategoryId;
  final int? stockMin;
  final int? stockMax;
  final double? priceMin;
  final double? priceMax;
  final bool? isSuspended;

  Map<String, dynamic>? _toMapOrNull() {
    final map = {
      'productName': searchTerm,
      'categoryId': selectedCategoryId,
      'totalOfProductsInStockMoreThan': stockMin,
      'totalOfProductsInStockLessThan': stockMax,
      'priceMoreThan': priceMin,
      'priceLessThan': priceMax,
      'isSuspended': isSuspended,
    };
    if (map.values.any((v) => v != null)) {
      return map;
    }
    return null;
  }

  @override
  String? get body {
    final map = _toMapOrNull();
    return map != null ? json.encode(map) : null;
  }
}
