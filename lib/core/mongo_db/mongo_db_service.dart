import 'package:expense_splitter/common/helpers/log_helpers.dart';
import 'package:expense_splitter/core/env_helper/env_keys.dart';
import 'package:expense_splitter/core/handlers/error-handler/error_handler.dart';
import 'package:expense_splitter/core/mongo_db/mongo_db_collections.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDbService {
  late Db db;

  MongoDbService();

  Future<bool> openDb() async {
    bool isSuccess = false;
    try {
      final _dbString = dotenv.env[EnvKeys.mongoDbStringDevelopment] ?? "";
      LogHelper.info(message: "DB init success : $_dbString");

      db = await Db.create(_dbString);
      final dbOpenResult = await db.open();
      LogHelper.info(message: "DB init success : $dbOpenResult");
    } catch (e, sT) {
      handleError(e, sT);
    }
    return isSuccess;
  }
}
