 import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

class SQLHelper{

  static Future<void> createTable(Database database)async{
    await database.execute("""CREATE TABLE frindbook(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    name TEXT,
    age TEXT,
    gender TEXT,
    bod TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP )
""");
  }

  static Future<sql.Database> db()async{
    return sql.openDatabase(
      'friends.db',
      version: 1,
      onCreate: (sql.Database database,int version){
        createTable(database);
      }
    );
  }

  static Future<int> createdItem(String name,String age,String gender)async{
    final db  = await SQLHelper.db();

    final data = {'name':name,'age':age,'gender':gender};
    final id = db.insert('frindbook', data,conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String,dynamic>>> getItems()async{
    final db = await SQLHelper.db();
 return db.query('frindbook',orderBy: 'id');
}

  static Future<List<Map<String,dynamic>>> getItem(int id)async{
    final db = await SQLHelper.db();
   final result =  await db.query('frindbook',where: 'id = ?',whereArgs: [id],limit: 1);
    return result;
  }

  static Future<int> updateItems(int id,String name,String age,String gender)async{
      final db  = await SQLHelper.db();

      final data = {'name':name,'age':age,'gender':gender,'bod' : DateTime.now().toString()};
      final result = db.update('frindbook', data,where: 'id = ?' ,whereArgs: [id]);
      return result;
    }

    static Future<void> deleteItem(int id)async{
    final db = await  SQLHelper.db();
    try{
      await db.delete('frindbook',where: 'id = ?' ,whereArgs: [id]);
    }catch(e){}
    }


}