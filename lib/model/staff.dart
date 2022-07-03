import 'dart:convert';

class Staff {
  String name;
  String username;
  String password;
  String branch;
  Staff({
    required this.name,
    required this.username,
    required this.password,
    required this.branch,
  });

  Staff copyWith({
    String? name,
    String? username,
    String? password,
    String? branch,
  }) {
    return Staff(
      name: name ?? this.name,
      username: username ?? this.username,
      password: password ?? this.password,
      branch: branch ?? this.branch,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'username': username,
      'password': password,
      'branch': branch,
    };
  }

  factory Staff.fromMap(Map<String, dynamic> map) {
    return Staff(
      name: map['name'] ?? '',
      username: map['username'] ?? '',
      password: map['password'] ?? '',
      branch: map['branch'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Staff.fromJson(String source) => Staff.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Staff(name: $name, username: $username, password: $password, branch: $branch)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Staff &&
        other.name == name &&
        other.username == username &&
        other.password == password &&
        other.branch == branch;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        username.hashCode ^
        password.hashCode ^
        branch.hashCode;
  }
}
