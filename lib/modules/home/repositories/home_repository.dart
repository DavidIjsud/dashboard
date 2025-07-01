import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petshopdashboard/models/category.dart';
import 'package:petshopdashboard/models/order.model.dart';
import 'package:petshopdashboard/models/order_detail.model.dart';
import 'package:petshopdashboard/models/product.model.dart' show ProductModel;
import 'package:petshopdashboard/models/user.model.dart';

abstract class HomeRepository {
  Future<Either<Fail, List<OrderDetail>>> getOrderDetails(String orderId);
  Future<Either<Fail, List<UserModel>>> getUsers();
  Future<Either<Fail, List<OrderModel>>> getOrders();
  Future<Either<Fail, List<ProductModel>>> getProducts({
    String? searchTerm,
    String? selectedCategoryId,
    int? stockMin,
    int? stockMax,
    double? priceMin,
    double? priceMax,
    bool? isSuspended,
  });
  Future<Either<Fail, List<Category>>> getCategories();
  Future<Either<Fail, bool>> updateProduct({
    required String id,
    required String name,
    required num price,
    required int totalInStock,
    required String detailOfProduct,
    required String categoryId,
    required XFile? imageFile, // coming from image_picker
  });
  Future<Either<Fail, bool>> suspendProduct(String id, bool suspendProduct);
}
