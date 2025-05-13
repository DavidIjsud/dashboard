import 'package:flutter/material.dart';
import 'package:petshopdashboard/core/widgets/button.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final num price;
  final String imageUrl;
  final String description;
  final int totalInStock;
  final int totalAmountOfProduct;
  final bool isSuspended;

  const ProductCard({
    super.key,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.totalInStock,
    required this.totalAmountOfProduct,
    required this.isSuspended,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              imageUrl,
              width: double.infinity,
              height: 180,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 180),
            ),
          ),
          // Info
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 4),
                Text(
                  '\$${price.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.green),
                ),
                const SizedBox(height: 8),
                Text(description, maxLines: 3, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('In Stock: $totalInStock'), Text('Total: $totalAmountOfProduct')],
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(text: 'Eliminar', onPressed: () {}, color: Colors.red),
              CustomButton(text: isSuspended ? 'Activar' : 'Suspender', onPressed: () {}, color: Colors.yellow),
            ],
          ),
        ],
      ),
    );
  }
}
