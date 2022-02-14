part of 'edit_lyric_bloc.dart';

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

  bool get isNewLyric => id == null;

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
