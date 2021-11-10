import 'package:farmer_app/model/entities/moor/Mrfarmers.dart';
import 'package:farmer_app/model/entities/moor/Mrfarms.dart';
import 'package:farmer_app/model/entities/moor/dao/MrfarmDao.dart';
import 'package:farmer_app/model/entities/moor/dao/MrfarmerDao.dart';
import 'package:moor/moor.dart';
import 'package:moor/ffi.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as fpath;
import 'package:injectable/injectable.dart';
import 'package:moor/isolate.dart';
import 'dart:isolate';

part 'AppDatabase.g.dart';

@UseMoor(tables: [
  Mrfarmers,
  Mrfarms,
], daos: [
  MrfarmerDao,
  MrfarmDao,
])

class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.connect(DatabaseConnection connection)
      : super.connect(connection);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(onUpgrade: (
        Migrator m,
        int from,
        int to,
      ) async {
        if (from == 1 && to == 2) {}
      }, beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
      });

  Future<void> deleteAllDatabaseData() async {
    await customStatement('PRAGMA foreign_keys = OFF');
    return transaction(() async {
      for (var table in allTables) {
        await delete(table).go();
      }
    });
  }

  Future<void> disableForeignKeys() async {
    await customStatement('PRAGMA foreign_keys = OFF');
  }

  Future<void> enableForeignKeys() async {
    await customStatement('PRAGMA foreign_keys = ON');
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(fpath.join(dbFolder.path, 'frmdb.sqlite'));
    return VmDatabase(file, logStatements: true);
  });
}


Future<AppDatabase>getAppDatabaseFromIsolate() async {
  MoorIsolate moorIsolate = await _createMoorIsolate();
  DatabaseConnection dbConnection = await moorIsolate.connect();
  AppDatabase database = AppDatabase.connect(dbConnection);
  return database;
}

Future<MoorIsolate> _createMoorIsolate() async {
  final dir = await getApplicationDocumentsDirectory();
  final path = fpath.join(dir.path, 'frmdb.sqlite');
  final receivePort = ReceivePort();

  return (await receivePort.first as MoorIsolate);
}