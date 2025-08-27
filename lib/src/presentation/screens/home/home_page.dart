import 'package:expense_splitter/common/bloc/authentication/authentication_bloc.dart';
import 'package:expense_splitter/core/configs/router-configs/route_names.dart';
import 'package:expense_splitter/core/configs/router-configs/router.dart';
import 'package:expense_splitter/src/presentation/screens/home/cubit/home_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HomePage extends StatefulHookWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomePageCubit(),
      child: BlocBuilder<HomePageCubit, HomePageState>(
        builder: (context, state) {
          final cubit = context.read<HomePageCubit>();

          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    router.pushNamed(RouteNames.profile);
                  },
                  icon: Icon(Icons.person),
                ),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: state.currentTab.index,
              onTap: (index) {
                cubit.switchTab(EnumHomePageTabs.values[index]);
              },
              items: EnumHomePageTabs.values.map((tab) {
                return BottomNavigationBarItem(
                  icon: Icon(tab.icon),
                  label: tab.label,
                );
              }).toList(),
            ),
            body: IndexedStack(
              index: state.currentTab.index,
              children: const [
                Center(child: Text("Active Groups")),
                Center(child: Text("Closed Groups")),
                Center(child: Text("Connections")),
              ],
            ),
          );
        },
      ),
    );
  }
}
