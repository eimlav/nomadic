import 'package:nomadic/core/models/checklist_item.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBService {
  Future<Database> database;

  DBService() {
    _init();
  }

  Future<void> _init() async {
    var dbPath = await getDatabasesPath();

    await deleteDatabase(dbPath);

    this.database = openDatabase(
      join(dbPath, 'nomadic_database.db'),
      onCreate: (db, version) {
        return db.execute(
            "CREATE TABLE IF NOT EXISTS checklist_items(id INTEGER PRIMARY KEY, name TEXT, description TEXT, category TEXT, quantity INTEGER, photos TEXT);");
      },
      version: 1,
    );
  }

  Future<void> insertChecklistItem(ChecklistItem checklistItem) async {
    final Database db = await database;

    await db.insert(
      'checklist_items',
      checklistItem.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ChecklistItem>> getChecklistItems() async {
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query('checklist_items');

    return List.generate(maps.length, (i) {
      return ChecklistItem.fromJson(maps[i]);
    });
  }
}
