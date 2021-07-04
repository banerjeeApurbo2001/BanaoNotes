import 'package:flutter/material.dart';
import 'package:notekeeperatg/pojo_model/Note.dart';
import 'package:notekeeperatg/ui/widgets/dialog._box.dart';

class NoteItem extends StatelessWidget {
  final Note note;
  final Function(Note) onEdit;
  final Function(Note) onDelete;
  final Function(Note) onTap;

  const NoteItem({
    Key key,
    @required this.note,
    @required this.onEdit,
    @required this.onDelete,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(color: Colors.white),
      child: Card(
        child: InkWell(
          splashColor: Colors.indigoAccent,
          child: ListTile(
            title: Text(note.title),
            subtitle: Text(note.description,overflow: TextOverflow.ellipsis, maxLines: 2),
            onLongPress: (){},
          ),
        ),
      ),
    );
  }
}
