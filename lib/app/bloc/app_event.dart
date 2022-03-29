part of 'app_bloc.dart';

abstract class AppEvent {
  const AppEvent();
}

class AppSubscriptionRequested extends AppEvent {
  const AppSubscriptionRequested();
}

class AppTabChanged extends AppEvent {
  const AppTabChanged({required this.tab});
  final SelectedTab tab;
}

class AppPlaylistSelected extends AppEvent {
  const AppPlaylistSelected({required this.playlist});
  final Playlist? playlist;
}

class AppPlaylistDeletionRequested extends AppEvent {
  const AppPlaylistDeletionRequested({required this.id});
  final String id;
}

class AppLyricDeletionRequested extends AppEvent {
  const AppLyricDeletionRequested({required this.id});
  final String id;
}
