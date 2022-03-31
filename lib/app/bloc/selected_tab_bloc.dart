import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lipl_bloc/app/app.dart';

part 'selected_tab_event.dart';
part 'selected_tab_state.dart';

class SelectedTabBloc extends Bloc<SelectedTabEvent, SelectedTabState> {
  SelectedTabBloc() : super(const SelectedTabState()) {
    on<SelectedTabChanged>(_onTabChanged);
  }

  void _onTabChanged(
    SelectedTabChanged event,
    Emitter<SelectedTabState> emit,
  ) {
    log.info('Handling on tab changed');
    emit(state.copyWith(selectedTab: event.tab));
  }
}
