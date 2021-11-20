class User {
  final String username;
  final String image;

  User({
    required this.username,
    required this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json['login'],
        image: json['avatar_url'],
      );
}

class SearchUser {
  final int total;
  final List<User> items;

  SearchUser({
    required this.total,
    required this.items,
  });

  factory SearchUser.fromJson(Map<String, dynamic> json) => SearchUser(
      total: json['total_count'],
      items: List<User>.from(json['items'].map((user) => User.fromJson(user)))
  );
}
