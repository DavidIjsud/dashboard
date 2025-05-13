import 'package:flutter/material.dart';

class OrderItemCard extends StatelessWidget {
  final String status;
  final num totalAmount;
  final num discount;
  final num shippingCost;
  final String paymentStatus;
  final String paymentMethod;
  final String userName;

  const OrderItemCard({
    super.key,
    required this.status,
    required this.totalAmount,
    required this.discount,
    required this.shippingCost,
    required this.paymentStatus,
    required this.paymentMethod,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Estado:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  _buildStatusBadge(status),
                ],
              ),
              const Divider(),
              const SizedBox(height: 8),

              _buildDetailRow("Nombre cliente:", userName, Colors.black),

              _buildDetailRow("Total Amount:", "\$${totalAmount.toStringAsFixed(2)}", Colors.black),
              _buildDetailRow("Discount:", "-\$${discount.toStringAsFixed(2)}", Colors.red),
              _buildDetailRow("Shipping Cost:", "+\$${shippingCost.toStringAsFixed(2)}", Colors.blue),
              _buildDetailRow("Payment Status:", paymentStatus, paymentStatus == "Paid" ? Colors.green : Colors.red),
              _buildDetailRow("Payment Method:", paymentMethod, Colors.black),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color badgeColor;
    switch (status.toLowerCase()) {
      case "completed":
        badgeColor = Colors.green;
        break;
      case "pending":
        badgeColor = Colors.orange;
        break;
      case "canceled":
        badgeColor = Colors.red;
        break;
      default:
        badgeColor = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: badgeColor.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
      child: Text(status.toUpperCase(), style: TextStyle(color: badgeColor, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildDetailRow(String title, String value, Color textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: textColor)),
        ],
      ),
    );
  }
}
