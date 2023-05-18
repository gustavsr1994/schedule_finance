import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitial()) {
    on<InitialPage>((event, emit) {
      emit(TaskSuccess(
          statusHidden: event.statusHidden,
          statusThemeDark: event.statusThemeDark));
    });
    on<ChangeHiddenValue>((event, emit) {
      emit(TaskSuccess(
          statusHidden: !event.statusHidden,
          statusThemeDark: event.statusThemeDark));
    });
    on<ChangeThemeDarkValue>((event, emit) {
      emit(TaskSuccess(
          statusHidden: event.statusHidden,
          statusThemeDark: !event.statusThemeDark));
    });
  }
}
