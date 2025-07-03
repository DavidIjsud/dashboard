import 'dart:convert';

import 'package:petshopdashboard/models/network_request.dart';

class OrderRequest extends NetworkRequest {
  OrderRequest({required this.urlOrdrs, this.searchTermName, this.dateOrderCreated, this.orderStatus})
    : super(url: urlOrdrs);
  final String urlOrdrs;
  final String? searchTermName;
  final String? dateOrderCreated;
  final String? orderStatus;

  Map<String, dynamic>? _toMapOrNull() {
    final map = {'clientName': searchTermName, 'dateOrderCreated': dateOrderCreated, 'orderStatus': orderStatus};
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
