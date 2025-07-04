import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petshopdashboard/modules/home/viewmodels/home_viewmodel.dart';
import 'package:provider/provider.dart';

class CreateProductForm extends StatefulWidget {
  const CreateProductForm({super.key});

  @override
  State<CreateProductForm> createState() => _CreateProductFormState();
}

class _CreateProductFormState extends State<CreateProductForm> {
  final _formKey = GlobalKey<FormState>();
  String? _productName;
  String? _description;
  String? _categoryId;
  num? _price;
  int? _stock;
  XFile? _imageFile;

  @override
  Widget build(BuildContext context) {
    final homeViewmodel = context.read<HomeViewmodel>();
    final categories = homeViewmodel.state?.categories ?? [];

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Agregar producto', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            const SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(labelText: 'Nombre de producto'),
              validator: (v) => v == null || v.trim().isEmpty ? 'Campo obligatorio' : null,
              onSaved: (v) => _productName = v,
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(labelText: 'Precio'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))],
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Campo obligatorio';
                final value = num.tryParse(v);
                if (value == null || value <= 0) return 'Ingrese un precio válido';
                return null;
              },
              onSaved: (v) => _price = num.tryParse(v ?? ''),
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(labelText: 'Stock'),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Campo obligatorio';
                final value = int.tryParse(v);
                if (value == null || value < 0) return 'Ingrese un stock válido';
                return null;
              },
              onSaved: (v) => _stock = int.tryParse(v ?? ''),
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(labelText: 'Descripción del producto'),
              maxLines: 3,
              validator: (v) => v == null || v.trim().isEmpty ? 'Campo obligatorio' : null,
              onSaved: (v) => _description = v,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Categoria'),
              value: _categoryId,
              items:
                  categories
                      .map((cat) => DropdownMenuItem<String>(value: cat.id, child: Text(cat.name ?? '')))
                      .toList(),
              onChanged: (v) => setState(() => _categoryId = v),
              validator: (v) => v == null || v.isEmpty ? 'Campo obligatorio' : null,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                ElevatedButton.icon(
                  icon: Icon(Icons.image),
                  label: Text(_imageFile == null ? 'Seleccionar imagen' : 'Cambiar imagen'),
                  onPressed: () async {
                    final file = await homeViewmodel.pickImageToCreateProduct();
                    if (file != null) {
                      setState(() {
                        _imageFile = file;
                      });
                    }
                  },
                ),
                const SizedBox(width: 12),
                if (_imageFile != null)
                  Text(_imageFile!.name, style: TextStyle(fontSize: 12), overflow: TextOverflow.ellipsis),
              ],
            ),
            if (_imageFile == null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text('La imagen es obligatoria', style: TextStyle(color: Colors.red, fontSize: 12)),
              ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: Consumer<HomeViewmodel>(
                builder: (context, vm, _) {
                  final isLoading = vm.state?.productsState.isCreatingNewProduct ?? false;
                  return ElevatedButton(
                    onPressed:
                        isLoading
                            ? null
                            : () async {
                              if (!_formKey.currentState!.validate() || _imageFile == null) return;
                              _formKey.currentState!.save();
                              await vm.createProduct(
                                productName: _productName!,
                                price: _price!,
                                totalInStock: _stock!,
                                detailOfProduct: _description!,
                                categoryId: _categoryId!,
                                image: _imageFile!,
                              );
                              if (mounted) {
                                Navigator.of(context).pop();
                              }
                            },
                    child:
                        isLoading
                            ? SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
                            : Text('Crear producto'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
