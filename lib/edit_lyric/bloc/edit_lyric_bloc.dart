import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lipl_repo/lipl_repo.dart';
import 'package:parts/parts.dart';

part 'edit_lyric_event.dart';
part 'edit_lyric_state.dart';

extension PartsX on List<List<String>> {
  String intoText() => toText(this);
}

class EditLyricBloc extends Bloc<EditLyricEvent, EditLyricState> {
  EditLyricBloc({
    required LiplRestStorage liplRestStorage,
    required String? id,
    required String? title,
    required List<List<String>>? parts,
  })  : _liplRestStorage = liplRestStorage,
        super(
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
  final LiplRestStorage _liplRestStorage;

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

  Future<void> _onSubmitted(
    EditLyricSubmitted event,
    Emitter<EditLyricState> emit,
  ) async {
    if (state.isNewLyric) {
      final LyricPost lyricPost = LyricPost(
        title: state.title,
        parts: toParts(state.text),
      );
      final Lyric lyric = await _liplRestStorage.postLyric(lyricPost);
      emit(
        state.copyWith(
          status: EditLyricStatus.succes,
          id: lyric.id,
          title: lyric.title,
          text: toText(lyric.parts),
        ),
      );
    } else {
      final Lyric lyric = Lyric(
        id: state.id,
        title: state.title,
        parts: toParts(state.text),
      );
      final Lyric puttedLyric = await _liplRestStorage.putLyric(lyric);
      emit(
        state.copyWith(
          status: EditLyricStatus.succes,
          id: puttedLyric.id,
          title: puttedLyric.title,
          text: toText(lyric.parts),
        ),
      );
    }
  }
}
