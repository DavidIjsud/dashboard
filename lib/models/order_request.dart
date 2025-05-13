import 'package:petshopdashboard/models/network_request.dart';

class OrderRequest extends NetworkRequest {
  OrderRequest({required this.urlOrdrs}) : super(url: urlOrdrs);
  final String urlOrdrs;
}
