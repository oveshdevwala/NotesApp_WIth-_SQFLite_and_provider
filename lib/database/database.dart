import 'package:notes_app_with_database_and_provider/database/model/notesmodel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class MyDatabase {
// Variables
  static String dbName = 'notesDb.db';
  static String dbtable = 'notes';
  static int dbVersion = 1;
  //column
  static String colTitle = 'title';
  static String colDiscrption = 'discrption';
  static String colId = 'id';
  static String colDate = 'date';

//constructor
  MyDatabase._();
  static MyDatabase instance = MyDatabase._();
  Database? db;
//get database

  Future<Database> getDb() async {
    db ??= await inilDb();
    return db!;
  }
//initialize Database

  Future<Database> inilDb() async {
    var docDirectory = await getApplicationDocumentsDirectory();
    var path = join(docDirectory.path, dbName);
    return await openDatabase(path, version: dbVersion, onCreate: _oncreate);
  }

  _oncreate(Database db, int version) {
    var autoIncrimentType = 'integer primary key autoincrement not null';
    var stringType = 'text not null';
    // var intType = 'integer not null';
    db.execute('''
CREATE TABLE $dbtable (
  $colId $autoIncrimentType,
  $colDate $stringType,
  $colTitle $stringType,
  $colDiscrption $stringType
  )
''');
  }

//createNotes
  void createNotes(NotesModel notesModel) async {
    var db = await MyDatabase.instance.getDb();
    await db.insert(MyDatabase.dbtable, notesModel.toMap());
  }

//Facth Data
  Future<List<NotesModel>> facthData() async {
    var db = await MyDatabase.instance.getDb();
    List<NotesModel> arryData = [];
    var data = await db.query(MyDatabase.dbtable);
    for (Map<String, dynamic> eachData in data) {
      var notemodel = NotesModel.fromMap(eachData);
      arryData.add(notemodel);
    }
    return arryData;
  }

// Update Notes
  void updateNotes(NotesModel notesModel) async {
    var db = await MyDatabase.instance.getDb();
    db.update(MyDatabase.dbtable, notesModel.toMap(),
        where: '${MyDatabase.colId} = ?',
        whereArgs: [' ${notesModel.modelId}']);
  }

//deleteNotes
  void deleteNotes(int id) async {
    var db = await MyDatabase.instance.getDb();
    db.delete(MyDatabase.dbtable, where: "${colId} = ?", whereArgs: ['${id}']);
  }
}
