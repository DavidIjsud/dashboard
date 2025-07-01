import 'package:flutter/material.dart';
import 'package:petshopdashboard/models/order.model.dart';

class OrderDetailWidget extends StatelessWidget {
  final OrderModel order;

  const OrderDetailWidget({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Order ID: ${order.id}'),
          Text('Status: ${order.getOrderStatusText()}'),
          Text('Tax Amount: ${order.taxAmount}'),
          Text('Shipping Cost: ${order.shippingCost}'),
          Text('Payment Status: ${order.getPaymentStatusText()}'),
          Text('Payment Method: ${order.getPaymentMethodText()}'),
          Text('Total Payment: ${order.totalPayment}'),
          Text('Is Order Deleted: ${order.isOrderDeleted}'),
          const SizedBox(height: 16),
          Text('User:', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('  ID: ${order.user.id}'),
          Text('  Name: ${order.user.name}'),
          Text('  Email: ${order.user.email}'),
          const SizedBox(height: 16),
          Text('Products:', style: TextStyle(fontWeight: FontWeight.bold)),
          ...order.products.map(
            (product) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('  Product Name: ${product.productName}'),
                  Text('  Product ID: ${product.productId}'),
                  Text('  Quantity: ${product.quantity}'),
                  Text('  Total Payment: ${product.totalPayment}'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
