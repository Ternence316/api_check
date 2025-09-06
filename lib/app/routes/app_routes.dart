part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const login = _Paths.login;
  static const home = _Paths.home;
  static const domainCheck = _Paths.domainCheck;
}

abstract class _Paths {
  _Paths._();
  static const login = '/login';
  static const home = '/home';
  static const domainCheck = '/domain-check';
}

