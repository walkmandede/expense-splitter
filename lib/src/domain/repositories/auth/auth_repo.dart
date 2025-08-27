import 'package:dartz/dartz.dart';
import 'package:expense_splitter/src/domain/entities/auth/user_entity.dart';

abstract class AuthRepo {
  Future<Either<String, UserEntity>> signInWithGoogle();
  Future<Either<String, Unit>> signOut();
  Future<Either<String, UserEntity>> getUserInfo();
}
