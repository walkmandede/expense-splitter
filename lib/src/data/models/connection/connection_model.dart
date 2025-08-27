import 'package:expense_splitter/src/domain/entities/connection/connection_entity.dart';
import 'package:mongo_dart/mongo_dart.dart';

class ConnectionModel extends ConnectionEntity {
  ConnectionModel({
    required super.id,
    required super.addressee,
    required super.enumConnectionStatus,
    required super.requester,
  });

  factory ConnectionModel.fromMongoJson({required Map<String, dynamic> json}) {
    return ConnectionModel(
      id: (json['_id'] as ObjectId).oid,
      addressee: ConnectionUserModel.fromMongoJson(
        json: json["addressee"] ?? {},
      ),
      requester: ConnectionUserModel.fromMongoJson(
        json: json["requester"] ?? {},
      ),
      enumConnectionStatus: EnumConnectionStatus.values.firstWhere(
        (element) => element.name == json["enumConnectionStatus"],
      ),
    );
  }
}

class ConnectionUserModel extends ConnectionUserEntity {
  ConnectionUserModel({
    required super.id,
    required super.email,
    required super.name,
  });

  factory ConnectionUserModel.fromMongoJson({
    required Map<String, dynamic> json,
  }) {
    return ConnectionUserModel(
      id: json["id"] ?? "",
      email: json["email"] ?? "",
      name: json["name"] ?? "",
    );
  }

  factory ConnectionUserModel.fromJson({required Map<String, dynamic> json}) {
    return ConnectionUserModel(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      email: json["email"] ?? "",
    );
  }

  Map<String, dynamic> toMongoJson() {
    return {"name": name, "email": email, "id": id};
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "name": name, "email": email};
  }
}
