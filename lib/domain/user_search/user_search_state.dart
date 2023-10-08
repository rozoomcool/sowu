part of 'user_search_cubit.dart';

abstract class UserSearchState {}

class UserSearchEmpty extends UserSearchState {}
class UserSearchLoading extends UserSearchState {}
class UserSearchFailed extends UserSearchState {}

class UserSearchLoaded extends UserSearchState {
  final List<User> users;

  UserSearchLoaded({required this.users});
}
