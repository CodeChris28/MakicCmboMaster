class Maki{
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final bool isUserCreated;

  Maki ({
  required this.id,
  required this.name,
  required this.description,
  required this.imageUrl,
  this.isUserCreated = false,
  });

  factory Maki.fromMap(String id, Map<String, dynamic> data ){
    return Maki(
    id: id,
    name: data['name'], 
    description: data['description'], 
    imageUrl: data['imageUrl'],
    isUserCreated: data['isUserCreated'] ?? false,
    );
    }

  Map<String, dynamic> toMap() {
    return
    {'name': name,
    'description': description,
    'imageUrl': imageUrl,
    'isUserCreated': isUserCreated,};
  }

}

