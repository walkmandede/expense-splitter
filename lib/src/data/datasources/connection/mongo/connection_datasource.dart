import 'package:dartz/dartz.dart';
import 'package:expense_splitter/core/mongo_db/mongo_db_collections.dart';
import 'package:expense_splitter/core/mongo_db/mongo_db_service.dart';
import 'package:expense_splitter/src/data/models/auth/user_model.dart';
import 'package:expense_splitter/src/data/models/connection/connection_model.dart';
import 'package:mongo_dart/mongo_dart.dart';

abstract class ConnectionDatasource {
  Future<Either<String, UserModel>> getUserInfo({required String email});
  Future<Either<String, List<ConnectionModel>>> getMyConnections();
}

class ConnectionDataSourceImpl extends ConnectionDatasource {
  final MongoDbService mongoDbService;
  ConnectionDataSourceImpl({required this.mongoDbService});

  @override
  Future<Either<String, List<ConnectionModel>>> getMyConnections() {
    // TODO: implement getMyConnections
    throw UnimplementedError();
  }

  @override
  Future<Either<String, UserModel>> getUserInfo({required String email}) async {
    final db = mongoDbService.db;
    final result = await db
        .collection(MongoDbCollections.user)
        .findOne(where.eq("email", email));
    if (result == null) {
      return Left("There is no such email in the system");
    } else {
      return Right(UserModel.fromMongoJson(json: result));
    }
  }
}
