import 'dart:io';

import 'package:flutter/material.dart';
import 'package:petshopdashboard/models/category.dart';
import 'package:petshopdashboard/modules/home/viewmodels/home_viewmodel.dart';
import 'package:provider/provider.dart';

class ProductEditor extends StatefulWidget {
  final String imageUrl;
  final num price;
  final String name;
  final String description;
  final int stock;
  final String categoryID;
  final String productID;

  const ProductEditor({
    super.key,
    required this.imageUrl,
    required this.price,
    required this.name,
    required this.description,
    required this.stock,
    required this.categoryID,
    required this.productID,
  });

  @override
  State<ProductEditor> createState() => _ProductEditorState();
}

class _ProductEditorState extends State<ProductEditor> {
  late TextEditingController nameController;
  late TextEditingController priceController;
  late TextEditingController descController;
  late TextEditingController stockController;

  Category? selectedCategory;
  List<Category> categories = [];

  bool isFormValid = false;

  late final HomeViewmodel _homeViewModel;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    priceController = TextEditingController(text: widget.price.toString());
    descController = TextEditingController(text: widget.description);
    stockController = TextEditingController(text: widget.stock.toString());

    _addListeners();
    _validateForm();

    // Obtener las categorías del ViewModel
    _homeViewModel = context.read<HomeViewmodel>();
    categories = _homeViewModel.state?.categories ?? [];
    selectedCategory = _homeViewModel.state?.getCategoryById(widget.categoryID);
  }

  @override
  void didUpdateWidget(covariant ProductEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    categories = _homeViewModel.state?.categories ?? [];

    if (widget.name != oldWidget.name) {
      nameController.text = widget.name;
    }
    if (widget.price != oldWidget.price) {
      priceController.text = widget.price.toString();
    }
    if (widget.description != oldWidget.description) {
      descController.text = widget.description;
    }
    if (widget.stock != oldWidget.stock) {
      stockController.text = widget.stock.toString();
    }

    if (widget.categoryID != oldWidget.categoryID) {
      selectedCategory = context.read<HomeViewmodel>().state?.getCategoryById(widget.categoryID);
    }

    _validateForm();
  }

  void _addListeners() {
    nameController.addListener(_validateForm);
    priceController.addListener(_validateForm);
    descController.addListener(_validateForm);
    stockController.addListener(_validateForm);
  }

  void _validateForm() {
    final isValid =
        nameController.text.trim().isNotEmpty &&
        priceController.text.trim().isNotEmpty &&
        descController.text.trim().isNotEmpty &&
        stockController.text.trim().isNotEmpty &&
        selectedCategory != null &&
        widget.productID.isNotEmpty;

    if (isFormValid != isValid) {
      setState(() {
        isFormValid = isValid;
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    descController.dispose();
    stockController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                context.read<HomeViewmodel>().hideProductDetail();
              },
            ),
          ),

          // Imagen
          GestureDetector(
            onTap: () {
              _homeViewModel.pickImage();
            },
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Consumer<HomeViewmodel>(
                  builder: (_, homeViewModel, w) {
                    return homeViewModel.state?.productsState.fileToUpload != null
                        ? Image.network(
                          homeViewModel.state!.productsState.fileToUpload!.path,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 100),
                        )
                        : Image.network(
                          widget.imageUrl,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 100),
                        );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Product Name')),
          const SizedBox(height: 12),

          TextField(
            controller: priceController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(labelText: 'Price'),
          ),
          const SizedBox(height: 12),

          TextField(
            controller: descController,
            maxLines: 3,
            decoration: const InputDecoration(labelText: 'Descripcion'),
          ),
          const SizedBox(height: 12),

          TextField(
            controller: stockController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Cantidad en Stock'),
          ),
          const SizedBox(height: 12),

          DropdownButtonFormField<Category>(
            value: selectedCategory,
            items:
                categories.map((cat) => DropdownMenuItem<Category>(value: cat, child: Text(cat.name ?? ''))).toList(),
            decoration: const InputDecoration(labelText: 'Categoria'),
            onChanged: (value) {
              setState(() {
                selectedCategory = value;
              });
              _validateForm();
            },
          ),
          const SizedBox(height: 24),

          Center(
            child: Consumer<HomeViewmodel>(
              builder: (_, HomeViewmodel homeViewModel, __) {
                return homeViewModel.state?.productsState.isUpdatingProduct == true
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                      onPressed:
                          isFormValid
                              ? () {
                                homeViewModel.updateProduct(
                                  id: widget.productID,
                                  name: nameController.text.trim(),
                                  price: double.parse(priceController.text.trim()),
                                  totalInStock: int.parse(stockController.text.trim()),
                                  detailOfProduct: descController.text.trim(),
                                  categoryId: selectedCategory?.id ?? '',
                                );
                              }
                              : null,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text('Edit', style: TextStyle(fontSize: 16)),
                    );
              },
            ),
          ),
        ],
      ),
    );
  }
}
