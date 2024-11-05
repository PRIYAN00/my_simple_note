import '../models/note.dart';
import '../database/database_helper.dart';

class NoteController {
  final dbHelper = DatabaseHelper.instance;

  Future<Note> createNote(String title, String content) async {
    final note = Note(
      title: title,
      content: content,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    return await dbHelper.create(note);
  }

  Future<Note> getNote(int id) async {
    return await dbHelper.readNote(id);
  }

  Future<List<Note>> getAllNotes() async {
    return await dbHelper.readAllNotes();
  }

  Future<int> updateNote(Note note) async {
    return await dbHelper.update(note);
  }

  Future<int> deleteNote(int id) async {
    return await dbHelper.delete(id);
  }
}