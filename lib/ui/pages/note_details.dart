import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notekeeperatg/blocs/delete_data.dart';
import 'package:notekeeperatg/blocs/firestore.dart';
import 'package:notekeeperatg/data_provider/FirebaseService.dart';
import 'package:notekeeperatg/data_provider/InternetService.dart';
import 'package:notekeeperatg/pojo_model/Note.dart';
import 'package:notekeeperatg/repository/FirebaseRepository.dart';
import 'package:notekeeperatg/ui/widgets/dialog._box.dart';
import 'package:notekeeperatg/ui/widgets/note_item.dart';

import 'VideoPlayerScreen.dart';

class NoteDetailsPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
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
              key: scaffoldKey,
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
                    SizedBox(height: 30.0,),
                    (note.url != null && note.url.length>0)?Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16,0,16,0),
                          child: Container(child: Text("This note contains a video link !!",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blueAccent),)),
                        ),
                        RaisedButton(onPressed: (){
                          InternetService().checkConnected().then((value)=>{
                            if(value)
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>VideoPlayerScreen(url: note.url.toString(),)))
                            else
                              scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("You are Not Connected !! \nPlease connect to the internet and try again"), backgroundColor: Colors.red,))
                          });
                        }, child: Text("Open Video")),
                      ],
                    ):Container(child: Text("No Video Link added !!",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blueAccent),),),


                  ],
                ),
              ),
              floatingActionButton: (!note.deleted)?FloatingActionButton(onPressed: () {
                InternetService().checkConnected().then((value) => {
                  if(value)
                    BlocProvider.of<Delete>(context).delete(note.id)
                  else{
                    scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("You are Not Connected !! \nPlease connect to the internet and try again"), backgroundColor: Colors.red,))
                  }
                });
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

