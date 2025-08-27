import 'package:expense_splitter/src/domain/entities/auth/user_entity.dart';
import 'package:mongo_dart/mongo_dart.dart';

// extension UserEntityMapper on UserEntity {
//   UserModel toModel() {
//     return UserModel(
//       id: id,
//       name: name,
//       email: email,
//       firebaseUid: firebaseUid,
//     );
//   }
// }

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.firebaseUid,
  });

  factory UserModel.fromMongoJson({required Map<String, dynamic> json}) {
    return UserModel(
      id: (json['_id'] as ObjectId).oid,
      name: json["name"].toString(),
      email: json["email"].toString(),
      firebaseUid: json["firebaseUid"].toString(),
    );
  }

  factory UserModel.fromJson({
    required Map<String, dynamic> json,
    required String firebaseUid,
  }) {
    return UserModel(
      id: json["id"].toString(),
      name: json["name"].toString(),
      email: json["email"].toString(),
      firebaseUid: firebaseUid,
    );
  }

  Map<String, dynamic> toMongoJson() {
    return {"name": name, "email": email, "firebaseUid": firebaseUid};
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "name": name, "email": email, "firebaseUid": firebaseUid};
  }
}
