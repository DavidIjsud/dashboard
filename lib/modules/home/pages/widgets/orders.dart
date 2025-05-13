import 'package:flutter/material.dart';
import 'package:petshopdashboard/modules/home/pages/widgets/order_item.dart';
import 'package:petshopdashboard/modules/home/viewmodels/home_viewmodel.dart';
import 'package:provider/provider.dart';

class OrdersWidget extends StatelessWidget {
  const OrdersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeViewmodel homeViewmodel = context.read<HomeViewmodel>();
    homeViewmodel.getAllOrders();
    return Consumer<HomeViewmodel>(
      builder: (_, homeViewModel, Widget? w) {
        return homeViewmodel.state?.ordersState.isLoadingOrders == true
            ? Center(child: CircularProgressIndicator())
            : homeViewmodel.state?.ordersState.ocurredErrorOnGetOrders == true
            ? Center(child: Text('Ocurrio un error al obtener las ordenes'))
            : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Ordenes',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32.0),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Buscar ordenes.',
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
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 16),

                  Expanded(
                    child: GridView.builder(
                      itemCount: homeViewModel.state?.ordersState.orders.length ?? 0,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        crossAxisSpacing: 3,
                        mainAxisSpacing: 3,
                        childAspectRatio: 0.9,
                      ),
                      itemBuilder: (_, index) {
                        final order = homeViewModel.state?.ordersState.orders[index];
                        return OrderItemCard(
                          status: order?.getOrderStatusText() ?? 'Pendiente',
                          totalAmount: order?.totalAmount ?? 0,
                          discount: order?.discountAmount ?? 0,
                          shippingCost: order?.shippingCost ?? 0,
                          paymentStatus: order?.getPaymentStatusText() ?? 'Pendiente',
                          paymentMethod: order?.getPaymentMethodText() ?? 'Efectivo',
                          userName: order?.userName ?? 'Desconocido',
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
      },
    );
  }
}
