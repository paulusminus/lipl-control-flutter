import 'package:flutter/material.dart';
import 'package:lipl_test/dal/dal.dart';
import 'package:lipl_test/ui/ui.dart';
import 'constant.dart';

Dal getDal(bool useFake) => useFake
    ? FakeDal()
    : HttpDal(
        client: LiplClient(username: USERNAME, password: PASSWORD),
        prefix: PREFIX,
      );

void main() {
  final Dal dal = getDal(true);
  runApp(App(dal: dal));
}
