import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeInitial()) {
    on<InitialPage>((event, emit) {
      emit(ThemeSuccess(
          statusHidden: event.statusHidden,
          statusThemeDark: event.statusThemeDark));
    });
    on<ChangeHiddenValue>((event, emit) {
      emit(ThemeSuccess(
          statusHidden: !event.statusHidden,
          statusThemeDark: event.statusThemeDark));
    });
    on<ChangeThemeDarkValue>((event, emit) {
      emit(ThemeSuccess(
          statusHidden: event.statusHidden,
          statusThemeDark: !event.statusThemeDark));
    });
  }
}
