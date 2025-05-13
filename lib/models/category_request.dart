import 'package:petshopdashboard/models/network_request.dart';

class CategoryRequest extends NetworkRequest {
  CategoryRequest({required this.urlCategories}) : super(url: urlCategories);
  final String urlCategories;
}
