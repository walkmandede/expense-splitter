import 'package:dartz/dartz.dart';
import 'package:expense_splitter/src/domain/entities/auth/user_entity.dart';
import 'package:expense_splitter/src/domain/repositories/auth/auth_repo.dart';

class GoogleSignInUsecase {
  final AuthRepo authRepo;
  GoogleSignInUsecase({required this.authRepo});

  Future<Either<String, UserEntity>> call() async {
    return authRepo.signInWithGoogle();
  }
}
