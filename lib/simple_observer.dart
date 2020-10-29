import 'package:bloc/bloc.dart';

class SimpleObserver extends BlocObserver {
  // @override
  // void onChange(Cubit cubit, Change change) {
  //   print('${cubit.runtimeType} $change');
  //   super.onChange(cubit, change);
  // }

  /*
    Since all Blocs are Cubits, onChange and onError can be overridden in a Bloc as well.

In addition, Blocs can also override onEvent and onTransition.

onEvent is called any time a new event is added to the Bloc.

onTransition is similar to onChange, however, it contains the event which triggered the state change in addition to the currentState and nextState.
  */

  @override
  void onEvent(Bloc bloc, Object event) {
    print(event);
    super.onEvent(bloc, event);
  }

  @override
  void onChange(Cubit cubit, Change change) {
    print(change);
    super.onChange(cubit, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    print('$error, $stackTrace');
    super.onError(cubit, error, stackTrace);
  }

  // @override
  // void onError(Bloc bloc, Object error, StackTrace stackTrace) {
  //   print(error);
  //   super.onError(bloc, error, stackTrace);
  // }

}
