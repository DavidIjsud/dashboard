import 'package:petshopdashboard/models/network_request.dart';

class ProductRequest extends NetworkRequest {
  ProductRequest({required this.urlProducts}) : super(url: urlProducts);
  final String urlProducts;
}
