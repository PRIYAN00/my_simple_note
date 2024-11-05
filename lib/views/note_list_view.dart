import 'package:flutter/material.dart';
import '../models/note.dart';
import '../controllers/note_controller.dart';
import 'note_detail_view.dart';
import 'note_edit_view.dart';

class NoteListView extends StatefulWidget {
  const NoteListView({super.key});

  @override
  _NoteListViewState createState() => _NoteListViewState();
}

class _NoteListViewState extends State<NoteListView> {
  final NoteController _noteController = NoteController();
  List<Note> _notes = [];

  @override
  void initState() {
    super.initState();
    _refreshNotes();
  }

  _refreshNotes() async {
    List<Note> notes = await _noteController.getAllNotes();
    setState(() {
      _notes = notes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Note App with Flutter'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: _notes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_notes[index].title),
            subtitle: Text(
              _notes[index].content,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NoteDetailView(note: _notes[index]),
                ),
              ).then((_) => _refreshNotes());
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NoteEditView(),
            ),
          ).then((_) => _refreshNotes());
        },
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        tooltip: 'Add a new note',        
        child: const Icon(
          Icons.note_add,
          size: 30,
          ), 
      ),
    );
  }
}