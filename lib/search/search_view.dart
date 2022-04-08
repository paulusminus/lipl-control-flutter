import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lipl_bloc/app/app.dart';
import 'package:lipl_bloc/l10n/l10n.dart';
import 'package:lipl_bloc/search/search_cubit.dart';
import 'package:lipl_bloc/widget/widget.dart';
import 'package:lipl_rest_bloc/lipl_rest_bloc.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  static MaterialPageRoute<void> route() => MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (_) => const SearchPage(),
      );

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.searchPageTitle)),
      body: Column(
        children: <Widget>[
          SearchForm(),
          Expanded(
            child: SearchResults(),
          )
        ],
      ),
    );
  }
}

class SearchForm extends StatefulWidget {
  @override
  State<SearchForm> createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  String searchTerm = '';

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Form(
        key: _formKey,
        child: Row(
          children: <Widget>[
            Flexible(
              flex: 6,
              child: TextFormField(
                initialValue: '',
                onChanged: (String value) {
                  setState(
                    () {
                      searchTerm = value.trim();
                    },
                  );
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  label: Text(l10n.searchButtonLabel),
                ),
                validator: (String? value) {
                  if (value == null || value.trim().length < 3) {
                    return l10n.searchMinimalCharsError;
                  }
                  return null;
                },
              ),
            ),
            Flexible(
              flex: 1,
              child: textButton<void>(
                item: null,
                buttonData: ButtonData<void>(
                  label: l10n.searchButtonLabel,
                  enabled: (_) => searchTerm.length >= 3,
                  onPressed: (_) {
                    final FormState? form = _formKey.currentState;
                    if (form?.validate() ?? false) {
                      context.read<SearchCubit>().search(
                            searchTerm,
                          );
                      form?.reset();
                      setState(() {
                        searchTerm = '';
                      });
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchResults extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (BuildContext context, SearchState state) {
        final List<Lyric> searchResult = state.searchResult;
        return ListTile(
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Text(
              (searchResult.isNotEmpty
                      ? l10n.searchDoesHaveResults
                      : l10n.searchNoResults) +
                  ' ' +
                  l10n.searchResultsFor +
                  ' ' +
                  state.searchTerm,
            ),
          ),
          subtitle: renderLyricList(context, searchResult),
        );
      },
    );
  }
}
