import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sowu/service/scaffold_utils.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'application/application.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  await Hive.initFlutter();
  await Hive.openBox('chatsBox');

  GetIt.I.registerLazySingleton(() => sharedPreferences);
  GetIt.I.registerLazySingleton(() => Dio(BaseOptions(
        baseUrl: "http://10.0.2.2:3000",
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 3),
        contentType: 'application/json'
      )));
  GetIt.I.registerLazySingleton(() => IO.io('http://10.0.2.2:3000', IO.OptionBuilder().disableAutoConnect().build()));
  GetIt.I.registerLazySingleton(() => GlobalScaffoldUtils());

  runApp(MyApp());
}


// Примечание
// Запускать в случае неполадок flutter pub run build_runner build --delete-conflicting-outputs