import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:qrscanner/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

export 'package:qrscanner/models/scan_model.dart';

class DBProvider{
   static Database? _database;
  static final DBProvider db = DBProvider._();
  DBProvider._();

  Future<Database> get database async => (
    _database ??= await initDB()
  );


  Future<Database>initDB() async{
    //Path para almacenar la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ScansDB.db');
    print('Path is!: '+path);

    //crear la base de datos
    return await openDatabase(path,
      version: 1,
      onOpen: (db){},
      onCreate: (Database db, int version )async{
        await db.execute('''
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY,
            tipo TEXT,
            valor TEXT
          )
        ''');
      }
    );
  }

    Future<int>nuevoScanRaw(ScanModel nuevoScan)async{
      final id =    nuevoScan.id;
      final tipo =  nuevoScan.tipo;
      final valor = nuevoScan.valor;
      //Validate Db
      final db = await database;

      final res = await db.rawInsert('''
      INSERT INTO Scans (id, tipo, valor)
        VALUES ($id,'$tipo','$valor')
      ''');
      return res;
    }

    Future<int>nuevoScan(ScanModel nuevoScan)async{
      final db = await database;
      final res = await db.insert('Scans', nuevoScan.toJson());
      print(res);
      //Este es el id del útlimo registro insertado
      return res;
    }

    Future<ScanModel>getScanById(int id)async{
      final db = await database;
      final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);
      /* El código original debe de ser así para validar que no valla vacío
      return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
      pero no puedo regresar nulos, así que esto debe de ser arreglado
      */
      return ScanModel.fromJson(res.first);

    }
    Future<List<ScanModel>>getScanAll()async{ //Regresa todos los scans
      final db = await database;
      final res = await db.query('Scans');

      return res.map((s) => ScanModel.fromJson(s)).toList();

    }
    Future<List<ScanModel>>getScanTipo( String tipo )async{ //Scanns por tipo
      final db = await database;
      final res = await db.rawQuery('''
        SELECT * FROM Scans WHERE tipo = '$tipo'
      ''');

      return res.map((s) => ScanModel.fromJson(s)).toList();

    }

    Future<int> updateScan(ScanModel nuevoScan)async{
      final db = await database;
      final res = await db.update('Scans', nuevoScan.toJson(), where:  'id=?', whereArgs: [nuevoScan.id]);
      return res;
    }

    Future<int> deleteScan(int id)async{
      final db = await database;
      final res = await db.delete('Scans',where: 'id=?',whereArgs: [id]);
      return res;
    }
    Future<int> deleteAllScan()async{
      final db = await database;
      final res = await db.delete('Scans');
      return res;
    }
}