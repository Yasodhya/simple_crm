//import 'package:sqflite/sqflite.dart';
import 'database_helper.dart';
import '../models/note.dart';

class NoteService {
  final dbHelper = DatabaseHelper.instance;

  Future<int> addNote(Note note) async {
    final db = await dbHelper.database;
    return await db.insert('notes', note.toMap());
  }

  Future<List<Note>> getNotesByCustomer(int customerId) async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'notes',
      where: 'customerId = ?',
      whereArgs: [customerId],
      orderBy: 'date DESC',
    );
    return List.generate(maps.length, (i) => Note.fromMap(maps[i]));
  }

  Future<List<Note>> getAllNotes() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('notes', orderBy: 'date DESC');
    return List.generate(maps.length, (i) => Note.fromMap(maps[i]));
  }

  Future<int> updateNote(Note note) async {
    final db = await dbHelper.database;
    return await db.update(
      'notes',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> deleteNote(int id) async {
    final db = await dbHelper.database;
    return await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }
}
