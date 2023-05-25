part of 'theme_bloc.dart';

@immutable
abstract class ThemeState {}

class ThemeInitial extends ThemeState {}

class ThemeSuccess extends ThemeState {
  final bool statusHidden;
  final bool statusThemeDark;
  ThemeSuccess({required this.statusHidden, required this.statusThemeDark});
}
