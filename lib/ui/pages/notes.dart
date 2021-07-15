import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notekeeperatg/blocs/firestore.dart';
import 'package:notekeeperatg/ui/widgets/note_item.dart';

class NoteList extends StatelessWidget {
  final BuildContext homeContext;
  NoteList({Key key,@required this.homeContext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<Data>(context).fetchNotDeletedCollections();
    return BlocBuilder<Data, FirestoreDataState>(
      builder: (_,state){
        if(state is FirestoreDataLoading){
          return Center(child: CircularProgressIndicator(),);
        }
        if(state is FirestoreDataLoaded){
          return ListView.builder(
              itemCount: state.notes.length,
              itemBuilder: (_,index){
                return NoteItem(note: state.notes[index],homeContext: homeContext);
              }
          );
        }
        return Text("");
      },
    );
  }
}
