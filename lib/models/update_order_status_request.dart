import 'dart:convert';

import 'package:petshopdashboard/models/network_request.dart';

class UpdateOrderStatusRequest extends NetworkRequest {
  UpdateOrderStatusRequest({required this.orderId, required this.status, required this.urlRequest})
    : super(url: urlRequest);

  final String orderId;
  final String status;
  final String urlRequest;

  @override
  String? get body => json.encode({'orderId': orderId, 'orderStatus': status});
}

class UpdateOrderPaymentStatusRequest extends NetworkRequest {
  UpdateOrderPaymentStatusRequest({required this.orderId, required this.paymentStatus, required this.urlRequest})
    : super(url: urlRequest);

  final String orderId;
  final String paymentStatus;
  final String urlRequest;

  @override
  String? get body => json.encode({'orderId': orderId, 'paymentStatus': paymentStatus});
}
