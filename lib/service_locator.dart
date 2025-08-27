import 'package:expense_splitter/core/mongo_db/mongo_db_service.dart';
import 'package:expense_splitter/core/overlay/dialog_service.dart';
import 'package:expense_splitter/src/data/datasources/auth/mongo/auth_mongo_datasource.dart';
import 'package:expense_splitter/src/data/datasources/connection/mongo/connection_datasource.dart';
import 'package:expense_splitter/src/data/repositories/auth/auth_repo_impl.dart';
import 'package:expense_splitter/src/data/repositories/connection/connection_repo_impl.dart';
import 'package:expense_splitter/src/domain/usecases/auth/get_my_user_info_usecase.dart';
import 'package:expense_splitter/src/domain/usecases/auth/google_sign_usecase.dart';
import 'package:expense_splitter/src/domain/usecases/auth/sign_out_usecase.dart';
import 'package:expense_splitter/src/domain/usecases/connection/get_user_detail_use_case.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  //----------
  // services
  //----------
  // mongoDb
  sl.registerSingleton<MongoDbService>(MongoDbService());
  // dialog
  sl.registerSingleton<DialogService>(DialogService());

  //----------
  // auth
  //----------
  // datasource
  sl.registerSingleton<AuthMongoDataSourceImpl>(
    AuthMongoDataSourceImpl(mongoDbService: sl<MongoDbService>()),
  );
  // repoImpl
  sl.registerSingleton<AuthRepoImpl>(
    AuthRepoImpl(
      authMongoDataSource: sl<AuthMongoDataSourceImpl>(),
      googleSignIn: GoogleSignIn.instance,
    ),
  );
  // usecase
  sl.registerSingleton<GoogleSignInUsecase>(
    GoogleSignInUsecase(authRepo: sl<AuthRepoImpl>()),
  );
  sl.registerSingleton<SignOutUsecase>(
    SignOutUsecase(authRepo: sl<AuthRepoImpl>()),
  );
  sl.registerSingleton<GetMyUserInfoUsecase>(
    GetMyUserInfoUsecase(authRepo: sl<AuthRepoImpl>()),
  );

  //----------
  // connection
  //----------
  // datasource
  sl.registerSingleton<ConnectionDataSourceImpl>(
    ConnectionDataSourceImpl(mongoDbService: sl<MongoDbService>()),
  );
  // repoImpl
  sl.registerSingleton<ConnectionRepoImpl>(
    ConnectionRepoImpl(connectionDatasource: sl<ConnectionDataSourceImpl>()),
  );
  // usecase
  sl.registerSingleton<GetUserDetailUseCase>(
    GetUserDetailUseCase(connectionRepo: sl<ConnectionRepoImpl>()),
  );
  // sl.registerSingleton<SignOutUsecase>(
  //   SignOutUsecase(authRepo: sl<AuthRepoImpl>()),
  // );
  // sl.registerSingleton<GetUserInfoUsecase>(
  //   GetUserInfoUsecase(authRepo: sl<AuthRepoImpl>()),
  // );
}
