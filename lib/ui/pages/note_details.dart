import 'package:flutter/material.dart';
import 'package:notekeeperatg/pojo_model/Note.dart';


class NoteDetailsPage extends StatefulWidget {
  final Note note;


  const NoteDetailsPage({Key key, @required this.note}) : super(key: key);

  @override
  _NoteDetailsPageState createState() => _NoteDetailsPageState();
}

class _NoteDetailsPageState extends State<NoteDetailsPage> {
  var _processing;

  var _titleController;

  var _editMode;

  var _descriptionController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.note.title,
            ),
            const SizedBox(height: 10.0),
            Text(
              widget.note.description,
            ),
            FloatingActionButton(

                child: _processing ? CircularProgressIndicator() : Icon(Icons.check),
                onPressed: _processing
                    ? null
                    : () async {
                  setState(() {
                    _processing = true;
                  });
                  if (_titleController.text.isEmpty) {
                    _key.currentState.showSnackBar(SnackBar(
                      content: Text("Title is required."),
                    ));
                    return;
                  }
                  Note note = Note(
                    id: _editMode ? widget.note.id : null,
                    title: _titleController.text,
                    description: _descriptionController.text,
                    createdAt: DateTime.now(),
                  );
                  setState(() {
                    _processing = false;
                  });
                  Navigator.pop(context);
                }
            ),
          ],
        ),
      ),
    );
  }
}
