enum OrderStatus {
  pending,
  shipped,
  delivered,
  canceled;

  static String orderStatusText(OrderStatus orderStatus) {
    switch (orderStatus) {
      case OrderStatus.pending:
        return 'Pendiente';
      case OrderStatus.delivered:
        return 'Entregado';
      case OrderStatus.canceled:
        return 'Cancelado';
      case OrderStatus.shipped:
        return 'Enviado';
    }
  }

  static OrderStatus fromString(String status) {
    switch (status) {
      case 'pending':
        return OrderStatus.pending;
      case 'delivered':
        return OrderStatus.delivered;
      case 'cancelled':
        return OrderStatus.canceled;
      case 'shipped':
        return OrderStatus.shipped;
      default:
        throw Exception('Invalid status');
    }
  }
}

enum PaymentMethod {
  cash,
  card,
  qr;

  static String paymentMethodText(PaymentMethod paymentMethod) {
    switch (paymentMethod) {
      case PaymentMethod.cash:
        return 'Efectivo';
      case PaymentMethod.card:
        return 'Tarjeta';
      case PaymentMethod.qr:
        return 'QR';
    }
  }

  static PaymentMethod fromString(String method) {
    switch (method) {
      case 'cash':
        return PaymentMethod.cash;
      case 'card':
        return PaymentMethod.card;
      case 'qr':
        return PaymentMethod.qr;
      default:
        throw Exception('Invalid method');
    }
  }
}

enum PaymentStatus {
  pending,
  paid,
  failed,
  refunded;

  static String paymentStatusText(PaymentStatus paymentStatus) {
    switch (paymentStatus) {
      case PaymentStatus.pending:
        return 'Pendiente';
      case PaymentStatus.paid:
        return 'Pagado';
      case PaymentStatus.failed:
        return 'Fallido';
      case PaymentStatus.refunded:
        return 'Reembolsado';
    }
  }

  static PaymentStatus fromString(String status) {
    switch (status) {
      case 'pending':
        return PaymentStatus.pending;
      case 'paid':
        return PaymentStatus.paid;
      case 'failed':
        return PaymentStatus.failed;
      case 'refunded':
        return PaymentStatus.refunded;
      default:
        throw Exception('Invalid status');
    }
  }
}
