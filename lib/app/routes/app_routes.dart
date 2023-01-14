part of 'app_pages.dart';

abstract class Routes{
  Routes._();
  static const NEWS = _Paths.NEWS;
  static const NAVIGATOR = _Paths.NAVIGATOR;
  static const LOGIN = _Paths.LOGIN;
}

abstract class _Paths{
  _Paths._();
  static const NEWS = '/news';
  static const NAVIGATOR = '/navigator';
  static const LOGIN = '/login';
}