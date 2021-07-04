import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:notekeeperatg/repository/FirebaseRepository.dart';

//part 'add_data_firestore_state.dart';

class Add extends Cubit<AddDataFirestoreState> {
  FirebaseRepository repository;
  Add({@required this.repository}) : super(AddDataFirestoreInitial());

  void addData(String title, String note) {
    emit(AddDataFirestoreAdding());
    repository.addData(title,note).then((value) => emit(AddDataFirestoreAdded(status: value)));
  }
}

@immutable
abstract class AddDataFirestoreState {}

class AddDataFirestoreInitial extends AddDataFirestoreState {}
class AddDataFirestoreAdding extends AddDataFirestoreState {}
class AddDataFirestoreAdded extends AddDataFirestoreState {
  final bool status;
  AddDataFirestoreAdded({@required this.status});
}