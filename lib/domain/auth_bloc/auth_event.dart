part of 'auth_bloc.dart';

abstract class AuthEvent {}

class AuthSignUpEvent extends AuthEvent {
  AuthSignUpEvent({required this.nickname, required this.email, required this.password});

  final String nickname;
  final String email;
  final String password;

  AuthSignUpEvent.name({required this.nickname, required this.email, required this.password});
}
class AuthLogInEvent extends AuthEvent {
  AuthLogInEvent({required this.nickname, required this.password});

  final String nickname;
  final String password;

  AuthLogInEvent.name({required this.nickname, required this.password});
}
class AuthRefreshEvent extends AuthEvent {}
class AuthGetUserEvent extends AuthEvent {}
class AuthLogOutEvent extends AuthEvent {}
