class UserList {
  final List<User> users;

  UserList({required this.users});

  factory UserList.fromApi(dynamic data) => UserList(
        users: List<User>.from(
          data.map(
            (doc) => User.fromMap(doc as Map<String, dynamic>),
          ),
        ),
      );
}

class User {
  final int id;
  final String name;
  final String email;

  User({
    required this.id,
    required this.name,
    required this.email,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
    );
  }
}
