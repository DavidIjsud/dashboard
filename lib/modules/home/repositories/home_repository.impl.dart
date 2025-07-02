import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';

import 'dart:typed_data';
import 'package:http/http.dart' as http;

import 'package:dartz/dartz.dart';
import 'package:http_parser/http_parser.dart' as http_parser;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petshopdashboard/core/endpoints.dart';
import 'package:petshopdashboard/models/category.dart';
import 'package:petshopdashboard/models/category_request.dart';
import 'package:petshopdashboard/models/order.model.dart';
import 'package:petshopdashboard/models/order_detail.model.dart';
import 'package:petshopdashboard/models/order_detail_request.dart';
import 'package:petshopdashboard/models/order_request.dart';
import 'package:petshopdashboard/models/product.model.dart';
import 'package:petshopdashboard/models/product_request.dart';
import 'package:petshopdashboard/models/suspend_product_request.dart';
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
  Future<Either<Fail, List<OrderModel>>> getOrders({String? searchTermName}) async {
    final userRequest = OrderRequest(urlOrdrs: _endpoints.getOrdersEndPoint, searchTermName: searchTermName);
    try {
      final response = await _networkClient.post(
        Uri.parse(userRequest.url),
        headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
        body: userRequest.body,
      );

      if (response.statusCode == 200) {
        return Right((jsonDecode(response.body) as List).map((e) => OrderModel.fromJson(e)).toList());
      }

      return Right([]);
    } catch (e) {
      print('Error fetching orders: $e');
      return Left(Fail(e.toString()));
    }
  }

  @override
  Future<Either<Fail, List<ProductModel>>> getProducts({
    String? searchTerm,
    String? selectedCategoryId,
    int? stockMin,
    int? stockMax,
    double? priceMin,
    double? priceMax,
    bool? isSuspended,
  }) async {
    final productsRequest = ProductRequest(
      urlProducts: _endpoints.getProductsEndPoint,
      searchTerm: searchTerm,
      selectedCategoryId: selectedCategoryId,
      stockMin: stockMin,
      stockMax: stockMax,
      priceMin: priceMin,
      priceMax: priceMax,
      isSuspended: isSuspended,
    );
    try {
      print('body of request: ${productsRequest.body}');
      final response = await _networkClient.post(
        Uri.parse(productsRequest.url),
        headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
        body: productsRequest.body,
      );

      if (response.statusCode == 200) {
        return Right((jsonDecode(response.body) as List).map((e) => ProductModel.fromJson(e)).toList());
      }
      print('Error fetching products: ${response.statusCode} - ${response.body}');
      return Right([]);
    } catch (e) {
      print('Error fetching products: $e');
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

  @override
  Future<Either<Fail, bool>> updateProduct({
    required String id,
    required String name,
    required num price,
    required int totalInStock,
    required String detailOfProduct,
    required String categoryId,
    required XFile? imageFile, // coming from image_picker
  }) async {
    try {
      final request = http.MultipartRequest('PATCH', Uri.parse('http://localhost:3000/product/update/$id'));

      request.fields.addAll({
        'productName': name,
        'price': price.toString(),
        'totalInStock': totalInStock.toString(),
        'detailOfProduct': detailOfProduct,
        'category': categoryId,
      });

      if (imageFile != null) {
        final bytes = await imageFile.readAsBytes(); // this is the key step
        print('mimeType: ${imageFile.mimeType}');
        final mimeType = imageFile.mimeType ?? 'image/jpeg';
        final multipartFile = http.MultipartFile.fromBytes(
          'image',
          bytes,
          filename: imageFile.name,
          contentType: MediaType.parse(mimeType),
        );

        request.files.add(multipartFile);
      }

      final response = await request.send();

      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        print(await response.stream.bytesToString());
        return const Right(false);
      }
    } catch (e) {
      return Left(Fail(e.toString()));
    }
  }

  @override
  Future<Either<Fail, bool>> suspendProduct(String id, bool suspendProduct) async {
    final suspendProductRequest = SuspendProductRequest(
      url: _endpoints.suspendProductEndPoint,
      productId: id,
      suspendProduct: suspendProduct,
    );
    try {
      final response = await _networkClient.patch(
        Uri.parse(suspendProductRequest.url),
        headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
        body: suspendProductRequest.body,
      );

      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return const Right(false);
      }
    } catch (e) {
      return Left<Fail, bool>(Fail(e.toString()));
    }
  }

  @override
  Future<Either<Fail, List<OrderDetail>>> getOrderDetails(String orderId) async {
    final orderDetailRequest = OrderDetailRequest(
      urlOrderDetails: _endpoints.getOrderDetailsEndPoint,
      orderId: orderId,
    );
    try {
      final respose = await _networkClient.get(
        Uri.parse(orderDetailRequest.url),
        headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
      );
      if (respose.statusCode == 200) {
        final List<dynamic> jsonResponse = jsonDecode(respose.body);
        return Right(jsonResponse.map((e) => OrderDetail.fromJson(e)).toList());
      } else {
        return Right([]);
      }
    } catch (e) {
      return Future.value(Left(Fail(e.toString())));
    }
  }
}
