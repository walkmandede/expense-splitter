import 'package:expense_splitter/core/configs/router-configs/route_names.dart';
import 'package:expense_splitter/core/configs/router-configs/router.dart';
import 'package:expense_splitter/src/presentation/screens/splash/bloc/splash_page_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SplashPage extends HookWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashPageBloc()..add(SplashPageInitEvent()),
      child: BlocListener<SplashPageBloc, SplashPageState>(
        listener: (context, state) {
          if (state is SplashPageUnAuthenticatedState) {
            router.goNamed(RouteNames.signIn);
          } else {
            router.goNamed(RouteNames.home);
          }
        },
        child: _loadingWidget,
      ),
    );
  }

  Widget get _loadingWidget => Center(child: CupertinoActivityIndicator());
}
