import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/student_model.dart';

class LocalDatabase {
  static final LocalDatabase getInstance = LocalDatabase._init();

  LocalDatabase._init();

  factory LocalDatabase() {
    return getInstance;
  }

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDB("studentss.db");
      return _database!;
    }
  }

  Future<Database> _initDB(String dbName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const textType = "TEXT NOT NULL";

    await db.execute('''
    CREATE TABLE ${StudentModelFields.tableName} (
    ${StudentModelFields.id} $idType,
    ${StudentModelFields.image} $textType,
    ${StudentModelFields.course} $textType,
    ${StudentModelFields.description} $textType,
    ${StudentModelFields.firstName} $textType,
    ${StudentModelFields.lastName} $textType,
    ${StudentModelFields.university} $textType,
    ${StudentModelFields.group} $textType
    )
    ''');

    debugPrint("-------DB----------CREATED---------");
  }

  static Future<StudentModel> insertStudent(
      StudentModel addressModel) async {
    final db = await getInstance.database;
    final int id = await db.insert(
        StudentModelFields.tableName, addressModel.toJson());
    return addressModel.copyWith(id: id);
  }

  static Future<List<StudentModel>> getAllStudents() async {
    List<StudentModel> allStudents = [];
    final db = await getInstance.database;
    allStudents = (await db.query(StudentModelFields.tableName))
        .map((e) => StudentModel.fromJson(e))
        .toList();

    return allStudents;
  }

  static updateStudent({required StudentModel studentModel}) async {
    final db = await getInstance.database;
    print("Failed SQL");
    await db.update(StudentModelFields.tableName, studentModel.toJson(), where: '${StudentModelFields.id}=?', whereArgs: [studentModel.id]);
    print("Update SQL");
  }

  static Future<int> deleteStudent(int id) async {
    final db = await getInstance.database;
    int count = await db.delete(
      StudentModelFields.tableName,
      where: "${StudentModelFields.id} = ?",
      whereArgs: [id],
    );
    return count;
  }
}