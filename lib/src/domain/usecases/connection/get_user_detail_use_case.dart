import 'package:dartz/dartz.dart';
import 'package:expense_splitter/src/domain/entities/auth/user_entity.dart';
import 'package:expense_splitter/src/domain/repositories/connection/connection_repo.dart';

class GetUserDetailUseCase {
  final ConnectionRepo connectionRepo;
  GetUserDetailUseCase({required this.connectionRepo});

  Future<Either<String, UserEntity>> call({required String email}) async {
    return connectionRepo.getUserDetail(email: email);
  }
}
