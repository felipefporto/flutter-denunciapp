import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class FormSubmissionDatabase {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    // If the database does not exist, create it.
    _database = await openDatabase(
      join(await getDatabasesPath(), 'form_submissions.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE form_submissions(id INTEGER PRIMARY KEY, data TEXT)',
        );
      },
      version: 1,
    );

    return _database!;
  }

  Future<void> insertFormSubmission(String formData) async {
    final db = await database;
    await db.insert(
      'form_submissions',
      {'data': formData},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<String>> getFormSubmissions() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('form_submissions');
    return List.generate(maps.length, (i) {
      return maps[i]['data'] as String;
    });
  }
}
