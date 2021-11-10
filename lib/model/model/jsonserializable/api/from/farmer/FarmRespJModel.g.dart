// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FarmRespJModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FarmRespJModel _$FarmRespJModelFromJson(Map<String, dynamic> json) =>
    FarmRespJModel(
      deleted: json['deleted'] as bool?,
    )
      ..id = json['id'] as int?
      ..onlineid = json['onlineid'] as int?
      ..farmer_online_id = json['farmer_online_id'] as int?
      ..farm_name = json['farm_name'] as String?
      ..farm_size = json['farm_size'] as String?
      ..lv_index = json['lv_index'] as int?
      ..farmer = json['farmer'] as int?
      ..issettobeupdated = json['issettobeupdated'] as bool?;

Map<String, dynamic> _$FarmRespJModelToJson(FarmRespJModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'onlineid': instance.onlineid,
      'farmer_online_id': instance.farmer_online_id,
      'farm_name': instance.farm_name,
      'farm_size': instance.farm_size,
      'lv_index': instance.lv_index,
      'farmer': instance.farmer,
      'issettobeupdated': instance.issettobeupdated,
      'deleted': instance.deleted,
    };
