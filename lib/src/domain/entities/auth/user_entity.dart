import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String firebaseUid;
  final String name;
  final String email;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.firebaseUid,
  });

  @override
  List<Object?> get props => [id, name, email, firebaseUid];
}
