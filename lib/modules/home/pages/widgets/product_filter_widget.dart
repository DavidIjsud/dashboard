// ProductFilterWidget.dart
import 'package:flutter/material.dart';
import 'package:petshopdashboard/models/category.dart';

class ProductFilterWidget extends StatefulWidget {
  final List<Category> categories;
  final void Function({
    String? categoryId,
    int? stockMin,
    int? stockMax,
    double? priceMin,
    double? priceMax,
    bool? isSuspended,
  })
  onFilterChanged;

  const ProductFilterWidget({super.key, required this.categories, required this.onFilterChanged});

  @override
  State<ProductFilterWidget> createState() => _ProductFilterWidgetState();
}

class _ProductFilterWidgetState extends State<ProductFilterWidget> {
  String? selectedCategoryId;
  int? stockMin;
  int? stockMax;
  double? priceMin;
  double? priceMax;
  bool isSuspended = false;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        DropdownButton<String>(
          value: selectedCategoryId,
          hint: Text('Categoría'),
          items: widget.categories.map((cat) => DropdownMenuItem(value: cat.id, child: Text(cat.name ?? ''))).toList(),
          onChanged: (val) {
            setState(() => selectedCategoryId = val);
          },
        ),
        SizedBox(
          width: 120,
          child: TextField(
            decoration: InputDecoration(labelText: 'Stock >'),
            keyboardType: TextInputType.number,
            onChanged: (val) {
              stockMin = int.tryParse(val);
            },
          ),
        ),
        SizedBox(
          width: 120,
          child: TextField(
            decoration: InputDecoration(labelText: 'Stock <'),
            keyboardType: TextInputType.number,
            onChanged: (val) {
              stockMax = int.tryParse(val);
            },
          ),
        ),
        SizedBox(
          width: 120,
          child: TextField(
            decoration: InputDecoration(labelText: 'Precio >'),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            onChanged: (val) {
              priceMin = double.tryParse(val);
            },
          ),
        ),
        SizedBox(
          width: 120,
          child: TextField(
            decoration: InputDecoration(labelText: 'Precio <'),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            onChanged: (val) {
              priceMax = double.tryParse(val);
            },
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: isSuspended,
              onChanged: (val) {
                setState(() => isSuspended = val ?? false);
              },
            ),
            Text('Suspendido'),
          ],
        ),
        ElevatedButton(onPressed: _notifyChange, child: Text('Aplicar filtros')),
      ],
    );
  }

  void _notifyChange() {
    widget.onFilterChanged(
      categoryId: selectedCategoryId,
      stockMin: stockMin,
      stockMax: stockMax,
      priceMin: priceMin,
      priceMax: priceMax,
      isSuspended: isSuspended,
    );
    Navigator.of(context).pop(); // Close the dialog after applying filters
  }
}
