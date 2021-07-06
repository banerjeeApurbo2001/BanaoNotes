import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notekeeperatg/blocs/delete_data.dart';
import 'package:notekeeperatg/blocs/firestore.dart';
import 'package:notekeeperatg/data_provider/FirebaseService.dart';
import 'package:notekeeperatg/pojo_model/Note.dart';
import 'package:notekeeperatg/repository/FirebaseRepository.dart';
import 'package:notekeeperatg/ui/widgets/note_item.dart';

class NoteDetailsPage extends StatelessWidget {
  Note note;
  NoteDetailsPage({Key key, @required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Delete(repository: FirebaseRepository(service: FirebaseService(init: "ViewNote"))),
      child: BlocBuilder<Delete, DeleteDataFirestoreState>(
        builder: (context, state) {
          if(state is DeleteDataFirestoreInitial) {
            return Scaffold(
              appBar: AppBar(title: Text(note.title??""),),
              body: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0,15,16,20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text("Last Updated @ ${note.createdAt.toDate().toString()}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.blueGrey),),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16,25,16,25),
                      child: Text(note.description??'', style: TextStyle(fontSize: 20.0),),
                    ),
                  ],
                ),
              ),
              floatingActionButton: (!note.deleted)?FloatingActionButton(onPressed: () {
                BlocProvider.of<Delete>(context).delete(note.id);
              },
                child: Icon(Icons.delete),

              ):Container(),
            );
          }
          if(state is DeleteDataFirestoreDeleting)
            return Scaffold(
              appBar: AppBar(
              ),
              body: Center(
                child: Text("Deleted"),
              ),
            );
          if(state is DeleteDataFirestoreDeleted){
            if(state.status){
              return Scaffold(
                appBar: AppBar(),
                body: Center(child: Text("Deleted"),),
                );
            }
            else{
              return Scaffold(body:Center(child: Text("Deletion Aborted!!"),));
            }
          }
          return Text("Delete Screen");
        },
      ),
    );
  }
}

