import 'package:flutter/material.dart';
import 'package:petshopdashboard/modules/home/pages/widgets/order_item.dart';
import 'package:petshopdashboard/modules/home/pages/widgets/order_detail.dart';
import 'package:petshopdashboard/modules/home/viewmodels/home_viewmodel.dart';
import 'package:provider/provider.dart';

class OrdersWidget extends StatelessWidget {
  const OrdersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeViewmodel homeViewmodel = context.read<HomeViewmodel>();
    homeViewmodel.getAllOrders();
    print('OrdersWidget build');
    return Consumer<HomeViewmodel>(
      builder: (_, homeViewModel, Widget? w) {
        final ordersState = homeViewModel.state?.ordersState;
        return ordersState?.isLoadingOrders == true
            ? Center(child: CircularProgressIndicator())
            : ordersState?.ocurredErrorOnGetOrders == true
            ? Center(child: Text('Ocurrio un error al obtener las ordenes'))
            : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Orders List
                  Expanded(
                    flex: 3,
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
                          onSubmitted: (value) => homeViewModel.getAllOrders(searchTermName: value),
                          decoration: InputDecoration(
                            hintText: 'Buscar ordenes por nombre',
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
                        const SizedBox(height: 8),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () async {
                              final picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2020),
                                lastDate: DateTime.now(),
                              );
                              if (picked != null) {
                                homeViewModel.getAllOrders(dateOrdersCreated: picked);
                              }
                            },
                            child: Row(
                              children: [
                                Icon(Icons.filter_alt_outlined, color: Colors.blue),
                                const SizedBox(width: 6),
                                Text(
                                  'Filtrar por fecha',
                                  style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: GridView.builder(
                            itemCount: ordersState?.orders.length ?? 0,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:
                                  ordersState?.showOrderDetail == true ? 4 : 5, // fewer columns for more width per item
                              crossAxisSpacing: 12, // more spacing
                              mainAxisSpacing: 12, // more spacing
                              childAspectRatio: 0.9, // wider cards
                            ),
                            itemBuilder: (_, index) {
                              final order = ordersState?.orders[index];
                              return InkWell(
                                onTap: () {
                                  if (order != null) {
                                    homeViewModel.showOrderDetail(order);
                                  }
                                },
                                child: OrderItemCard(
                                  orderId: order?.id ?? '',
                                  status: order?.getOrderStatusText() ?? 'Pendiente',
                                  totalAmount: order?.totalPayment ?? 0,
                                  shippingCost: order?.shippingCost ?? 0,
                                  paymentStatus: order?.getPaymentStatusText() ?? 'Pendiente',
                                  paymentMethod: order?.getPaymentMethodText() ?? 'Efectivo',
                                  userName: order?.user.name ?? 'Desconocido',
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Order Detail Panel
                  if (ordersState?.showOrderDetail == true && ordersState?.orderDetail != null)
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: const EdgeInsets.only(left: 16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 8, offset: Offset(2, 2)),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text('Detalle de Orden', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                                Spacer(),
                                IconButton(
                                  icon: Icon(Icons.close),
                                  onPressed: () {
                                    homeViewModel.hideOrderDetail();
                                  },
                                ),
                              ],
                            ),
                            const Divider(),
                            Expanded(child: OrderDetailWidget(order: ordersState!.orderDetail!)),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            );
      },
    );
  }
}
