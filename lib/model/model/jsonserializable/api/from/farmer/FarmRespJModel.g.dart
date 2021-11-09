// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FarmRespJModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FarmRespJModel _$FarmRespJModelFromJson(Map<String, dynamic> json) =>
    FarmRespJModel()
      ..id = json['id'] as int?
      ..farm_name = json['farm_name'] as String?
      ..farm_size = json['farm_size'] as String?
      ..lv_index = json['lv_index'] as int?;

Map<String, dynamic> _$FarmRespJModelToJson(FarmRespJModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'farm_name': instance.farm_name,
      'farm_size': instance.farm_size,
      'lv_index': instance.lv_index,
    };
