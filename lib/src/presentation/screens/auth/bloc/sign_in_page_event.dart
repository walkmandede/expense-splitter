part of 'sign_in_page_bloc.dart';

sealed class SignInPageEvent extends Equatable {
  const SignInPageEvent();

  @override
  List<Object> get props => [];
}

class SignInEvent extends SignInPageEvent {}
