import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
class Databasehedler
{
  Database? db;
 Future<Database> create_db() async
  {
   if(db!=null)
     {
       return db!;
     }
   else
     {
       Directory dir = await getApplicationDocumentsDirectory();
       String dbpath = join(dir.path,"Expente_Manager");
       var db = await openDatabase(dbpath,version:1,onCreate: create_table);
       return db;
     }
  }
  create_table(Database db,int version)
  {
    db.execute("create table trans (tid integer primary key autoincrement,type text,category text,title text,remark text,amount double,tdate text)");
    print("Table Created");
  }
  Future<int> insertTracation(type,category,title,remark,amount,date) async
  {
   var db = await create_db();
   var id = await db.rawInsert("insert into trans (type,category,title,remark,amount,tdate)values (?,?,?,?,?,?)",[type,category,title,remark,amount,date]);
   return id;
  }
  Future<List>ViewTracation(type) async
  {
    var query="";
    if(type=="all")
      {
        query="select * from trans order by amount ASC";
      }
    else if(type=="income")
      {
        query="select * from trans where type='income'";
      }
    else
      {
        query="select * from trans where type='expense'";
      }
    var db = await create_db();
    var data = await db.rawQuery(query);
    return data.toList();

  }
  Future<int> deleteNote(id) async
  {
    var db = await create_db();
    var status = await db.rawDelete("delete from trans where tid=?",[id]);
    return status;
  }
  Future<List>getsinletracation(id) async
  {
    var db = await create_db();
    var data = await db.rawQuery("select * from trans where tid=?",[id]);
    return data.toList();

  }
  Future<int> updatenotes(type,category,title,remark,amount,date,updateid) async
  {
    var db = await create_db();
    var status =await db.rawUpdate("update trans set type=?,category=?,title=?,remark=?,amount=?,tdate=? where tid=?",[type,category,title,remark,amount,date,updateid]);
    return status;
  }

}