import 'package:nomadic/core/models/checklist_item.dart';
import 'package:nomadic/core/models/exchange_rate.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBService {
  Future<Database> database;

  DBService() {
    _init();
  }

  Future<void> _init() async {
    print('INIT');
    var dbPath = await getDatabasesPath();

    await deleteDatabase(dbPath);

    this.database = openDatabase(
      join(dbPath, 'nomadic_database.db'),
      onCreate: (db, version) async {
        print('STARTING BATCH');
        var batch = db.batch();
        batch.execute(
            "CREATE TABLE IF NOT EXISTS checklist_items(id INTEGER PRIMARY KEY, name TEXT, description TEXT, category TEXT, quantity INTEGER, photos TEXT)");
        batch.execute(
            "CREATE TABLE IF NOT EXISTS exchange_rates(base_currency TEXT, exchange_currency TEXT, rate REAL, updated_at TEXT)");
        return await batch.commit(noResult: true);
        // return db.execute(
        //     "CREATE TABLE IF NOT EXISTS checklist_items(id INTEGER PRIMARY KEY, name TEXT, description TEXT, category TEXT, quantity INTEGER, photos TEXT);CREATE TABLE IF NOT EXISTS exchange_rates(base_currency TEXT, exchange_currency TEXT, rate REAL, updated_at TEXT)");
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

    final List<Map<String, dynamic>> maps =
        await db.query('checklist_items', orderBy: 'name ASC');

    return List.generate(maps.length, (i) {
      return ChecklistItem.fromJson(maps[i]);
    });
  }

  Future<List<ChecklistItem>> getChecklistItemsFiltered(
      String column, List<dynamic> values) async {
    final Database db = await database;

    values = values.map((value) => "'$value'").toList();
    final List<Map<String, dynamic>> maps = await db.query('checklist_items',
        where: "$column in (${values.join(',')})", orderBy: 'name ASC');

    return List.generate(maps.length, (i) {
      return ChecklistItem.fromJson(maps[i]);
    });
  }

  Future<List<ExchangeRate>> getExchangeRates() async {
    final Database db = await database;

    final List<Map<String, dynamic>> maps =
        await db.query('exchange_rates', orderBy: 'exchange_currency ASC');

    return List.generate(maps.length, (i) {
      return ExchangeRate.fromJson(maps[i]);
    });
  }

  Future<int> insertExchangeRate(ExchangeRate exchangeRate) async {
    final Database db = await database;

    return await db.insert(
      'exchange_rates',
      exchangeRate.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateExchangeRate(ExchangeRate exchangeRate) async {
    final db = await database;

    await db.update(
      'exchange_rates',
      exchangeRate.toJson(),
      where: "base_currency = ? AND exchange_currency = ?",
      whereArgs: [exchangeRate.baseCurrency, exchangeRate.exchangeCurrency],
    );
  }

  Future<void> deleteExchangeRate(String baseCurrency, exchangeCurrency) async {
    final db = await database;

    await db.delete(
      'exchange_rates',
      where: "base_currency = ? AND exchange_currency",
      whereArgs: [baseCurrency, exchangeCurrency],
    );
  }
}
