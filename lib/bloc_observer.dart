import 'package:bloc/bloc.dart';
import 'package:logging/logging.dart';

final Logger log = Logger('$LiplBlocObserver');

class LiplBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    log.info('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log.info('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log.info('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    super.onClose(bloc);
    log.info('onClose -- ${bloc.runtimeType}');
  }
}
