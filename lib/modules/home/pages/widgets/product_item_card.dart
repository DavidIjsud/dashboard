import 'package:flutter/material.dart';

class ProductItemCard extends StatelessWidget {
  final String productName;
  final int totalStock;

  const ProductItemCard({
    super.key,
    required this.productName,
    required this.totalStock,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              productName,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(width: 15.0),
            _buildStockBadge(totalStock),
          ],
        ),
      ),
    );
  }

  Widget _buildStockBadge(int stock) {
    Color badgeColor;
    String text;

    if (stock > 50) {
      badgeColor = Colors.green;
      text = "In Stock ($stock)";
    } else if (stock > 10) {
      badgeColor = Colors.orange;
      text = "Low Stock ($stock)";
    } else {
      badgeColor = Colors.red;
      text = "Out of Stock";
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: badgeColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(color: badgeColor, fontWeight: FontWeight.bold),
      ),
    );
  }
}
