import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:notekeeperatg/repository/FirebaseRepository.dart';

//part 'add_data_firestore_state.dart';

class Add extends Cubit<AddDataFirestoreState> {
  FirebaseRepository repository;
  Add({@required this.repository}) : super(AddDataFirestoreInitial(false));

  void addData(String title, String note, String url) {
     print(url);
    emit(AddDataFirestoreAdding());
    repository.addData(title,note,url).then((value) => emit(AddDataFirestoreAdded(status: value)));
  }

  void setCheckStateChange(bool checkState){
    print(checkState);
    emit(AddDataFirestoreInitial(checkState));
  }
}

@immutable
abstract class AddDataFirestoreState {}

class AddDataFirestoreInitial extends AddDataFirestoreState {
  final bool checkedState;
  AddDataFirestoreInitial(this.checkedState);
}
class AddDataFirestoreAdding extends AddDataFirestoreState {}
class AddDataFirestoreAdded extends AddDataFirestoreState {
  final bool status;
  AddDataFirestoreAdded({@required this.status});
}

class AddDataFirestoreVideoState extends AddDataFirestoreState{
  final bool checkedState;
  AddDataFirestoreVideoState(this.checkedState);
}
