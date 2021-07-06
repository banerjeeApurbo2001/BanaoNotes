import 'package:flutter/material.dart';
import 'package:notekeeperatg/pojo_model/Note.dart';
import 'package:notekeeperatg/ui/pages/note_details.dart';
import 'package:notekeeperatg/ui/widgets/dialog._box.dart';

class NoteItem extends StatelessWidget {
  Note note;

  NoteItem({
    Key key,
    @required this.note,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(color: Colors.white),
      child: Card(
        shadowColor: Colors.black,
        child: InkWell(
          splashColor: Colors.black,
          hoverColor: Colors.blue,
          child: ListTile(
            title: Text(note.title??''),
            subtitle: Text(note.description??'',overflow: TextOverflow.ellipsis, maxLines: 2),
            onLongPress: (){},
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context)=>NoteDetailsPage(
                    note: note,))).then((value) => (context as Element).markNeedsBuild());
            },
          ),
        ),
      ),
    );
  }
}
