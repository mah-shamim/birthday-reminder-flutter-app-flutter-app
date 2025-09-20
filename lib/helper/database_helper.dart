import 'package:birthday_reminder/helper/common_import.dart';

class DatabaseHelper {
  static const int version = 1;
  static const String dbName = "birth_day_data.db";
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    return openDatabase(join(await getDatabasesPath(), dbName), onCreate: (db, version) async {
      await db.execute('''
          CREATE TABLE BirthDayData(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT, 
          birthdate TEXT, 
          year TEXT,
          image BLOB,
          greetings TEXT,
          gender TEXT,
          anniversary TEXT
          )
          ''');

      await db.execute('''
        CREATE TABLE MyCard(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          image BLOB,
          greetings TEXT,
          uid INTEGER,
          fontString TEXT
        )
      ''');
      await db.execute('''
        CREATE TABLE Reminder(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          uid INTEGER,
          reminder TEXT,
          isActive INTEGER DEFAULT 0,
          reminderTime TEXT
        )
      ''');
    }, version: version);
  }

  Future<int> addBirthDayData(BirthDayListModel data) async {
    final db = await database;
    return await db.insert("BirthDayData", {
      'name': data.name,
      'birthdate': data.birthDate,
      'image': data.image,
      'year': data.year,
      'greetings': data.greetings,
      'gender': data.gender,
      'anniversary': data.anniversary
    });
  }

  Future<int> addMyCard(MyCardModel data) async {
    final db = await database;
    return await db.insert("MyCard", {
      'image': data.image,
      'greetings': data.greetings,
      'uid': data.uid,
      'fontString': data.fontString,
    });
  }

  Future<int> addReminder(ReminderModel data) async {
    final db = await database;
    return await db.insert("Reminder", {
      'uid': data.uid,
      'reminder': data.reminder,
      'isActive': data.isActive,
      'reminderTime': data.reminderTime,
    });
  }

  Future<int> updateBirthDayData(BirthDayListModel data) async {
    final db = await database;
    return await db.update(
        "BirthDayData",
        {
          'name': data.name,
          'birthdate': data.birthDate,
          'image': data.image,
          'year': data.year,
          'greetings': data.greetings,
          'gender': data.gender,
          'anniversary': data.anniversary,
        },
        where: 'id = ?',
        whereArgs: [data.id]);
  }

  Future<List<BirthDayListModel>> getBirthDayData() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('BirthDayData');
    return List.generate(maps.length, (i) {
      return BirthDayListModel(
        id: maps[i]['id'],
        name: maps[i]['name'],
        birthDate: maps[i]['birthdate'],
        image: maps[i]['image'],
        year: maps[i]['year'],
        greetings: maps[i]['greetings'],
        anniversary: maps[i]['anniversary'],
      );
    });
  }

  Future<List<MyCardModel>> getMyCard() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('MyCard');
    return List.generate(maps.length, (i) {
      return MyCardModel(
        id: maps[i]['id'],
        image: maps[i]['image'],
        greetings: maps[i]['greetings'],
        uid: maps[i]['uid'],
        fontString: maps[i]['fontString'],
      );
    });
  }

  Future<List<ReminderModel>> getAllReminder(int uid) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'Reminder', where: 'uid = ?', // SQL WHERE clause
      whereArgs: [uid],
    );
    return List.generate(maps.length, (i) {
      return ReminderModel(
        id: maps[i]['id'],
        uid: maps[i]['uid'],
        reminder: maps[i]['reminder'],
        isActive: maps[i]['isActive'],
        reminderTime: maps[i]['reminderTime'],
      );
    });
  }

  Future<List<ReminderModel>> getReminder() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('Reminder');
    return List.generate(maps.length, (i) {
      return ReminderModel(
        id: maps[i]['id'],
        uid: maps[i]['uid'],
        reminder: maps[i]['reminder'],
        isActive: maps[i]['isActive'],
        reminderTime: maps[i]['reminderTime'],
      );
    });
  }

  Future<int> deleteReminderData(String reminder) async {
    final db = await database;
    return await db.delete(
      'Reminder',
      where: 'reminder = ?',
      whereArgs: [reminder],
    );
  }

  Future<int> deleteRemindersData(int id) async {
    final db = await database;
    return await db.delete(
      'Reminder',
      where: 'uid = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAllReminderData() async {
    final db = await database;
    return await db.delete('Reminder');
  }

  Future<int> deleteBirthdayData() async {
    final db = await database;
    return await db.delete('BirthDayData');
  }

  Future<int> deleteBirthdaysData(int id) async {
    final db = await database;
    return await db.delete(
      'BirthDayData',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteCards() async {
    final db = await database;
    return await db.delete('MyCard');
  }
}
