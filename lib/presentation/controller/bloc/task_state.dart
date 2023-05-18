part of 'task_bloc.dart';

@immutable
abstract class TaskState {}

class TaskInitial extends TaskState {}

class TaskSuccess extends TaskState {
  final bool statusHidden;
  final bool statusThemeDark;
  TaskSuccess({required this.statusHidden, required this.statusThemeDark});
}
