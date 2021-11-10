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

  Future<bool> upsertAllMrfarmersByOnlineIdCompanion(
      List<MrfarmersCompanion> mrfarmersCompanionList) async {
    List<Mrfarmer> upd = [];
    List<MrfarmersCompanion> ins = [];

    for (MrfarmersCompanion cin in mrfarmersCompanionList) {
      int? onlidval = cin.onlineid.value;
      Mrfarmer? mf;
      if (onlidval != null) {
        mf = await getMrfarmerById(onlidval);
      }

      if (mf != null) {
        if (mf.issettobeupdated == null ||
            (mf.issettobeupdated != null && !mf.issettobeupdated)) {
          mf.copyWith(
            first_name:
                ((cin.first_name != null ? cin.first_name.value : null)),
            last_name: ((cin.last_name != null ? cin.last_name.value : null)),
            member_number:
                ((cin.member_number != null ? cin.member_number.value : null)),
            gender: ((cin.gender != null ? cin.gender.value : null)),
            phone_number:
                ((cin.phone_number != null ? cin.phone_number.value : null)),
            email: ((cin.email != null ? cin.email.value : null)),
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
    await updateAllMrfarmers(upd);
    await batch((b) {
      b.insertAll(mrfarmers, ins);
    });
    return true;
  }

  Future<bool> updateAllMrfarmersCompanion(
      List<MrfarmersCompanion> onlineuserCompanionList) async {
    //return await batch((b) async {
    for (MrfarmersCompanion smc in onlineuserCompanionList) {
      //await updateMrfarmersCompanion(smc);
      update(mrfarmers).replace(smc);
    }
    return true;
    /*});*/
  }

  Future<bool> updateAllMrfarmers(
      List<Mrfarmer> onlineuserCompanionList) async {
    for (Mrfarmer smc in onlineuserCompanionList) {
      //await updateMrfarmersCompanion(smc);
      await update(mrfarmers).replace(smc);
    }
    return true;
    /*});*/
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

  Future<bool> updateMrfarmerById(MrfarmersCompanion cin) async {
    int? id = cin.id.value;
    Mrfarmer? mf;
    if (id != null) {
      mf = await getMrfarmerById(id);
    }

    if (mf != null) {
      mf = mf.copyWith(
        first_name:
        ((cin.first_name != null ? cin.first_name.value : null)),
        last_name: ((cin.last_name != null ? cin.last_name.value : null)),
        member_number:
        ((cin.member_number != null ? cin.member_number.value : null)),
        gender: ((cin.gender != null ? cin.gender.value : null)),
        phone_number:
        ((cin.phone_number != null ? cin.phone_number.value : null)),
        email: ((cin.email != null ? cin.email.value : null)),
        issettobeupdated: true,
        deleted: ((cin.deleted != null ? cin.deleted.value : false)),
      );
    }

    if (mf != null) {
      await update(mrfarmers).replace(mf);
    }
    return true;
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
