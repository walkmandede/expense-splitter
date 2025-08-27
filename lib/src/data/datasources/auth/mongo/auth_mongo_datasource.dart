import 'package:dartz/dartz.dart';
import 'package:expense_splitter/core/mongo_db/mongo_db_collections.dart';
import 'package:expense_splitter/core/mongo_db/mongo_db_service.dart';
import 'package:expense_splitter/src/data/models/auth/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mongo_dart/mongo_dart.dart';

abstract class AuthMongoDataSource {
  Future<Either<String, UserModel>> googleSignIn({
    required UserModel userModel,
  });
  Future<Either<String, Unit>> singOut();
  Future<Either<String, UserModel>> getCurrentUserInfo();
}

class AuthMongoDataSourceImpl extends AuthMongoDataSource {
  final MongoDbService mongoDbService;
  AuthMongoDataSourceImpl({required this.mongoDbService});

  @override
  Future<Either<String, UserModel>> googleSignIn({
    required UserModel userModel,
  }) async {
    final mongoDb = mongoDbService.db;
    final userCollection = mongoDb.collection(MongoDbCollections.user);

    final mongoJson = await userCollection.findOne(
      where.eq("email", userModel.email),
    );
    if (mongoJson == null) {
      //new user
      final writeResult = await userCollection.insertOne(
        userModel.toMongoJson(),
      );
      if (writeResult.isSuccess) {
        //parsing return newUser mongo json into user model
        try {
          final newUserModel = UserModel.fromMongoJson(
            json: writeResult.document!,
          );
          return Right(newUserModel);
        } catch (e) {
          rethrow;
        }
      } else {
        return Left(writeResult.errmsg ?? "Something went wrong in loggin in");
      }
    } else {
      //existing user
      final existingUserModel = UserModel.fromMongoJson(json: mongoJson);
      return Right(existingUserModel);
    }
  }

  @override
  Future<Either<String, UserModel>> getCurrentUserInfo() async {
    final mongoDb = mongoDbService.db;
    final userCollection = mongoDb.collection(MongoDbCollections.user);
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser == null) {
      return Left("There is no firebase user");
    }
    final mongoJson = await userCollection.findOne(
      where.eq("firebaseUid", firebaseUser.uid),
    );

    if (mongoJson != null) {
      final existingUserModel = UserModel.fromMongoJson(json: mongoJson!);
      return Right(existingUserModel);
    } else {
      return Left("Something went wrong fetching user info");
    }
  }

  @override
  Future<Either<String, Unit>> singOut() async {
    return Right(unit);
  }
}
