class DetailUser {
  final String username;
  final String image;
  final String name;
  final String company;
  final int followers;
  final int following;

  DetailUser({
    required this.username,
    required this.image,
    required this.name,
    required this.company,
    required this.followers,
    required this.following,
  });

  factory DetailUser.fromJson(Map<String, dynamic> json) => DetailUser(
    username: json['login'] ?? ' ',
    image: json['avatar_url'] ?? ' ',
    name: json['name'] ?? ' ',
    company: json['company'] ?? ' ',
    following: json['following'] ?? 0,
    followers: json['followers'] ?? 0,
  );
}
