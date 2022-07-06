import 'dart:convert';

class Staff {
  String name;
  String email;
  String branch;
  Staff({
    required this.name,
    required this.email,
    required this.branch,
  });

  Staff copyWith({
    String? name,
    String? email,
    String? branch,
  }) {
    return Staff(
      name: name ?? this.name,
      email: email ?? this.email,
      branch: branch ?? this.branch,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'branch': branch,
    };
  }

  factory Staff.fromMap(Map<String, dynamic> map) {
    return Staff(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      branch: map['branch'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Staff.fromJson(String source) => Staff.fromMap(json.decode(source));

  @override
  String toString() => 'Staff(name: $name, email: $email, branch: $branch)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Staff &&
        other.name == name &&
        other.email == email &&
        other.branch == branch;
  }

  @override
  int get hashCode => name.hashCode ^ email.hashCode ^ branch.hashCode;
}
