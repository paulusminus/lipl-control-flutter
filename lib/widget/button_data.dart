import 'package:lipl_bloc/widget/widget.dart';

class ButtonData<T> {
  ButtonData({
    required this.label,
    required this.onPressed,
  });
  final String label;
  final OnPressed<T> onPressed;
}
