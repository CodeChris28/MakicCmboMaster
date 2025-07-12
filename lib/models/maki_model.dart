class Maki {
  final String id;
  final String name;
  final String description;
  final String? imageUrl;
  final bool isUserCreated;

  Maki({
    required this.id,
    required this.name,
    required this.description,
    this.imageUrl,
    this.isUserCreated = true,
  });

  factory Maki.fromMap(String id, Map<String, dynamic> data) {
    return Maki(
      id: id,
      name: data['name'],
      description: data['description'],
      imageUrl: data['imageUrl'],
      isUserCreated: data['isUserCreated'] ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'isUserCreated': isUserCreated,
    };
  }
}
