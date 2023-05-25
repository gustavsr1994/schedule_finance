part of 'theme_bloc.dart';

@immutable
abstract class ThemeEvent {}

class InitialPage extends ThemeEvent {
  final bool statusHidden;
  final bool statusThemeDark;
  InitialPage({required this.statusHidden, required this.statusThemeDark});
}

class ChangeHiddenValue extends ThemeEvent {
  final bool statusHidden;
  final bool statusThemeDark;
  ChangeHiddenValue(
      {required this.statusHidden, required this.statusThemeDark});
}

class ChangeThemeDarkValue extends ThemeEvent {
  final bool statusHidden;
  final bool statusThemeDark;
  ChangeThemeDarkValue(
      {required this.statusHidden, required this.statusThemeDark});
}
