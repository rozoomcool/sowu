import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sowu/domain/user_search/user_search_cubit.dart';

class UserSearchPage extends StatefulWidget {
  const UserSearchPage({super.key});

  @override
  State<UserSearchPage> createState() => _UserSearchPageState();
}

class _UserSearchPageState extends State<UserSearchPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController searchAnimationController;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    searchAnimationController.forward();

    searchController;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow,
            progress: searchAnimationController,
          ),
        ),
        title: TextField(
          onChanged: (value) => context.read<UserSearchCubit>().searchUsers(value),
          decoration:
              const InputDecoration(hintText: 'Поиск', border: InputBorder.none),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Недавние',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
                TextButton(onPressed: () {}, child: const Text('Очистить')),
              ],
            ),
          ),
          SizedBox(
            height: 56,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (_, __) => const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: CircleAvatar())),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('Поиск',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
          ),
          BlocConsumer<UserSearchCubit, UserSearchState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              if (state is UserSearchLoaded){
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.users.length,
                  itemBuilder: (context, index) => ListTile(
                    leading: const CircleAvatar(),
                    title: Text(state.users[index].nickname??''),
                    subtitle: Text('Hi, i\'m using sowu!'),
                  ),
                );
              } else {
                return Container();
              }

            },
          )
        ],
      )),
    );
  }
}
