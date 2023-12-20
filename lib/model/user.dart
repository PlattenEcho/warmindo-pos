class User {
  final String id;
  final String username;
  final DateTime createdAt;
  final String profileImageUrl;
  User({
    required this.id,
    required this.username,
    required this.createdAt,
    required this.profileImageUrl,
  });

  User.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        username = map['username'],
        createdAt = DateTime.parse(map['created_at']),
        profileImageUrl = map['profile_image_url'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'created_at': createdAt.toIso8601String(),
      'profile_image_url': profileImageUrl,
    };
  }
}
