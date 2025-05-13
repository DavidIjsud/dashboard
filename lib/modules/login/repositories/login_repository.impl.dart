import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:petshopdashboard/core/endpoints.dart';
import 'package:petshopdashboard/models/login_request.dart';
import 'package:petshopdashboard/services/network/network_client.dart';
import 'login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  LoginRepositoryImpl({
    required NetworkClient networkClient,
    required Endpoints endpoints,
  }) : _networkClient = networkClient,
       _endpoints = endpoints;

  final NetworkClient _networkClient;
  final Endpoints _endpoints;

  @override
  Future<Either<Fail, bool>> login(String email, String password) async {
    final request = LoginRequest(
      url: _endpoints.getUsersEndPoint,
      email: email,
      password: password,
    );

    try {
      final response = await _networkClient.post(
        Uri.parse(_endpoints.getUsersEndPoint),
        body: request.body,
        headers: request.headers,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(true);
      }

      return Left(Fail(response.body));
    } catch (e) {
      return Left(Fail(e.toString()));
    }
  }
}
