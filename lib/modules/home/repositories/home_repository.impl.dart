import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:petshopdashboard/core/endpoints.dart';
import 'package:petshopdashboard/models/category.dart';
import 'package:petshopdashboard/models/category_request.dart';
import 'package:petshopdashboard/models/order.model.dart';
import 'package:petshopdashboard/models/order_request.dart';
import 'package:petshopdashboard/models/product.model.dart';
import 'package:petshopdashboard/models/user.model.dart';
import 'package:petshopdashboard/models/users_request.dart';
import 'package:petshopdashboard/modules/home/repositories/home_repository.dart';
import 'package:petshopdashboard/services/network/network_client.dart';

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl({required Endpoints endpoints, required NetworkClient networkClient})
    : _endpoints = endpoints,
      _networkClient = networkClient;

  final Endpoints _endpoints;
  final NetworkClient _networkClient;

  @override
  Future<Either<Fail, List<UserModel>>> getUsers() async {
    final userRequest = UserRequest(urlUsers: _endpoints.getUsersEndPoint);
    try {
      final response = await _networkClient.get(
        Uri.parse(userRequest.url),
        headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
      );
      if (response.statusCode == 200) {
        return Right((jsonDecode(response.body) as List).map((e) => UserModel.fromJson(e)).toList());
      }

      return Right([]);
    } catch (e) {
      return Left(Fail(e.toString()));
    }
  }

  @override
  Future<Either<Fail, List<OrderModel>>> getOrders() async {
    final userRequest = OrderRequest(urlOrdrs: _endpoints.getOrdersEndPoint);
    try {
      final response = await _networkClient.get(
        Uri.parse(userRequest.url),
        headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        return Right((jsonDecode(response.body) as List).map((e) => OrderModel.fromJson(e)).toList());
      }

      return Right([]);
    } catch (e) {
      return Left(Fail(e.toString()));
    }
  }

  @override
  Future<Either<Fail, List<ProductModel>>> getProducts() async {
    final userRequest = OrderRequest(urlOrdrs: _endpoints.getProductsEndPoint);
    try {
      final response = await _networkClient.get(
        Uri.parse(userRequest.url),
        headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        return Right((jsonDecode(response.body) as List).map((e) => ProductModel.fromJson(e)).toList());
      }

      return Right([]);
    } catch (e) {
      return Left(Fail(e.toString()));
    }
  }

  @override
  Future<Either<Fail, List<Category>>> getCategories() async {
    final categoryRequest = CategoryRequest(urlCategories: _endpoints.getCategoriesEndPoint);
    try {
      final response = await _networkClient.get(
        Uri.parse(categoryRequest.url),
        headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        return Right((jsonDecode(response.body) as List).map((e) => Category.fromJson(e)).toList());
      }

      return Right([]);
    } catch (e) {
      return Left(Fail(e.toString()));
    }
  }
}
