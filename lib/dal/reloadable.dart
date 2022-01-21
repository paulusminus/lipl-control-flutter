import 'dart:async';

abstract class Reloadable<T> {
  Reloadable(Future<T> Function() load) {
    _load = load;
    _onReload.stream.listen((int e) async {
      try {
        final T t = await _load();
        _onNewData.sink.add(t);
      } catch (e) {
        _onError.sink.add(e as Exception);
      }
    });
  }

  int _count = 0;
  final StreamController<T> _onNewData = StreamController<T>();
  final StreamController<int> _onReload = StreamController<int>();
  final StreamController<Exception> _onError = StreamController<Exception>();
  late Future<T> Function() _load;

  Stream<T> get onNewData => _onNewData.stream.asBroadcastStream();
  Stream<Exception> get onError => _onError.stream.asBroadcastStream();

  void refresh() {
    _count++;
    _onReload.add(_count);
  }

  void dispose() {
    _onReload.close();
    _onNewData.close();
  }
}
