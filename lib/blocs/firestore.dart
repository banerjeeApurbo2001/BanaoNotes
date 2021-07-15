import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:notekeeperatg/data_provider/DatabaseService.dart';
import 'package:notekeeperatg/data_provider/InternetService.dart';
import 'package:notekeeperatg/pojo_model/Note.dart';
import 'package:notekeeperatg/repository/FirebaseRepository.dart';

class Data extends Cubit<FirestoreDataState> {
  FirebaseRepository repository;
  Data({@required this.repository}) : super(FirestoreDataInitial());

  void fetchNotDeletedCollections() {
    emit(FirestoreDataLoading());
    InternetService().checkConnected().then((value)=>{
      if(value)
        repository.fetchNotDeletedCollections().then((notes)=>emit(FirestoreDataLoaded(notes)))
      else{
        print("finding cache"),
        DatabaseService.instance.fetchNotDeleted().then((value) => emit(FirestoreDataLoaded(value)))
      }
    });
  }

  void fetchDeletedCollections() {
    emit(FirestoreDeletedDataLoading());
    InternetService().checkConnected().then((value)=>{
      if(value)
        repository.fetchDeletedCollections().then((notes) => emit(FirestoreDataDeletedLoaded(notes)))
      else{
        print("finding cache"),
        DatabaseService.instance.fetchDeleted().then((value) => emit(FirestoreDataDeletedLoaded(value)))
      }
    });
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
