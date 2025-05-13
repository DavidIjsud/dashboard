import 'package:petshopdashboard/models/network_request.dart';

class UserRequest extends NetworkRequest {
  UserRequest({required this.urlUsers}) : super(url: urlUsers);
  final String urlUsers;
}
