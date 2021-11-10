import 'package:farmer_app/model/entities/moor/Mrfarmers.dart';
import 'package:farmer_app/model/entities/moor/setup/AppDatabase.dart';
import 'package:moor/moor.dart';

part 'MrfarmerDao.g.dart';

@UseDao(tables: [Mrfarmers])
class MrfarmerDao extends DatabaseAccessor<AppDatabase>
    with _$MrfarmerDaoMixin {
  final AppDatabase db;
  final String TAG = 'MrfarmerDao:';

  MrfarmerDao(this.db) : super(db);

  Future<List<Mrfarmer>> getAllMrfarmers() => select(mrfarmers).get();
  Stream<List<Mrfarmer>> watchAllMrfarmers() => select(mrfarmers).watch();
  Future insertMrfarmer(Mrfarmer mrfarmer) => into(mrfarmers).insert(mrfarmer);
  Future<int> insertMrfarmersCompanion(MrfarmersCompanion mrfarmer) =>
      into(mrfarmers).insert(mrfarmer);
  Future<bool> updateMrfarmer(Mrfarmer mrfarmer) =>
      update(mrfarmers).replace(mrfarmer);
  Future deleteMrfarmer(Mrfarmer mrfarmer) =>
      delete(mrfarmers).delete(mrfarmer);

  Stream<List<Mrfarmer>> getMrfarmerStream() {
    var query = select(mrfarmers);
    return query.watch();
  }

  Future<bool> updateInsertableMrfarmer(Insertable<Mrfarmer> onlineuserdata) =>
      update(mrfarmers).replace(onlineuserdata);

  Future<Mrfarmer?> getMrfarmerById(int id) {
    String TAG = 'getSubOnlineuserId:';
    return (select(mrfarmers)..where((t) => t.id.equals(id))).get().then(
        (List<Mrfarmer> onlineuserdataList) {
      if (onlineuserdataList.length > 0) {
        return onlineuserdataList[0];
      } else {
        return null;
      }
    }, onError: (error) {
      print(TAG + 'error==');
      print(error.toString());
      return null;
    });
  }

  Future<Mrfarmer?> getMrfarmerByOnlineId(int? onlineid) {
    String TAG = 'getMrfarmerByOnlineId:';
    return (select(mrfarmers)..where((t) => t.onlineid.equals(onlineid)))
        .get()
        .then((List<Mrfarmer> onlineuserdataList) {
      if (onlineuserdataList.length > 0) {
        return onlineuserdataList[0];
      } else {
        return null;
      }
    }, onError: (error) {
      print(TAG + 'error==');
      print(error.toString());
      return null;
    });
  }

  Future insertAllMrfarmersCompanion(
      List<MrfarmersCompanion> onlineuserCompanionList) async {
    await batch((b) {
      b.insertAll(mrfarmers, onlineuserCompanionList);
    });
  }

  Future upsertAllMrfarmersByOnlineIdCompanion(
      List<MrfarmersCompanion> mrfarmersCompanionList) async {
    List<MrfarmersCompanion> upd = [];
    List<MrfarmersCompanion> ins = [];

    for (MrfarmersCompanion cin in mrfarmersCompanionList) {
      int? onlidval = cin.onlineid.value;
      Mrfarmer? mf;
      if (onlidval != null) {
        mf = await getMrfarmerById(onlidval);
      }
      if (mf != null) {
        upd.add(cin);
      } else {
        ins.add(cin);
      }
    }
    print(TAG + " upd=" + '${upd.length}');
    await updateAllMrfarmersCompanion(upd);
    print(TAG + " ins=" + '${ins.length}');
    await batch((b) {
      b.insertAll(mrfarmers, ins);
    });
    return true;
  }

  Future updateAllMrfarmersCompanion(
      List<MrfarmersCompanion> onlineuserCompanionList) async {
    return await batch((b) async {
      for (MrfarmersCompanion smc in onlineuserCompanionList) {
        await updateMrfarmersCompanion(smc);
      }
    });
  }

  Future<bool> updateMrfarmersCompanion(Insertable<Mrfarmer> company) {
    return update(mrfarmers).replace(company);
  }

  Future<List<Mrfarmer>> getMrfarmersByName(String name) {
    String TAG = 'getMrfarmersByName:';
    return (select(mrfarmers)
          ..where((t) =>
              t.first_name.like('%' + name + '%') |
              t.last_name.like('%' + name + '%') |
              t.gender.like('%' + name + '%') |
              t.member_number.like('%' + name + '%')))
        .get()
        .then((List<Mrfarmer> onlineuserdataList) {
      if (onlineuserdataList.length > 0) {
        return onlineuserdataList;
      } else {
        return [];
      }
    }, onError: (error) {
      return [];
    });
  }

  Future deleteAllMrfarmersFuture(List<Mrfarmer> onlineuserList) async {
    await batch((b) {
      for (Mrfarmer smc in onlineuserList) {
        deleteMrfarmerFuture(smc);
      }
    });
  }

  Future<int> deleteMrfarmerFuture(Mrfarmer mrfarmer) =>
      delete(mrfarmers).delete(mrfarmer);
}
