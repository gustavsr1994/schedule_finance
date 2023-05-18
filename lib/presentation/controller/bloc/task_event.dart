part of 'task_bloc.dart';

@immutable
abstract class TaskEvent {}

class InitialPage extends TaskEvent {
  final bool statusHidden;
  final bool statusThemeDark;
  InitialPage({required this.statusHidden, required this.statusThemeDark});
}

class ChangeHiddenValue extends TaskEvent {
  final bool statusHidden;
  final bool statusThemeDark;
  ChangeHiddenValue(
      {required this.statusHidden, required this.statusThemeDark});
}

class ChangeThemeDarkValue extends TaskEvent {
  final bool statusHidden;
  final bool statusThemeDark;
  ChangeThemeDarkValue(
      {required this.statusHidden, required this.statusThemeDark});
}
