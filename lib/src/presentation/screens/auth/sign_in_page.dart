import 'package:expense_splitter/common/bloc/authentication/authentication_bloc.dart';
import 'package:expense_splitter/common/helpers/log_helpers.dart';
import 'package:expense_splitter/core/configs/router-configs/route_names.dart';
import 'package:expense_splitter/core/configs/router-configs/router.dart';
import 'package:expense_splitter/core/constants/responsive_breakpoints.dart';
import 'package:expense_splitter/core/overlay/dialog_service.dart';
import 'package:expense_splitter/service_locator.dart';
import 'package:expense_splitter/src/domain/usecases/auth/google_sign_usecase.dart';
import 'package:expense_splitter/src/presentation/screens/auth/bloc/sign_in_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInPageBloc(context: context),
      child: BlocListener<SignInPageBloc, SignInPageState>(
        listener: (context, state) {
          if (state is SignInLoadingState) {
            sl<DialogService>().showLoadingDialog(context: context);
          } else if (state is SignInSuccessState) {
            router.goNamed(RouteNames.home);
          } else if (state is SignInFailureState) {
            sl<DialogService>().showConfirmDialog(
              context: context,
              label: state.errorMessage,
            );
          }
        },
        child: BlocBuilder<SignInPageBloc, SignInPageState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.all(kBasePaddingM),
                child: Center(
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: state is SignInLoadingState ? 0.2 : 1,
                    child: SizedBox(
                      width: double.infinity,
                      height: kButtonHeightM,
                      child: FilledButton(
                        onPressed: () async {
                          context.read<SignInPageBloc>().add(SignInEvent());
                        },
                        child: Text("Sign In with Google"),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
