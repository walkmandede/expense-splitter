part of 'profile_page_bloc.dart';

sealed class ProfilePageEvent extends Equatable {
  const ProfilePageEvent();

  @override
  List<Object> get props => [];
}

class ProfilePageSignOutEvent extends ProfilePageEvent {}

class ProfilePageGetUserInfoEvent extends ProfilePageEvent {}
