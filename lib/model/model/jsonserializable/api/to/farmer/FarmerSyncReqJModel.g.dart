// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FarmerSyncReqJModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FarmerSyncReqJModel _$FarmerSyncReqJModelFromJson(Map<String, dynamic> json) =>
    FarmerSyncReqJModel()
      ..new_farmers = (json['new_farmers'] as List<dynamic>?)
          ?.map((e) => FarmerReqJModel.fromJson(e as Map<String, dynamic>))
          .toList()
      ..updated_farmers = (json['updated_farmers'] as List<dynamic>?)
          ?.map((e) => FarmerReqJModel.fromJson(e as Map<String, dynamic>))
          .toList()
      ..deleted_farmers = (json['deleted_farmers'] as List<dynamic>?)
          ?.map((e) => FarmerReqJModel.fromJson(e as Map<String, dynamic>))
          .toList()
      ..new_farms = (json['new_farms'] as List<dynamic>?)
          ?.map((e) => FarmReqJModel.fromJson(e as Map<String, dynamic>))
          .toList()
      ..updated_farms = (json['updated_farms'] as List<dynamic>?)
          ?.map((e) => FarmReqJModel.fromJson(e as Map<String, dynamic>))
          .toList()
      ..delete_farms = (json['delete_farms'] as List<dynamic>?)
          ?.map((e) => FarmReqJModel.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$FarmerSyncReqJModelToJson(FarmerSyncReqJModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('new_farmers', instance.new_farmers);
  writeNotNull('updated_farmers', instance.updated_farmers);
  writeNotNull('deleted_farmers', instance.deleted_farmers);
  writeNotNull('new_farms', instance.new_farms);
  writeNotNull('updated_farms', instance.updated_farms);
  writeNotNull('delete_farms', instance.delete_farms);
  return val;
}
