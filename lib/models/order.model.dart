import 'package:petshopdashboard/core/enums.dart';

class OrderModel {
  final num totalAmount;
  final num discountAmount;
  final num taxAmount;
  final num shippingCost;
  final PaymentMethod paymentMethod;
  final PaymentStatus paymentStatus;
  final OrderStatus orderStatus;
  final bool isOrderDeleted;
  final String userName;

  OrderModel({
    required this.totalAmount,
    required this.discountAmount,
    required this.taxAmount,
    required this.shippingCost,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.orderStatus,
    required this.isOrderDeleted,
    required this.userName,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      totalAmount: json['totalAmount'],
      discountAmount: json['discountAmount'],
      taxAmount: json['taxAmount'],
      shippingCost: json['shippingCost'],
      paymentMethod: PaymentMethod.fromString(json['paymentMethod']),
      paymentStatus: PaymentStatus.fromString(json['paymentStatus']),
      orderStatus: OrderStatus.fromString(json['status']),
      isOrderDeleted: json['isOrderDeleted'],
      userName: json['user']['name'] ?? json['userName'] ?? 'Unknown User',
    );
  }

  String getOrderStatusText() {
    return OrderStatus.orderStatusText(orderStatus);
  }

  String getPaymentMethodText() {
    return PaymentMethod.paymentMethodText(paymentMethod);
  }

  String getPaymentStatusText() {
    return PaymentStatus.paymentStatusText(paymentStatus);
  }
}
