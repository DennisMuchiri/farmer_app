// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FarmReqJModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FarmReqJModel _$FarmReqJModelFromJson(Map<String, dynamic> json) =>
    FarmReqJModel()
      ..id = json['id'] as int?
      ..farm_name = json['farm_name'] as String?
      ..farm_size = json['farm_size'] as String?;

Map<String, dynamic> _$FarmReqJModelToJson(FarmReqJModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'farm_name': instance.farm_name,
      'farm_size': instance.farm_size,
    };
