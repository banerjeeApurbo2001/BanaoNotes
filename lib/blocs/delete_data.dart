import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:notekeeperatg/repository/FirebaseRepository.dart';

//part 'delete_data_firestore_state.dart';

class Delete extends Cubit<DeleteDataFirestoreState> {
  FirebaseRepository repository;
  Delete({@required this.repository}) : super(DeleteDataFirestoreInitial());

  void delete(String id) {
    emit(DeleteDataFirestoreDeleting());
    repository.markTrashed(id).then((value) => emit(DeleteDataFirestoreDeleted(status: value)));
  }
}

@immutable
abstract class DeleteDataFirestoreState {}

class DeleteDataFirestoreInitial extends DeleteDataFirestoreState {}
class DeleteDataFirestoreDeleting extends DeleteDataFirestoreState {}
class DeleteDataFirestoreDeleted extends DeleteDataFirestoreState {
  final bool status;

  DeleteDataFirestoreDeleted({@required this.status});
}
