import 'package:dartz/dartz.dart';

abstract class LoginRepository {
  Future<Either<Fail, bool>> login(String email, String password);
}
