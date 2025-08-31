import 'package:flutter/material.dart';
import '../models/note.dart';
import '../db/note_service.dart';

class NoteProvider with ChangeNotifier {
  final NoteService _service = NoteService();

  List<Note> _notes = [];
  List<Note> get notes => _notes;

  Future<void> loadNotesByCustomer(int customerId) async {
    _notes = await _service.getNotesByCustomer(customerId);
    notifyListeners();
  }

  Future<void> loadAllNotes() async {
    _notes = await _service.getAllNotes();
    notifyListeners();
  }

  Future<void> addNote(Note note) async {
    await _service.addNote(note);
    await loadNotesByCustomer(note.customerId);
  }

  Future<void> deleteNote(int id, int customerId) async {
    await _service.deleteNote(id);
    await loadNotesByCustomer(customerId);
  }
}

