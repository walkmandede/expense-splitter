import 'package:equatable/equatable.dart';
import 'package:expense_splitter/core/configs/router-configs/route_names.dart';
import 'package:expense_splitter/core/configs/router-configs/router.dart';
import 'package:expense_splitter/src/data/models/auth/user_model.dart';
import 'package:expense_splitter/src/domain/entities/auth/user_entity.dart';
import 'package:expense_splitter/src/domain/usecases/auth/get_my_user_info_usecase.dart';
import 'package:expense_splitter/src/domain/usecases/auth/sign_out_usecase.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../service_locator.dart';

part 'profile_page_event.dart';
part 'profile_page_state.dart';

class ProfilePageBloc extends Bloc<ProfilePageEvent, ProfilePageState> {
  final BuildContext context;

  ProfilePageBloc({required this.context}) : super(ProfilePageInitialState()) {
    on<ProfilePageEvent>((event, emit) async {
      if (event is ProfilePageSignOutEvent) {
        await _mapSignOutEvent(event, emit);
      } else if (event is ProfilePageGetUserInfoEvent) {
        await _mapGetUserInfoEvent(event, emit);
      }
    });
  }

  Future<void> _mapSignOutEvent(event, emit) async {
    emit(ProfilePageLogOutLoadingState());
    final result = await sl<SignOutUsecase>().call();
    result.fold(
      (l) {
        emit(ProfilePageLogOutFailureState());
      },
      (r) {
        emit(ProfilePageLogOutSuccessState());
        router.goNamed(RouteNames.signIn);
      },
    );
  }

  Future<void> _mapGetUserInfoEvent(
    ProfilePageGetUserInfoEvent event,
    Emitter<ProfilePageState> emit,
  ) async {
    emit(ProfilePageLoadingState());
    final result = await sl<GetMyUserInfoUsecase>().call();
    await result.fold(
      (l) {
        emit(ProfilePageFailureState(errorMessage: l));
      },
      (r) {
        emit(ProfilePageSuccessState(userEntity: r));
      },
    );
  }
}
