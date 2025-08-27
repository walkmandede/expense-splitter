import 'package:dartz/dartz.dart';
import 'package:expense_splitter/src/domain/entities/auth/user_entity.dart';
import 'package:expense_splitter/src/domain/entities/connection/connection_entity.dart';

abstract class ConnectionRepo {
  Future<Either<String, UserEntity>> getUserDetail({required String email});
  Future<Either<String, Unit>> sendRequest({required String id});
  Future<Either<String, List<ConnectionEntity>>> getMyConnections();
}
