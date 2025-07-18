import 'package:flutter/material.dart';
import 'package:petshopdashboard/models/order.model.dart';
import 'package:petshopdashboard/modules/home/viewmodels/home_viewmodel.dart';
import 'package:provider/provider.dart';

class OrderDetailWidget extends StatefulWidget {
  final OrderModel order;
  final VoidCallback? onUpdateStatus;
  final VoidCallback? onUpdatePaymentStatus;

  const OrderDetailWidget({super.key, required this.order, this.onUpdateStatus, this.onUpdatePaymentStatus});

  @override
  State<OrderDetailWidget> createState() => _OrderDetailWidgetState();
}

class _OrderDetailWidgetState extends State<OrderDetailWidget> {
  late String _selectedStatus;
  late String _selectedPaymentStatus;

  static const Map<String, String> statusMap = {
    'pending': 'Pendiente',
    'shipped': 'En camino',
    'delivered': 'Entregado',
    'cancelled': 'Cancelado',
  };

  static const Map<String, String> paymentStatusMap = {
    'pending': 'Pendiente',
    'paid': 'Pagado',
    'failed': 'Fallido',
    'refunded': 'Reembolsado',
  };

  @override
  void initState() {
    super.initState();
    _selectedStatus = _statusToDb(widget.order.status);
    _selectedPaymentStatus = _paymentStatusToDb(widget.order.paymentStatus);
  }

  String _statusToDb(dynamic status) {
    final value = status.toString().split('.').last;
    if (statusMap.containsKey(value)) return value;
    switch (value) {
      case 'pending':
      case 'shipped':
      case 'delivered':
      case 'cancelled':
        return value;
      default:
        return 'pending';
    }
  }

  String _paymentStatusToDb(dynamic status) {
    final value = status.toString().split('.').last;
    if (paymentStatusMap.containsKey(value)) return value;
    switch (value) {
      case 'pending':
      case 'paid':
      case 'failed':
      case 'refunded':
        return value;
      default:
        return 'pending';
    }
  }

  void _updateOrderStatus() {
    final homeViewmodel = context.read<HomeViewmodel>();
    homeViewmodel.updateOrderStatus(widget.order.id, _selectedStatus);
    if (widget.onUpdateStatus != null) {
      widget.onUpdateStatus!();
    }
  }

  void _updateOrderPaymentStatus() {
    final homeViewmodel = context.read<HomeViewmodel>();
    homeViewmodel.updateOrderPaymentStatus(widget.order.id, _selectedPaymentStatus);
    if (widget.onUpdatePaymentStatus != null) {
      widget.onUpdatePaymentStatus!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Order ID: ${widget.order.id}'),
          Text('Date Ordered: ${widget.order.dateOrderCreated}'), // <-- Add this line
          Row(
            children: [
              Text('Status: '),
              DropdownButton<String>(
                value: _selectedStatus,
                items:
                    statusMap.entries
                        .map((entry) => DropdownMenuItem<String>(value: entry.key, child: Text(entry.value)))
                        .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedStatus = value;
                    });
                  }
                },
              ),
              const SizedBox(width: 8),
              Consumer<HomeViewmodel>(
                builder: (context, homeViewmodel, _) {
                  final isUpdating = homeViewmodel.state?.ordersState.isUpdatingOrderStatus ?? false;
                  return ElevatedButton(
                    onPressed: isUpdating ? null : _updateOrderStatus,
                    child:
                        isUpdating
                            ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                            : const Text('Actualizar'),
                  );
                },
              ),
            ],
          ),
          Text('Tax Amount: ${widget.order.taxAmount}'),
          Text('Shipping Cost: ${widget.order.shippingCost}'),
          Row(
            children: [
              Text('Payment Status: '),
              DropdownButton<String>(
                value: _selectedPaymentStatus,
                items:
                    paymentStatusMap.entries
                        .map((entry) => DropdownMenuItem<String>(value: entry.key, child: Text(entry.value)))
                        .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedPaymentStatus = value;
                    });
                  }
                },
              ),
              const SizedBox(width: 8),
              Consumer<HomeViewmodel>(
                builder: (context, homeViewmodel, _) {
                  final isUpdating = homeViewmodel.state?.ordersState.isUpdatingOrderStatus ?? false;
                  return ElevatedButton(
                    onPressed: isUpdating ? null : _updateOrderPaymentStatus,
                    child:
                        isUpdating
                            ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                            : const Text('Actualizar'),
                  );
                },
              ),
            ],
          ),
          Text('Payment Method: ${widget.order.getPaymentMethodText()}'),
          Text('Total Payment: ${widget.order.totalPayment}'),
          const SizedBox(height: 16),
          Text('User:', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('  ID: ${widget.order.user.id}'),
          Text('  Name: ${widget.order.user.name}'),
          Text('  Email: ${widget.order.user.email}'),
          const SizedBox(height: 16),
          if (widget.order.address != null) ...[
            Text('Address:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('  Street: ${widget.order.address!.street}'),
            Text('  Deparment: ${widget.order.address!.deparment}'),
            Text('  Country: ${widget.order.address!.country}'),
            const SizedBox(height: 16),
          ],
          Text('Products:', style: TextStyle(fontWeight: FontWeight.bold)),
          ...widget.order.products.map(
            (product) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('  Product Name: ${product.productName}'),
                  Text('  Product ID: ${product.productId}'),
                  Text('  Quantity: ${product.quantity}'),
                  Text('  Total Payment: ${product.totalPayment}'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
