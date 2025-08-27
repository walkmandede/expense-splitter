part of 'home_page_cubit.dart';

abstract class HomePageState extends Equatable {
  final EnumHomePageTabs currentTab;
  const HomePageState({required this.currentTab});

  @override
  List<Object?> get props => [currentTab];
}

class HomePageInitial extends HomePageState {
  const HomePageInitial({required super.currentTab});
}

class HomePageTabChanged extends HomePageState {
  const HomePageTabChanged({required super.currentTab});
}
