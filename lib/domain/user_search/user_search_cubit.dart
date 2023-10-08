import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../models/user.dart';

part 'user_search_state.dart';

class UserSearchCubit extends Cubit<UserSearchState> {
  UserSearchCubit() : super(UserSearchEmpty());

  final _dio = GetIt.I.get<Dio>();

  void searchUsers(String nickname) async {
    emit(UserSearchLoading());
    try{
      final response = await _dio.get('user/', queryParameters: {'nickname': nickname});
      if(response.statusCode! >= 200 && response.statusCode! < 400) {
        List<User> users = jsonDecode(response.data);
        emit(UserSearchLoaded(users: users));
      } else {
        emit(UserSearchFailed());
      }
    } catch (err) {
      emit(UserSearchFailed());
    }
  }
}
