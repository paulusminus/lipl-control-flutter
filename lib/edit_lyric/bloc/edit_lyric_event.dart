part of 'edit_lyric_bloc.dart';

abstract class EditLyricEvent extends Equatable {
  const EditLyricEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class EditLyricTitleChanged extends EditLyricEvent {
  const EditLyricTitleChanged(this.title);

  final String title;

  @override
  List<Object?> get props => <Object?>[title];
}

class EditLyricTextChanged extends EditLyricEvent {
  const EditLyricTextChanged(this.text);

  final String text;

  @override
  List<Object?> get props => <Object?>[text];
}

class EditLyricSubmitted extends EditLyricEvent {
  const EditLyricSubmitted();
}
