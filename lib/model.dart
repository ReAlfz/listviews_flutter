class User {
  final String name;
  final String image;

  User({
    required this.name,
    required this.image
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
      name: json['login'],
      image: json['avatar_url']
  );
}