import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:lipl_bloc/app/app.dart';
import 'package:lipl_bloc/bloc_observer.dart';

void main() {
  BlocOverrides.runZoned(
    () {
      runApp(
        const AppRepository(),
      );
    },
    blocObserver: MyBlocObserver(),
  );
}
