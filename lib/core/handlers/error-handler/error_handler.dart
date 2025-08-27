import 'dart:async';
import 'dart:io';

import 'package:expense_splitter/common/helpers/log_helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'src/index.dart';

abstract class BaseErrorHandler {
  String handleError(dynamic error, [StackTrace? stackTrace]);
}

class _ErrorFactory {
  static BaseErrorHandler getErrorHandler(dynamic error) {
    //TODO: add more error types to handle
    return GenericErrorHandler();
  }
}

String handleError(dynamic error, [StackTrace? stackTrace]) {
  LogHelper.error(tag: "ERROR", message: error.toString());
  final errorHandler = _ErrorFactory.getErrorHandler(error);
  return errorHandler.handleError(error, stackTrace);
}
