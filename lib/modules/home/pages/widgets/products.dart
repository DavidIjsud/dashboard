import 'package:flutter/material.dart';
import 'package:petshopdashboard/models/category.dart';
import 'package:petshopdashboard/modules/home/pages/widgets/create_product.dart';
import 'package:petshopdashboard/modules/home/pages/widgets/product_detail.dart';
import 'package:petshopdashboard/modules/home/pages/widgets/product_filter_widget.dart';
import 'package:petshopdashboard/modules/home/pages/widgets/product_item.dart';
import 'package:petshopdashboard/modules/home/viewmodels/home_viewmodel.dart';
import 'package:provider/provider.dart';

class ProductsWidget extends StatelessWidget {
  const ProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final homeViewmodel = context.read<HomeViewmodel>();
    homeViewmodel.getAllProducts();
    final TextEditingController searchController = TextEditingController(); // Add controller

    return LayoutBuilder(
      builder: (_, constraints) {
        return Row(
          children: [
            Flexible(
              flex: 4,
              child: Consumer<HomeViewmodel>(
                builder: (_, homeViewModel, Widget? w) {
                  return homeViewmodel.state?.productsState.isLoadingProducts == true
                      ? Center(child: CircularProgressIndicator())
                      : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Productos',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32.0),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: searchController, // Attach controller
                                    onSubmitted: (value) {
                                      if (value.isNotEmpty) {
                                        homeViewmodel.getAllProducts(searchTerm: value);
                                      }
                                    },
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText: 'Buscar productos.',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(color: Colors.grey),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(color: Colors.blue, width: 2),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(color: Colors.grey, width: 1),
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(Icons.search, color: Colors.grey),
                                        onPressed: () {
                                          if (searchController.value.text.isNotEmpty) {
                                            homeViewmodel.getAllProducts(searchTerm: searchController.text);
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                IconButton(
                                  icon: Icon(Icons.filter_list, color: Colors.blue),
                                  tooltip: 'Filtrar productos',
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder:
                                          (context) => AlertDialog(
                                            title: Text('Filtrar productos'),
                                            content: SizedBox(
                                              width: 400, // Adjust as needed
                                              child: ProductFilterWidget(
                                                categories: homeViewmodel.state?.categories ?? [],
                                                onFilterChanged: ({
                                                  String? categoryId,
                                                  bool? isSuspended,
                                                  double? priceMax,
                                                  double? priceMin,
                                                  int? stockMax,
                                                  int? stockMin,
                                                }) {
                                                  homeViewmodel.getAllProducts(
                                                    selectedCategoryId: categoryId,
                                                    stockMin: stockMin,
                                                    stockMax: stockMax,
                                                    priceMin: priceMin,
                                                    priceMax: priceMax,
                                                    isSuspended: isSuspended,
                                                  );
                                                },
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.of(context).pop(),
                                                child: Text('Cerrar'),
                                              ),
                                            ],
                                          ),
                                    );
                                  },
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(content: CreateProductForm()),
                                    );
                                  },
                                  child: Text('Agregar producto'),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),

                            Expanded(
                              child: GridView.builder(
                                itemCount: homeViewModel.state?.productsState.products.length ?? 0,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: homeViewModel.state?.productsState.showProductDetail == true ? 4 : 5,
                                  crossAxisSpacing: 3,
                                  mainAxisSpacing: 3,
                                  childAspectRatio: constraints.maxWidth / (constraints.maxHeight * 2.4),
                                ),
                                itemBuilder: (_, index) {
                                  final product = homeViewModel.state?.productsState.products[index];
                                  return GestureDetector(
                                    onTap: () {
                                      homeViewmodel.showProductDetail(product);
                                    },
                                    child: ProductCard(
                                      name: product?.name ?? '',
                                      price: product?.price ?? 0.0,
                                      imageUrl: product?.image ?? '',
                                      description: product?.description ?? '',
                                      totalInStock: product?.totalInStock ?? 0,
                                      isSuspended: product?.isSuspended ?? false,
                                      productID: product?.id ?? '',
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                },
              ),
            ),
            Consumer<HomeViewmodel>(
              builder: (_, homeViewModel, widget) {
                print(
                  'showProductDetail: ${homeViewModel.state?.productsState.productDetail?.categoryName} and ${homeViewModel.state?.productsState.productDetail?.categoryId}',
                );
                return homeViewmodel.state?.productsState.showProductDetail == true
                    ? Flexible(
                      flex: 1,
                      child: ProductEditor(
                        productID: homeViewModel.state?.productsState.productDetail?.id ?? '',
                        imageUrl: homeViewModel.state?.productsState.productDetail?.image ?? '',
                        name: homeViewModel.state?.productsState.productDetail?.name ?? '',
                        price: homeViewModel.state?.productsState.productDetail?.price ?? 0.0,
                        description: homeViewModel.state?.productsState.productDetail?.description ?? '',
                        stock: homeViewModel.state?.productsState.productDetail?.totalInStock ?? 0,
                        categoryID: homeViewModel.state?.productsState.productDetail?.categoryId ?? '',
                      ),
                    )
                    : const SizedBox();
              },
            ),
          ],
        );
      },
    );
  }
}
