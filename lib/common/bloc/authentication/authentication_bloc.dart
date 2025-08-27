// import 'dart:convert';

// import 'package:dartz/dartz.dart';
// import 'package:equatable/equatable.dart';
// import 'package:expense_splitter/common/helpers/log_helpers.dart';
// import 'package:expense_splitter/core/configs/shared_preferences/sp_keys.dart';
// import 'package:expense_splitter/src/data/models/auth/user_model.dart';
// import 'package:expense_splitter/src/domain/usecases/auth/google_sign_usecase.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../../service_locator.dart';

// part "authentication_event.dart";
// part "authentication_state.dart";

// //
// // bloc to check if user is authenticated or not
// //
// class AuthenticationBloc
//     extends Bloc<AuthenticationEvent, AuthenticationState> {
//   UserModel? userModel;

//   AuthenticationBloc() : super(UninitializedState()) {
//     on<GetCachedUserInfoEvent>((event, emit) async {
//       await _mapGetCachedUserInfoEvent(event, emit);
//     });
//   }

//   Future<void> updateUserModel({required UserModel newUserModel}) async {
//     userModel = newUserModel;
//   }

//   // Future<Either<String, UserModel>> signIn({
//   //   required BuildContext context,
//   // }) async {
//   //   final result = await sl<GoogleLogInUsecase>().call();
//   //   await result.fold((l) {}, (r) async {
//   //     await updateUserModel(newUserModel: r);
//   //   });
//   //   return result;
//   // }

//   // Future<bool> signOut() async {
//   //   try {
//   //     userModel = null;
//   //     SharedPreferences sharedPreferences =
//   //         await SharedPreferences.getInstance();
//   //     await sharedPreferences.remove(SpKeys.userJson);
//   //     return true;
//   //   } catch (e) {
//   //     return false;
//   //   }
//   // }

//   Future<void> _mapGetCachedUserInfoEvent(event, emit) async {
//     //todo get cached user info

//     final firebaseUser = FirebaseAuth.instance.currentUser;

//     await Future.delayed(const Duration(milliseconds: 1500));
//     if (firebaseUser == null) {
//       emit(UnauthenticatedState());
//     } else {
//       emit(AuthenticatedState(userModel!));
//     }
//   }
// }
