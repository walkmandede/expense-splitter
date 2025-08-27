import 'package:dartz/dartz.dart';
import 'package:expense_splitter/src/domain/entities/auth/user_entity.dart';
import 'package:expense_splitter/src/domain/repositories/auth/auth_repo.dart';

class GetMyUserInfoUsecase {
  final AuthRepo authRepo;
  GetMyUserInfoUsecase({required this.authRepo});

  Future<Either<String, UserEntity>> call() async {
    return authRepo.getUserInfo();
  }
}
