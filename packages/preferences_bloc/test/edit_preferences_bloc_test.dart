import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:preferences_bloc/src/edit_preferences_bloc.dart';
import 'package:preferences_bloc/src/preferences_bloc.dart';
import 'lipl_preferences.dart';

void main() {
  EditPreferencesBloc<LiplPreferences> createSubject() =>
      EditPreferencesBloc<LiplPreferences>(
        defaultValue: LiplPreferences.initial(),
        changes: const Stream.empty(),
      );

  EditPreferencesBloc<LiplPreferences> createSubjectChanges() {
    return EditPreferencesBloc<LiplPreferences>(
      defaultValue: LiplPreferences.initial(),
      changes: Stream.fromFutures(
        [
          Future.value(
            const PreferencesState<LiplPreferences>(
              item: LiplPreferences(
                username: 'Jos',
                password: 'Knippen',
                baseUrl: 'git',
              ),
              status: PreferencesStatus.succes,
            ),
          ),
          Future.value(
            const PreferencesState<LiplPreferences>(
              item: LiplPreferences(
                username: 'Jos 2',
                password: 'Knippen 2',
                baseUrl: 'git 2',
              ),
              status: PreferencesStatus.succes,
            ),
          ),
        ],
      ),
    );
  }

  group(
    'EditPreferencesBloc',
    () {
      test('State Equality', () {
        expect(createSubject().state, createSubject().state);
      });

      test('State props', () {
        expect(
          createSubject().state.props,
          [
            LiplPreferences.initial(),
            LiplPreferences.initial(),
          ],
        );
      });

      test('hasChanged false', () {
        final state = createSubject().state;
        expect(state.hasChanged, false);
      });

      test('hasChanged true', () {
        final state = createSubject().state;
        final newState = state.copyWith(
          preferences: () =>
              state.preferences.copyWith(username: 'testen maar'),
        );
        expect(newState.hasChanged, true);
      });

      blocTest<EditPreferencesBloc<LiplPreferences>,
          EditPreferencesState<LiplPreferences>>(
        'Load',
        build: () => createSubject(),
        act: (bloc) => bloc.add(
          EditPreferencesEventLoad<LiplPreferences>(
            preferences: const LiplPreferences(
              username: 'paul',
              password: 'CumgranoSalis',
              baseUrl: 'http',
            ),
          ),
        ),
        expect: () => [
          const EditPreferencesState<LiplPreferences>(
            initialPreferences: LiplPreferences(
              username: 'paul',
              password: 'CumgranoSalis',
              baseUrl: 'http',
            ),
            preferences: LiplPreferences(
              username: 'paul',
              password: 'CumgranoSalis',
              baseUrl: 'http',
            ),
          ),
        ],
      );

      blocTest<EditPreferencesBloc<LiplPreferences>,
          EditPreferencesState<LiplPreferences>>(
        'Change',
        build: () => createSubject(),
        seed: () => const EditPreferencesState<LiplPreferences>(
          initialPreferences: LiplPreferences(
            username: 'paul',
            password: 'CumgranoSalis',
            baseUrl: 'http',
          ),
          preferences: LiplPreferences(
            username: 'paul',
            password: 'CumgranoSalis',
            baseUrl: 'http',
          ),
        ),
        act: (bloc) => bloc.add(EditPreferencesEventChange(
            preferences: const LiplPreferences(
                username: 'Piet', password: 'Puk', baseUrl: 'https'))),
        expect: () => [
          const EditPreferencesState<LiplPreferences>(
            initialPreferences: LiplPreferences(
              username: 'paul',
              password: 'CumgranoSalis',
              baseUrl: 'http',
            ),
            preferences: LiplPreferences(
              username: 'Piet',
              password: 'Puk',
              baseUrl: 'https',
            ),
          ),
        ],
      );

      blocTest<EditPreferencesBloc<LiplPreferences>,
          EditPreferencesState<LiplPreferences>>(
        'Changes',
        build: () => createSubjectChanges(),
        expect: () => [
          const EditPreferencesState<LiplPreferences>(
            initialPreferences: LiplPreferences(
              username: 'Jos',
              password: 'Knippen',
              baseUrl: 'git',
            ),
            preferences: LiplPreferences(
              username: 'Jos',
              password: 'Knippen',
              baseUrl: 'git',
            ),
          ),
          const EditPreferencesState<LiplPreferences>(
            initialPreferences: LiplPreferences(
              username: 'Jos 2',
              password: 'Knippen 2',
              baseUrl: 'git 2',
            ),
            preferences: LiplPreferences(
              username: 'Jos 2',
              password: 'Knippen 2',
              baseUrl: 'git 2',
            ),
          ),
        ],
      );
    },
  );
}
