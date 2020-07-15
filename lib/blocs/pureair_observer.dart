import 'package:bloc/bloc.dart';

class PureAirBlocObserver extends BlocObserver {
   @override
  void onEvent(Bloc bloc, Object event) {
    print('onEvent $event');
    super.onEvent(bloc, event);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    print('onError $error');
    super.onError(bloc, error, stacktrace);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print('onTransition $transition');
    super.onTransition(bloc, transition);
  }
}