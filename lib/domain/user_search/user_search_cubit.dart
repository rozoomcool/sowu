import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user.dart';

part 'user_search_state.dart';

class UserSearchCubit extends Cubit<UserSearchState> {
  UserSearchCubit() : super(UserSearchEmpty());

  final _dio = GetIt.I.get<Dio>();
  final _sharedPrefs = GetIt.I.get<SharedPreferences>();

  void searchUsers(String nickname) async {
    emit(UserSearchLoading());
    try {
      String accessToken = _sharedPrefs.getString('accessToken')!;
      final response = await _dio.get('/user/search',
          queryParameters: {'nickname': nickname},
          options: Options(headers: {'Authorization': 'Bearer $accessToken'}));

      if (response.statusCode! >= 200 && response.statusCode! < 400) {
        List<User> users = [for (var item in jsonDecode(response.data)) User.fromJson(item) ];
        print('______________ $users');

        return emit(UserSearchLoaded(users: users));
      } else {
        return emit(UserSearchFailed());
      }
    } catch (err) {
      print(err);
      return emit(UserSearchFailed());
    }
  }
}
