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

  Future<int> insertChecklistItem(ChecklistItem checklistItem) async {
    final Database db = await database;

    return await db.insert(
      'checklist_items',
      checklistItem.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateChecklistItem(ChecklistItem checklistItem) async {
    final db = await database;

    var result = await db.update(
      'checklist_items',
      checklistItem.toJson(),
      where: "id = ?",
      whereArgs: [checklistItem.id],
    );
  }

  Future<void> deleteChecklistItem(int id) async {
    final db = await database;

    await db.delete(
      'checklist_items',
      where: "id = ?",
      whereArgs: [id],
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
