part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthUnauthorizedState extends AuthState {}

class AuthAuthorizedState extends AuthState {
  final String accessToken;
  final String refreshToken;

  AuthAuthorizedState({required this.accessToken, required this.refreshToken});
}
