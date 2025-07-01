import 'dart:convert';

import 'package:petshopdashboard/models/network_request.dart';

class SuspendProductRequest extends NetworkRequest {
  SuspendProductRequest({required String url, required String productId, required bool suspendProduct})
    : _suspendProduct = suspendProduct,
      super(url: url.replaceAll('{productId}', productId));

  final bool _suspendProduct;

  @override
  String? get body => jsonEncode({'suspendProduct': _suspendProduct});
}
