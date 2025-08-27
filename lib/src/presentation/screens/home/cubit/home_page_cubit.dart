import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_page_state.dart';

enum EnumHomePageTabs {
  activeGroups(icon: Icons.radio_button_checked_rounded, label: "Active"),
  closed(icon: Icons.done_all_rounded, label: "Closed"),
  connections(icon: Icons.people_rounded, label: "Connections");

  final String label;
  final IconData icon;
  const EnumHomePageTabs({required this.icon, required this.label});
}

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit()
    : super(HomePageInitial(currentTab: EnumHomePageTabs.activeGroups));

  void switchTab(EnumHomePageTabs tab) {
    emit(HomePageTabChanged(currentTab: tab));
  }
}
