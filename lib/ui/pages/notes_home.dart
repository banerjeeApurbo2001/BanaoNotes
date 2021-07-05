import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notekeeperatg/blocs/bottom_navigationbar_tabs.dart';
import 'package:notekeeperatg/ui/pages/note_details.dart';
import 'package:provider/provider.dart';

import 'add_note.dart';
import 'deleted_notes.dart';
import 'notes.dart';

class NotesHomPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Banao Notes"),),
      body: BlocBuilder<NavigationCubit,NavigationState>(
          builder:(_,state){
            if(state is NavigationInitial){
              return NoteList();
            }
            if(state is NavigationNavigate){
              var index = state.navigationIndex;
              if(index==0){
                return NoteList();
              } else if(index==1){
                return TrashScreen();
              }
            }
            return Text("Not Null");
          }
      ),
      bottomNavigationBar: _navbar(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: _fab(context),
    );
  }
}

Widget _navbar(context) {

  return BlocBuilder<NavigationCubit,NavigationState>(
      builder:(_,state){
        var idx = (state is NavigationInitial)?(state).navigationIndex:(state as NavigationNavigate).navigationIndex;

        return BottomNavigationBar(items: [
          BottomNavigationBarItem(icon: Icon(Icons.note),title: Text("My Notes"),activeIcon: Icon(Icons.note)),
          BottomNavigationBarItem(icon: Icon(Icons.delete_outline,),title: Text("Bin"),activeIcon: Icon(Icons.delete)),
        ],
          currentIndex: idx,
          onTap:(index){
            BlocProvider.of<NavigationCubit>(context).setNavigation(index);
          },
        );
      }
  );
}


Widget _fab(context) {
  return FloatingActionButton(onPressed: (){
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddNotePage())).then((value) => (context as Element).markNeedsBuild());
  },child: Icon(Icons.add),);
}

