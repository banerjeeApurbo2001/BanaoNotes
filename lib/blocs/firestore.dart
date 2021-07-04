import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:notekeeperatg/pojo_model/Note.dart';
import 'package:notekeeperatg/repository/FirebaseRepository.dart';

class Data extends Cubit<FirestoreDataState> {
  FirebaseRepository repository;
  Data({@required this.repository}) : super(FirestoreDataInitial());

  void fetchNotDeletedCollections() {
    emit(FirestoreDataLoading());
    repository.fetchNotDeletedCollections().then((notes)=>emit(FirestoreDataLoaded(notes)));
  }

  void fetchDeletedCollections() {
    emit(FirestoreDeletedDataLoading());
    repository.fetchDeletedCollections().then((notes) => emit(FirestoreDataDeletedLoaded(notes)));
  }
}

@immutable
abstract class FirestoreDataState {}

class FirestoreDataInitial extends FirestoreDataState {}
class FirestoreDataLoading extends FirestoreDataState{}
class FirestoreDeletedDataLoading extends FirestoreDataState{}
class FirestoreDataLoaded extends FirestoreDataState{
  final List<Note> notes;
  FirestoreDataLoaded(this.notes);
}

class FirestoreDataDeletedLoaded extends FirestoreDataState{
  final List<Note> notes;
  FirestoreDataDeletedLoaded(this.notes);
}

class FirestoreDataError extends FirestoreDataState{
}