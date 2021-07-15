

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notekeeperatg/blocs/firestore.dart';
import 'package:notekeeperatg/ui/widgets/note_item.dart';

class TrashScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<Data>(context).fetchDeletedCollections();
    return BlocBuilder<Data, FirestoreDataState>(
      builder: (_,state){
        if(state is FirestoreDeletedDataLoading){
          return Center(child: CircularProgressIndicator(),);
        }
        if(state is FirestoreDataDeletedLoaded){
          return ListView.builder(
              itemCount: state.notes.length,
              itemBuilder: (_,index){
                return NoteItem(note: state.notes[index],homeContext: context,);
              }
          );
        }
        return Text("");
      },
    );
  }
}
