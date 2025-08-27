part of 'splash_page_bloc.dart';

sealed class SplashPageState extends Equatable {
  const SplashPageState();

  @override
  List<Object> get props => [];
}

final class SplashPageInitial extends SplashPageState {}

final class SplashPageUnAuthenticatedState extends SplashPageState {}

final class SplashPageAuthenticatedState extends SplashPageState {}
