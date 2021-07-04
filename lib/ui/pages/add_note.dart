import 'package:flutter/material.dart';
import 'package:notekeeperatg/pojo_model/Note.dart';
import 'package:provider/provider.dart';

class AddNotePage extends StatefulWidget {
  final Note note;

  const AddNotePage({Key key, this.note}) : super(key: key);

  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  TextEditingController _titleController;
  TextEditingController _descriptionController;
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  FocusNode _descriptionNode;
  bool _editMode;
  bool _processing;

  @override
  void initState() {
    super.initState();
    _processing = false;
    _editMode = widget.note != null;
    _titleController =
        TextEditingController(text: _editMode ? widget.note.title : null);
    _descriptionController =
        TextEditingController(text: _editMode ? widget.note.description : null);
    _descriptionNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text('Add a note'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 15.0),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: "Title",
              ),
              textInputAction: TextInputAction.next,
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(_descriptionNode);
              },
            ),
            SizedBox(height: 30.0),
            TextField(
              controller: _descriptionController,
              focusNode: _descriptionNode,
              maxLines: 10,
              decoration: InputDecoration(
                labelText: "Description",
              ),
            ),
            const SizedBox(height: 20.0),
           Row(
             mainAxisAlignment: MainAxisAlignment.end,
             children: <Widget>[
               FloatingActionButton(

                    child: Icon(Icons.check),
                    onPressed: _processing
                        ? null
                        : () async {
                      setState(() {
                        _processing = true;
                      });
                      if (_titleController.text.isEmpty) {
                        _key.currentState.showSnackBar(SnackBar(
                          content: Text("Title is required."),
                          backgroundColor: Colors.red,
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
          ],
        ),
      ),

    );
  }
}
