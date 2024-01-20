// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  final String id;
  final String name;
  final String mobile;
  final String token;
  final String password;
  final String profileImage;

  User({
    required this.id,
    required this.name,
    required this.mobile,
    required this.token,
    required this.password,
    required this.profileImage,
  });

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? token,
    String? password,
    String? profileImage,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      mobile: mobile ?? this.mobile,
      token: token ?? this.token,
      password: password ?? this.password,
      profileImage: profileImage ?? this.profileImage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'mobile': mobile,
      'token': token,
      'password': password,
      'profileImage': profileImage,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] as String,
      name: map['name'] as String,
      mobile: map['mobile'] as String,
      token: map['token'] as String,
      password: map['password'] as String,
      profileImage: map['profileImage'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $mobile, token: $token, password: $password)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.mobile == mobile &&
        other.token == token &&
        other.password == password &&
        other.profileImage == profileImage;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        mobile.hashCode ^
        token.hashCode ^
        password.hashCode ^
        profileImage.hashCode;
  }
}
