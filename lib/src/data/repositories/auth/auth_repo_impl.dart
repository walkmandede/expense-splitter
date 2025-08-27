import 'package:dartz/dartz.dart';
import 'package:expense_splitter/common/helpers/log_helpers.dart';
import 'package:expense_splitter/core/handlers/error-handler/error_handler.dart';
import 'package:expense_splitter/src/data/datasources/auth/mongo/auth_mongo_datasource.dart';
import 'package:expense_splitter/src/data/models/auth/user_model.dart';
import 'package:expense_splitter/src/domain/entities/auth/user_entity.dart';
import 'package:expense_splitter/src/domain/repositories/auth/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepoImpl extends AuthRepo {
  final GoogleSignIn googleSignIn;
  final AuthMongoDataSource authMongoDataSource;

  AuthRepoImpl({required this.googleSignIn, required this.authMongoDataSource});

  @override
  Future<Either<String, UserModel>> signInWithGoogle() async {
    try {
      await googleSignIn.initialize();

      final googleSingInAccount = await googleSignIn.authenticate();
      LogHelper.debug(message: googleSingInAccount);
      googleSignIn.disconnect();

      final googleCredential = GoogleAuthProvider.credential(
        idToken: googleSingInAccount.authentication.idToken,
      );

      final firebaseCredential = await FirebaseAuth.instance
          .signInWithCredential(googleCredential);
      if (firebaseCredential.user == null) {
        return Left("Unable to proceed Firebase aunthentication");
      }
      final UserModel userEntity = UserModel(
        id: firebaseCredential.user!.uid,
        name: firebaseCredential.user!.displayName ?? "",
        email: firebaseCredential.user!.email ?? "",
        firebaseUid: firebaseCredential.user?.uid ?? "",
      );
      final result = await authMongoDataSource.googleSignIn(
        userModel: userEntity,
      );
      return result;
    } catch (e, st) {
      handleError(e, st);

      if (e is GoogleSignInException) {
        return Left(
          e.description ?? "Something went wrong singing with Google",
        );
      }

      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, Unit>> signOut() async {
    await FirebaseAuth.instance.signOut();
    await googleSignIn.disconnect();
    return authMongoDataSource.singOut();
  }

  @override
  Future<Either<String, UserModel>> getUserInfo() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Left("There is no firebase user");
    } else {
      return authMongoDataSource.getCurrentUserInfo();
    }
  }
}
