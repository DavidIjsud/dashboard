import 'package:flutter/material.dart';
import 'package:petshopdashboard/core/widgets/button.dart';
import 'package:petshopdashboard/modules/home/viewmodels/home_viewmodel.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatefulWidget {
  final String name;
  final num price;
  final String imageUrl;
  final String description;
  final int totalInStock;
  final bool isSuspended;
  final String productID;

  const ProductCard({
    super.key,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.totalInStock,
    required this.isSuspended,
    required this.productID,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  late final HomeViewmodel _homeViewModel;

  @override
  void initState() {
    super.initState();
    _homeViewModel = context.read<HomeViewmodel>();
  }

  @override
  Widget build(BuildContext context) {
    print('Image URL: ${widget.imageUrl}');
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
              Uri.encodeFull(widget.imageUrl),
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
                Text(widget.name, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 4),
                Text(
                  '\$${widget.price.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.green),
                ),
                const SizedBox(height: 8),
                Text(widget.description, maxLines: 2, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('In Stock: ${widget.totalInStock}')],
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(text: 'Eliminar', onPressed: () {}, color: Colors.red),
              CustomButton(
                text: widget.isSuspended ? 'Activar' : 'Suspender',
                onPressed: () {
                  _homeViewModel.suspendProduct(widget.productID, !widget.isSuspended);
                },
                color: Colors.yellow,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
