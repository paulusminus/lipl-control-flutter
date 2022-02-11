import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:lipl_bloc/app/app.dart';
import 'package:lipl_bloc/bloc_observer.dart';
import 'package:lipl_bloc/dal/dal.dart';
import 'constant.dart';

Dal getDal(bool useFake) => useFake
    ? FakeDal()
    : HttpDal(
        client: LiplClient(username: USERNAME, password: PASSWORD),
        prefix: PREFIX,
      );

void main() {
  BlocOverrides.runZoned(
    () {
      final Dal dal = getDal(true);
      runApp(
        AppRepository(dal: dal),
      );
    },
    blocObserver: MyBlocObserver(),
  );
}
