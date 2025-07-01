import 'package:petshopdashboard/models/network_request.dart';

class OrderDetailRequest extends NetworkRequest {
  OrderDetailRequest({required this.urlOrderDetails, required this.orderId})
    : super(url: urlOrderDetails.replaceAll('{orderId}', orderId));

  final String urlOrderDetails;
  final String orderId;
}
