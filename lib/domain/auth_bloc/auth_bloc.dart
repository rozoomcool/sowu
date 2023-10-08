import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sowu/service/scaffold_utils.dart';

import '../../models/user.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthUnauthorizedState()) {
    on<AuthSignUpEvent>(_onAuthSignUp);
    on<AuthLogInEvent>(_onAuthLogIn);
    on<AuthRefreshEvent>(_onAuthRefresh);
    on<AuthGetUserEvent>(_onAuthGetUser);
    on<AuthLogOutEvent>(_onAuthLogOut);
    // Dev handler
    on<AuthDevEvent>(_onAuthDevEvent);
  }

  final _dio = GetIt.I.get<Dio>();
  final scaffoldKey = GetIt.I.get<GlobalScaffoldUtils>();
  final _sharedPrefs = GetIt.I.get<SharedPreferences>();

  _onAuthSignUp(AuthSignUpEvent event, Emitter<AuthState> emit) async {
    try {
      final response = await _dio.post('/auth/reg', data: {
        "nickname": event.nickname,
        "email": event.email,
        "password": event.password
      });

      if (response.statusCode == 200) {
        scaffoldKey.showSnack('Пользователь успешно зарегистрирован!');
      } else {
        scaffoldKey.showErrorSnack('Не удалось зарегистрироваться!');
      }
    } catch (e) {
      scaffoldKey.showErrorSnack('Не удалось зарегистрироваться!');
    }
  }

  _onAuthLogIn(AuthLogInEvent event, Emitter<AuthState> emit) async {
    try {
      final response = await _dio.post('/auth/login',
          data: {"nickname": event.nickname, "password": event.password});
      if (response.statusCode == 200) {
        String accessToken = response.data['accessToken'];
        String refreshToken = response.data['refreshToken'];

        _sharedPrefs.setString('accessToken', accessToken);
        _sharedPrefs.setString('refreshToken', refreshToken);

        scaffoldKey.showSnack('Добро пожаловать, ${event.nickname}!');

        add(AuthGetUserEvent());
        emit(AuthAuthorizedState(
            accessToken: accessToken, refreshToken: refreshToken));
      }
    } catch (e) {
      scaffoldKey.showErrorSnack('Не удалось войти!');
      emit(AuthUnauthorizedState());
    }
  }

  _onAuthRefresh(AuthRefreshEvent event, Emitter<AuthState> emit) async {
    try {
      String refreshToken = _sharedPrefs.getString('refreshToken')!;
      final response = await _dio.get('/auth/refresh',
          options: Options(headers: {'refreshToken': refreshToken}));

      String accessToken = response.data['accessToken'];
      refreshToken = response.data['refreshToken'];
      User user = User.fromJson(jsonDecode(_sharedPrefs.getString('user')!));

      _sharedPrefs.setString('accessToken', accessToken);
      _sharedPrefs.setString('refreshToken', refreshToken);

      scaffoldKey.showSnack('Добро пожаловать, ${user.nickname}!');
      emit(AuthAuthorizedState(
          accessToken: accessToken, refreshToken: refreshToken));
    } catch (e) {
      scaffoldKey.showErrorSnack('Ошибка авторизации');
      emit(AuthUnauthorizedState());
    }
  }

  _onAuthGetUser(AuthGetUserEvent event, Emitter<AuthState> emit) async {
    try{
      String accessToken = _sharedPrefs.getString('accessToken')!;
      final response = await _dio.get('/user',
          options: Options(headers: {'Authorization': 'Bearer $accessToken'}));

      User user = User.fromJson(jsonDecode(response.data)[0]);
      _sharedPrefs.setString('user', json.encode(user));
    } catch (e) {
      scaffoldKey.showErrorSnack('Ошибка запроса данных пользователя');
    }
  }

  _onAuthLogOut(AuthLogOutEvent event, Emitter<AuthState> emit) {
    _sharedPrefs.setString('accessToken', '');
    _sharedPrefs.setString('refreshToken', '');
    emit(AuthUnauthorizedState());
  }

  void _onAuthDevEvent(AuthDevEvent event, Emitter<AuthState> emit) {
    emit(AuthAuthorizedState(accessToken: '', refreshToken: ''));
  }
}
