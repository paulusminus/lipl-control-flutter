import 'package:flutter/material.dart';
import 'package:lipl_bloc/widget/widget.dart';

TextButton textButton<T>({
  required T item,
  required ButtonData<T> buttonData,
}) =>
    TextButton(
      onPressed: () {
        buttonData.onPressed(item);
      },
      child: Text(
        buttonData.label.toUpperCase(),
        style: const TextStyle(
          letterSpacing: 1.5,
        ),
      ),
    );
