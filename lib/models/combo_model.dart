class Combo {
  final String id;
  final String name;
  final List<String> makiIds;
  final String userId;

  Combo({
    required this.id,
    required this.name,
    required this.makiIds,
    required this.userId,
  });

  factory Combo.fromMap(String id, Map<String, dynamic> data) {
    return Combo(
      id: id,
      name: data['name'],
      makiIds: List<String>.from(data['makiIds']),
      userId: data['userId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'makiIds': makiIds,
      'userId': userId,
    };
  }
}
