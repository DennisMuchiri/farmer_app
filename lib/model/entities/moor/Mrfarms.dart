import 'package:moor/moor.dart';

class Mrfarms extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get onlineid => integer().nullable()();
  TextColumn get farm_name => text().nullable()();
  TextColumn get farm_size => text().nullable()();
  IntColumn get farmer_online_id =>
      integer().nullable()();
  IntColumn get farmer =>
      integer().nullable().customConstraint('NULL REFERENCES mrfarmers(id)')();
  BoolColumn get issettobeupdated => boolean().withDefault(Constant(false))();
  BoolColumn get deleted => boolean().withDefault(Constant(false))();
}
