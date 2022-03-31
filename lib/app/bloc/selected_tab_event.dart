part of 'selected_tab_bloc.dart';

abstract class SelectedTabEvent {
  const SelectedTabEvent();
}

class SelectedTabChanged extends SelectedTabEvent {
  const SelectedTabChanged({required this.tab});
  final SelectedTab tab;
}
