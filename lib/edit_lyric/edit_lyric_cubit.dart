import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:parts/parts.dart';

extension PartsX on List<List<String>> {
  String intoText() => toText(this);
}

enum EditLyricStatus { initial, loading, succes, failure }

extension EditLyricStatusX on EditLyricStatus {
  bool get isLoadingOrSuccess => <EditLyricStatus>[
        EditLyricStatus.loading,
        EditLyricStatus.succes,
      ].contains(this);
}

class EditLyricState extends Equatable {
  const EditLyricState({
    this.status = EditLyricStatus.initial,
    this.id,
    this.title = '',
    this.text = '',
  });

  final EditLyricStatus status;
  final String? id;
  final String title;
  final String text;

  bool get isNew => id == null;

  EditLyricState copyWith({
    EditLyricStatus? status,
    String? id,
    String? title,
    String? text,
  }) =>
      EditLyricState(
        status: status ?? this.status,
        id: id ?? this.id,
        title: title ?? this.title,
        text: text ?? this.text,
      );

  @override
  List<Object?> get props => <Object?>[status, id, title, text];
}

class EditLyricCubit extends Cubit<EditLyricState> {
  EditLyricCubit({
    String? id,
    String? title,
    List<List<String>>? parts,
  }) : super(
          EditLyricState(
            id: id,
            title: title ?? '',
            text: parts == null ? '' : toText(parts),
          ),
        );

  void submitted() {
    emit(state.copyWith(status: EditLyricStatus.succes));
  }

  void titleChanged(String title) {
    emit(state.copyWith(title: title));
  }

  void textChanged(String text) {
    emit(state.copyWith(text: text));
  }
}
