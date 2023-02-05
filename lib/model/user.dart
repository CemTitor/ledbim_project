import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  int? id;
  String? email;
  String? first_name;
  String? last_name;
  String? avatar;

  User(
      {
        this.id,
        this.email,
        this.first_name,
        this.last_name,
        this.avatar
      });

  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  List<Object?> get props => [
    id,
    email,
    first_name,
    last_name,
    avatar,
  ];

  User copyWith({
    int? id,
    String? email,
    String? first_name,
    String? last_name,
    String? avatar,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      first_name: first_name ?? this.first_name,
      last_name: last_name ?? this.last_name,
      avatar: avatar ?? this.avatar,
    );
  }

  static final empty = User(
    id: 0,
    email: '',
    first_name: '',
    last_name: '',
    avatar: '',
  );
}

