import 'package:equatable/equatable.dart';

class User extends Equatable{
  late final String? nickname;
  late final String? email;

  User({required this.nickname, required this.email});
  User.fromJson(Map<String, dynamic> json) {
    nickname = json['nickname'];
    email = json['email'];
  }

  @override
  List<Object?> get props => [nickname, email];

  Map toJson() => {
    'nickname': nickname,
    'email': email
  };

}