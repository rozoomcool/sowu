import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sowu/widgets/custom_drawer.dart';

import '../service/scaffold_utils.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SoWu', style: Theme.of(context).textTheme.titleLarge,),
        centerTitle: true,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(LineIcons.bars),
              onPressed: () => Scaffold.of(context).openDrawer(),
            );
          }
        ),
        actions: [
          IconButton(onPressed: () => context.push('/search'), icon: const Icon(LineIcons.search))
        ],
      ),
      drawer: const CustomDrawer(),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text('Home')],
      ),
    );
  }

}