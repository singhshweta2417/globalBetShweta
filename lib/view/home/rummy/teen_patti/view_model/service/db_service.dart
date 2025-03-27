// import 'dart:convert';
//
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
// import 'package:teen_patti/model/user_model.dart';
//
// class DatabaseService {
//   static Database? _database;
//
//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await initDB();
//     return _database!;
//   }
//
//   Future<Database> initDB() async {
//     final path = join(await getDatabasesPath(), 'users.db');
//     return await openDatabase(
//       path,
//       version: 2,
//       onCreate: (db, version) async {
//         await db.execute(
//           'CREATE TABLE users (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT)',
//         );
//         await db.execute(
//           'CREATE TABLE game_history (id INTEGER PRIMARY KEY AUTOINCREMENT, data TEXT, timestamp TEXT)',
//         );
//       },
//       onUpgrade: (db, oldVersion, newVersion) async {
//         if (oldVersion < 2) {
//           await db.execute(
//             'CREATE TABLE game_history (id INTEGER PRIMARY KEY AUTOINCREMENT, data TEXT, timestamp TEXT)',
//           );
//         }
//       },
//     );
//   }
//
//   Future<int> insertUser(UserModel user) async {
//     final db = await database;
//     return await db.insert('users', user.toMap(),
//         conflictAlgorithm: ConflictAlgorithm.replace);
//   }
//
//   Future<UserModel?> getUserByName(String name) async {
//     final db = await database;
//     final List<Map<String, dynamic>> maps = await db.query(
//       'users',
//       where: 'name = ?',
//       whereArgs: [name],
//     );
//
//     if (maps.isNotEmpty) {
//       return UserModel.fromMap(maps.first);
//     }
//     return null;
//   }
//
//   Future<int> insertGameHistory(Map<String, dynamic> gameData) async {
//     final db = await database;
//     String jsonData = jsonEncode(gameData);
//     return await db.insert(
//       'game_history',
//       {'data': jsonData, 'timestamp': DateTime.now().toIso8601String()},
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }
//
//   Future<List<Map<String, dynamic>>> getGameHistory() async {
//     final db = await database;
//     final List<Map<String, dynamic>> maps = await db.query(
//       'game_history',
//       orderBy: 'timestamp DESC',
//     );
//     print(maps);
//     return maps.map((map) {
//       return {
//         'id': map['id'],
//         'data': jsonDecode(map['data']),
//         'timestamp': map['timestamp'],
//       };
//     }).toList();
//   }
//
//   Future<void> clearGameHistory() async {
//     final db = await database;
//     await db.delete('game_history');
//   }
// }

