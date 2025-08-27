import 'package:expense_splitter/core/constants/responsive_breakpoints.dart';
import 'package:expense_splitter/src/presentation/screens/profile/bloc/profile_page_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/bloc/authentication/authentication_bloc.dart';

class ProfilePage extends HookWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      return;
    }, []);
    return SafeArea(
      top: false,
      bottom: true,
      child: BlocProvider(
        create: (context) {
          return ProfilePageBloc(context: context)
            ..add(ProfilePageGetUserInfoEvent());
        },
        child: BlocListener<ProfilePageBloc, ProfilePageState>(
          listener: (context, state) {},
          child: BlocBuilder<ProfilePageBloc, ProfilePageState>(
            builder: (context, state) {
              return Scaffold(
                appBar: AppBar(),
                body: SizedBox.expand(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: kBasePaddingM,
                      vertical: kBasePaddingM,
                    ),
                    child: Column(
                      children: [
                        Expanded(child: _bodyWidget(state)),
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 500),
                          opacity: state is ProfilePageLogOutLoadingState
                              ? 0.3
                              : 1,
                          child: SizedBox(
                            width: double.infinity,
                            height: kButtonHeightM,
                            child: FilledButton(
                              onPressed: () {
                                context.read<ProfilePageBloc>().add(
                                  ProfilePageSignOutEvent(),
                                );
                              },
                              child: Text("Log Out Now"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  _bodyWidget(ProfilePageState state) {
    if (state is ProfilePageLoadingState) {
      return Center(child: CupertinoActivityIndicator());
    } else if (state is ProfilePageSuccessState) {
      return Center(child: Text(state.userEntity.email));
    } else if (state is ProfilePageFailureState) {
      return Center(child: Text(state.errorMessage));
    } else {
      return const SizedBox.shrink();
    }
  }
}
