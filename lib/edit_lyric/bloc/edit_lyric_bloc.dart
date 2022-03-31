import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:parts/parts.dart';

part 'edit_lyric_event.dart';
part 'edit_lyric_state.dart';

extension PartsX on List<List<String>> {
  String intoText() => toText(this);
}

class EditLyricBloc extends Bloc<EditLyricEvent, EditLyricState> {
  EditLyricBloc({
    String? id,
    String? title,
    List<List<String>>? parts,
  }) : super(
          EditLyricState(
            id: id,
            title: title ?? '',
            text: parts == null ? '' : toText(parts),
          ),
        ) {
    on<EditLyricTitleChanged>(_onTitleChanged);
    on<EditLyricTextChanged>(_onTextChanged);
    on<EditLyricSubmitted>(_onSubmitted);
  }

  void _onSubmitted(EditLyricSubmitted event, Emitter<EditLyricState> emit) {
    emit(state.copyWith(status: EditLyricStatus.succes));
  }

  void _onTitleChanged(
    EditLyricTitleChanged event,
    Emitter<EditLyricState> emit,
  ) {
    emit(state.copyWith(title: event.title));
  }

  void _onTextChanged(
    EditLyricTextChanged event,
    Emitter<EditLyricState> emit,
  ) {
    emit(state.copyWith(text: event.text));
  }
}
