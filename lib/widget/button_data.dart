import 'package:lipl_bloc/widget/widget.dart';

class ButtonData<T> {
  ButtonData({
    required this.label,
    required this.onPressed,
    bool Function(T)? enabled,
  }) {
    if (enabled != null) {
      this.enabled = enabled;
    }
  }
  final String label;
  final OnPressed<T> onPressed;
  bool Function(T) enabled = (T f) => true;
}
