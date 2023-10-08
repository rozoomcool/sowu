import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sowu/domain/auth_bloc/auth_bloc.dart';
import 'package:sowu/widgets/slide_up.dart';

class CustomDrawer extends StatelessWidget{
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(

        child: ListView(
          shrinkWrap: true,
          children: [
            DrawerHeader(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 36,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      "nickname",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text("email", style: Theme.of(context).textTheme.labelLarge,),
                  ],
                )),
            ListTile(
              leading: const Icon(LineIcons.home),
              title: const Text("Домой"),
              onTap: () => context.go("/"),
            ),
            ListTile(
              leading: const Icon(LineIcons.user),
              title: const Text("Профиль"),
              onTap: () => context.go("/profile"),
            ),
            ListTile(
              leading: const Icon(LineIcons.cog),
              title: const Text("Настройки"),
              onTap: () => context.go("/settings"),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Divider(),
            ),
            ListTile(
              leading: const Icon(LineIcons.alternateSignOut),
              title: const Text("Выход"),
              onTap: () {
                context.read<AuthBloc>().add(AuthLogOutEvent());
                context.go('/auth');
              },
            ),
          ],
        ),
      ),
    );
  }
  
}