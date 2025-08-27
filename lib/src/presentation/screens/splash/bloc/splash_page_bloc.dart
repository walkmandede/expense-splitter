import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_splitter/src/domain/usecases/auth/get_my_user_info_usecase.dart';

import '../../../../../service_locator.dart';

part 'splash_page_event.dart';
part 'splash_page_state.dart';

class SplashPageBloc extends Bloc<SplashPageEvent, SplashPageState> {
  SplashPageBloc() : super(SplashPageInitial()) {
    on<SplashPageEvent>((event, emit) async {
      if (event is SplashPageInitEvent) {
        await _mapSplashPageInitEvent(event, emit);
      }
    });
  }

  Future<void> _mapSplashPageInitEvent(event, emit) async {
    final result = await sl<GetMyUserInfoUsecase>().call();
    await result.fold(
      (l) {
        emit(SplashPageUnAuthenticatedState());
      },
      (r) {
        emit(SplashPageAuthenticatedState());
      },
    );
  }
}
