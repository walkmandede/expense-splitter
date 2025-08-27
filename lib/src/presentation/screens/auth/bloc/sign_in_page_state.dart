part of 'sign_in_page_bloc.dart';

sealed class SignInPageState extends Equatable {
  const SignInPageState();

  @override
  List<Object> get props => [];
}

final class SignInPageInitial extends SignInPageState {}

final class SignInLoadingState extends SignInPageState {}

final class SignInSuccessState extends SignInPageState {}

final class SignInFailureState extends SignInPageState {
  final String errorMessage;
  const SignInFailureState({required this.errorMessage});
}
