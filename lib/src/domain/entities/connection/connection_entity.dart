enum EnumConnectionStatus { pending, accepted, decline }

class ConnectionEntity {
  final String id;
  final ConnectionUserEntity requester;
  final ConnectionUserEntity addressee;
  final EnumConnectionStatus enumConnectionStatus;
  const ConnectionEntity({
    required this.id,
    required this.addressee,
    required this.enumConnectionStatus,
    required this.requester,
  });
}

class ConnectionUserEntity {
  final String id;
  final String name;
  final String email;

  const ConnectionUserEntity({
    required this.id,
    required this.email,
    required this.name,
  });
}
