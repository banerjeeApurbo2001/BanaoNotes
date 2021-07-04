import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

class NavigationCubit extends Cubit<NavigationState> {

  NavigationCubit() : super(NavigationInitial());
  setNavigation(int index){
    emit(NavigationNavigate(navigationIndex: index));
  }

  void fetch() {

  }
}

@immutable
abstract class NavigationState {}

class NavigationInitial extends NavigationState {
  int navigationIndex = 0;
}
class NavigationNavigate extends NavigationState{
  int navigationIndex;
  NavigationNavigate({@required this.navigationIndex});
}