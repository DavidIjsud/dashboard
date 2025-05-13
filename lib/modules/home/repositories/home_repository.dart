import 'package:dartz/dartz.dart';
import 'package:petshopdashboard/models/category.dart';
import 'package:petshopdashboard/models/order.model.dart';
import 'package:petshopdashboard/models/product.model.dart' show ProductModel;
import 'package:petshopdashboard/models/user.model.dart';

abstract class HomeRepository {
  Future<Either<Fail, List<UserModel>>> getUsers();
  Future<Either<Fail, List<OrderModel>>> getOrders();
  Future<Either<Fail, List<ProductModel>>> getProducts();
  Future<Either<Fail, List<Category>>> getCategories();
}
