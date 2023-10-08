import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sowu/domain/user_search/user_search_cubit.dart';
import 'package:sowu/presentation/auth_page.dart';
import 'package:sowu/presentation/home_page.dart';
import 'package:sowu/presentation/profile_page.dart';
import 'package:sowu/presentation/user_search_page.dart';
import 'package:sowu/presentation/settings_page.dart';

import '../domain/auth_bloc/auth_bloc.dart';
import '../service/scaffold_utils.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter _router = GoRouter(
      routes: [
        GoRoute(path: '/', builder: (context, state) => const HomePage()),
        GoRoute(path: '/auth', builder: (context, state) => const AuthPage()),
        GoRoute(path: '/settings', builder: (context, state) => const SettingsPage()),
        GoRoute(path: '/profile', builder: (context, state) => const ProfilePage()),
        GoRoute(path: '/search', builder: (context, state) => BlocProvider<UserSearchCubit>(create: (context) => UserSearchCubit(), child: const UserSearchPage()))
      ],
      redirect: (context, state) {
        if (context.read<AuthBloc>().state is AuthUnauthorizedState) {
          return '/auth';
        }
        return null;
      });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc()..add(AuthRefreshEvent()),
      child: MaterialApp.router(
        key: GetIt.I<GlobalScaffoldUtils>().key,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            useMaterial3: true,
            textTheme: GoogleFonts.montserratTextTheme()),
        // theme: ThemeData.dark(useMaterial3: true).copyWith(textTheme: GoogleFonts.montserratTextTheme()),
        routerConfig: _router,
      ),
    );
  }
}
