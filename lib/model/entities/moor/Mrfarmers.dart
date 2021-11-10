import 'package:moor/moor.dart';

class Mrfarmers extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get onlineid => integer().nullable()();
  TextColumn get first_name => text().nullable()();
  TextColumn get last_name => text().nullable()();
  TextColumn get member_number => text().nullable()();
  TextColumn get gender => text().nullable()();
  TextColumn get phone_number => text().nullable()();
  TextColumn get email => text().nullable()();
  BoolColumn get issettobeupdated => boolean().withDefault(Constant(false))();
  BoolColumn get deleted => boolean().withDefault(Constant(false))();
}
