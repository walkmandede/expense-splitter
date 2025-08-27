part of 'router.dart';

FutureOr<String?> handleRedirect(BuildContext context, GoRouterState state) {
  List<String> validRouteNames = [RouteNames.signIn, RouteNames.splash];

  if (validRouteNames.contains(state.matchedLocation)) {
    return null;
  }

  // check if the user is logged in or not
  final isAuthenticated = _isAuthenticated(context);
  if (!isAuthenticated) {
    return RouteNames.signIn;
  }

  return null;
}

bool _isAuthenticated(BuildContext context) {
  final user = FirebaseAuth.instance.currentUser;
  return user != null;
}
