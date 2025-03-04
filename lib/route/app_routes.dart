part of 'app_pages.dart';
abstract class Routes {
  Routes._();
  static const homeScreen = _Paths.homeScreen;
  static const loginView = _Paths.loginView;
}

abstract class _Paths {
  _Paths._();
  static const homeScreen = '/home_screen';
  static const loginView = '/login_view';
}