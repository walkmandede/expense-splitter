import 'package:dartz/dartz.dart';
import 'package:expense_splitter/src/domain/repositories/auth/auth_repo.dart';

class SignOutUsecase {
  final AuthRepo authRepo;
  SignOutUsecase({required this.authRepo});

  Future<Either<String, Unit>> call() async {
    return await authRepo.signOut();
  }
}
