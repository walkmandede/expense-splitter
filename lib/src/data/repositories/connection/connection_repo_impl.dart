import 'package:dartz/dartz.dart';
import 'package:expense_splitter/src/data/datasources/connection/mongo/connection_datasource.dart';
import 'package:expense_splitter/src/data/models/auth/user_model.dart';
import 'package:expense_splitter/src/domain/entities/connection/connection_entity.dart';
import 'package:expense_splitter/src/domain/repositories/connection/connection_repo.dart';

class ConnectionRepoImpl extends ConnectionRepo {
  final ConnectionDatasource connectionDatasource;
  ConnectionRepoImpl({required this.connectionDatasource});

  @override
  Future<Either<String, UserModel>> getUserDetail({
    required String email,
  }) async {
    return connectionDatasource.getUserInfo(email: email);
  }

  @override
  Future<Either<String, Unit>> sendRequest({required String id}) {
    // TODO: implement sendRequest
    throw UnimplementedError();
  }

  @override
  Future<Either<String, List<ConnectionEntity>>> getMyConnections() {
    // TODO: implement getMyConnections
    throw UnimplementedError();
  }
}
