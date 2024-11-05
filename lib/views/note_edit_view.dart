import 'package:flutter/material.dart';
import '../models/note.dart';
import '../controllers/note_controller.dart';

class NoteEditView extends StatefulWidget {
  final Note? note;

  NoteEditView({this.note});

  @override
  _NoteEditViewState createState() => _NoteEditViewState();
}

class _NoteEditViewState extends State<NoteEditView> {
  final NoteController _noteController = NoteController();
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note?.title ?? '');
    _contentController = TextEditingController(text: widget.note?.content ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? 'New Note' : 'Edit Note'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveNote,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              Expanded(
                child: TextFormField(
                  controller: _contentController,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    labelText: 'Content',
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some content';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveNote() async {
    if (_formKey.currentState!.validate()) {
      if (widget.note == null) {
        await _noteController.createNote(
          _titleController.text,
          _contentController.text,
        );
      } else {
        await _noteController.updateNote(
          Note(
            id: widget.note!.id,
            title: _titleController.text,
            content: _contentController.text,
            createdAt: widget.note!.createdAt,
            updatedAt: DateTime.now(),
          ),
        );
      }
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }
}