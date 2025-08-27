import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_splitter/common/helpers/log_helpers.dart';
import 'package:expense_splitter/core/overlay/dialog_service.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/bloc/authentication/authentication_bloc.dart';
import '../../../../../service_locator.dart';
import '../../../../data/models/auth/user_model.dart';
import '../../../../domain/usecases/auth/google_sign_usecase.dart';
part 'sign_in_page_event.dart';
part 'sign_in_page_state.dart';

class SignInPageBloc extends Bloc<SignInPageEvent, SignInPageState> {
  final BuildContext context;
  SignInPageBloc({required this.context}) : super(SignInPageInitial()) {
    on<SignInPageEvent>((event, emit) async {
      if (event is SignInEvent) {
        await _mapSignInPageEvent(event, emit);
      }
    });
  }

  Future<void> _mapSignInPageEvent(event, emit) async {
    emit(SignInLoadingState());
    final result = await sl<GoogleSignInUsecase>().call();
    await result.fold(
      (l) {
        DialogService().showConfirmDialog(context: context, label: l);
        emit(SignInFailureState(errorMessage: l));
      },
      (r) {
        emit(SignInSuccessState());
      },
    );
  }
}
