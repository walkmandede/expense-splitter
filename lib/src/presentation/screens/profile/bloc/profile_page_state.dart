part of 'profile_page_bloc.dart';

sealed class ProfilePageState extends Equatable {
  const ProfilePageState();

  @override
  List<Object> get props => [];
}

final class ProfilePageInitialState extends ProfilePageState {}

final class ProfilePageLoadingState extends ProfilePageState {}

final class ProfilePageSuccessState extends ProfilePageState {
  final UserEntity userEntity;
  const ProfilePageSuccessState({required this.userEntity});
}

final class ProfilePageFailureState extends ProfilePageState {
  final String errorMessage;
  const ProfilePageFailureState({required this.errorMessage});
}

final class ProfilePageLogOutLoadingState extends ProfilePageState {}

final class ProfilePageLogOutSuccessState extends ProfilePageState {}

final class ProfilePageLogOutFailureState extends ProfilePageState {}
