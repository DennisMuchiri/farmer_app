import 'package:farmer_app/model/entities/moor/Mrfarmers.dart';
import 'package:farmer_app/model/entities/moor/Mrfarms.dart';
import 'package:farmer_app/model/entities/moor/setup/AppDatabase.dart';
import 'package:moor/moor.dart';

part 'MrfarmDao.g.dart';

@UseDao(tables: [Mrfarms, Mrfarmers])
class MrfarmDao extends DatabaseAccessor<AppDatabase> with _$MrfarmDaoMixin {
  final AppDatabase db;
  final String TAG = 'MrfarmDao:';

  MrfarmDao(this.db) : super(db);

  Future insertMrfarm(Mrfarm mrfarm) => into(mrfarms).insert(mrfarm);
  Future<int> insertMrfarmsCompanion(MrfarmsCompanion mrfarm) =>
      into(mrfarms).insert(mrfarm);
  Future<bool> updateMrfarm(Mrfarm mrfarm) => update(mrfarms).replace(mrfarm);
  Future deleteMrfarm(Mrfarm mrfarm) => delete(mrfarms).delete(mrfarm);

  Stream<List<Mrfarm>> getMrfarmStream() {
    var query = select(mrfarms);
    return query.watch();
  }

  Future<bool> updateInsertableMrfarm(Insertable<Mrfarm> onlineuserdata) =>
      update(mrfarms).replace(onlineuserdata);

  Future<Mrfarm?> getMrfarmById(int id) {
    String TAG = 'getSubOnlineuserId:';
    return (select(mrfarms)..where((t) => t.id.equals(id))).get().then(
        (List<Mrfarm> reslist) {
      if (reslist.length > 0) {
        return reslist[0];
      } else {
        return null;
      }
    }, onError: (error) {
      print(TAG + 'error==');
      print(error.toString());
      return null;
    });
  }

  Future<Mrfarm?> getMrfarmByFarmerId(int farmerid) {
    String TAG = 'getSubOnlineuserId:';
    return (select(mrfarms)..where((t) => t.farmer.equals(farmerid)))
        .get()
        .then((List<Mrfarm> reslist) {
      if (reslist.length > 0) {
        return reslist[0];
      } else {
        return null;
      }
    }, onError: (error) {
      print(TAG + 'error==');
      print(error.toString());
      return null;
    });
  }

  Future<Mrfarm?> getMrfarmByOnlineId(int onlineId) {
    String TAG = 'getMrfarmByOnlineId:';
    return (select(mrfarms)..where((t) => t.onlineid.equals(onlineId)))
        .get()
        .then((List<Mrfarm> reslist) {
      if (reslist.length > 0) {
        return reslist[0];
      } else {
        return null;
      }
    }, onError: (error) {
      print(TAG + 'error==');
      print(error.toString());
      return null;
    });
  }

  Future insertAllMrfarmsCompanion(
      List<MrfarmsCompanion> onlineuserCompanionList) async {
    await batch((b) {
      b.insertAll(mrfarms, onlineuserCompanionList);
    });
  }

  Future<bool> upsertAllMrfarmsCompanion(
      List<MrfarmsCompanion> onlineuserCompanionList) async {
    List<Mrfarm> upd = [];
    List<MrfarmsCompanion> ins = [];

    for (MrfarmsCompanion cin in onlineuserCompanionList) {
      int? onlidval = cin.onlineid.value;
      Mrfarm? mf;
      if (onlidval != null) {
        mf = await getMrfarmByOnlineId(onlidval);
      }

      if (cin.farmer_online_id.value != null) {
        int? farmeronlineid = cin.farmer_online_id.value;
        Mrfarmer? mrfarmer =
            await db.mrfarmerDao.getMrfarmerByOnlineId(farmeronlineid);
        if (mrfarmer != null) {
          cin = cin.copyWith(
            farmer: Value(mrfarmer.id),
          );
        }
      }

      if (mf != null) {
        if (mf.issettobeupdated == null ||
            (mf.issettobeupdated != null && !mf.issettobeupdated)) {
          mf.copyWith(
            farm_name: ((cin.farm_name != null ? cin.farm_name.value : null)),
            farm_size: ((cin.farm_size != null ? cin.farm_size.value : null)),
            farmer: ((cin.farmer != null ? cin.farmer.value : null)),
            farmer_online_id: ((cin.farmer_online_id != null
                ? cin.farmer_online_id.value
                : null)),
            issettobeupdated: ((cin.issettobeupdated != null
                ? cin.issettobeupdated.value
                : false)),
            deleted: ((cin.deleted != null ? cin.deleted.value : false)),
          );
          upd.add(mf);
        }
      } else {
        ins.add(cin);
      }
    }

    await updateAllMrfarms(upd);
    await batch((b) {
      b.insertAll(mrfarms, ins);
    });
    return true;
  }

  Future updateAllMrfarmsCompanion(
      List<MrfarmsCompanion> onlineuserCompanionList) async {
    return await batch((b) async {
      for (MrfarmsCompanion smc in onlineuserCompanionList) {
        await updateMrfarmsCompanion(smc);
      }
    });
  }

  Future<bool> updateAllMrfarms(List<Mrfarm> onlineuserCompanionList) async {
    for (Mrfarm smc in onlineuserCompanionList) {
      update(mrfarms).replace(smc);
    }
    return true;
  }

  Future<bool> updateMrfarmsCompanion(Insertable<Mrfarm> mfarm) {
    return update(mrfarms).replace(mfarm);
  }

  Future<List<Mrfarm>> getMrfarmsByName(String name) {
    String TAG = 'getMrfarmsByName:';
    return (select(mrfarms)
          ..where((t) =>
              t.farm_name.like('%' + name + '%') |
              t.farm_size.like('%' + name + '%')))
        .get()
        .then((List<Mrfarm> reslist) {
      if (reslist.length > 0) {
        return reslist;
      } else {
        return [];
      }
    }, onError: (error) {
      return [];
    });
  }

  Future<List<Mrfarm>> getMrfarmsByFarmerId(int farmerid) {
    String TAG = 'getMrfarmsByFarmerId:';
    return (select(mrfarms)..where((t) => t.farmer.equals(farmerid)))
        .get()
        .then((List<Mrfarm> reslist) {
      if (reslist.length > 0) {
        return reslist;
      } else {
        return [];
      }
    }, onError: (error) {
      return [];
    });
  }

  Future deleteAllMrfarmsFuture(List<Mrfarm> onlineuserList) async {
    await batch((b) {
      for (Mrfarm smc in onlineuserList) {
        deleteMrfarmFuture(smc);
      }
    });
  }

  Future<int> deleteMrfarmFuture(Mrfarm mrfarm) =>
      delete(mrfarms).delete(mrfarm);
}
