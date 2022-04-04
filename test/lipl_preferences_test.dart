import 'package:flutter_test/flutter_test.dart';
import 'package:lipl_bloc/app/app.dart';

void main() {
  group('LiplPreferences', () {
    LiplPreferences createSubject() => const LiplPreferences(
          username: 'username',
          password: 'password',
          baseUrl: 'baseUrl',
        );

    test('Constructor', () {
      final LiplPreferences liplPreferences = createSubject();
      expect(
        liplPreferences.username,
        'username',
      );
      expect(
        liplPreferences.password,
        'password',
      );
      expect(
        liplPreferences.baseUrl,
        'baseUrl',
      );
    });

    test('Factory blank', () {
      final LiplPreferences liplPreferences = LiplPreferences.blank();
      expect(
        liplPreferences.username,
        '',
      );
      expect(
        liplPreferences.password,
        '',
      );
      expect(
        liplPreferences.baseUrl,
        '',
      );
    });

    test('Equality', () {
      expect(
        createSubject(),
        createSubject(),
      );
    });

    test('Props', () {
      expect(
        createSubject().props,
        <Object?>['username', 'password', 'baseUrl'],
      );
    });

    test('Json', () {
      expect(
        LiplPreferences.deserialize(createSubject().serialize()),
        createSubject(),
      );
    });

    test('Deserialize error', () {
      expect(
        () => LiplPreferences.deserialize('aslkjidf'),
        throwsFormatException,
      );
    });

    test('CopyWith equality', () {
      expect(
        createSubject().copyWith(),
        createSubject(),
      );
    });

    test('CopyWith change username', () {
      final LiplPreferences liplPreferences =
          createSubject().copyWith(username: 'username 2');
      expect(liplPreferences.username, 'username 2');
    });
  });
}
