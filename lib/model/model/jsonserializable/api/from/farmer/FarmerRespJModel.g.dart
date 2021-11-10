// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FarmerRespJModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FarmerRespJModel _$FarmerRespJModelFromJson(Map<String, dynamic> json) =>
    FarmerRespJModel()
      ..id = json['id'] as int?
      ..onlineid = json['onlineid'] as int?
      ..first_name = json['first_name'] as String?
      ..last_name = json['last_name'] as String?
      ..member_number = json['member_number'] as String?
      ..gender = json['gender'] as String?
      ..phone_number = json['phone_number'] as String?
      ..email = json['email'] as String?
      ..farms = (json['farms'] as List<dynamic>?)
          ?.map((e) => FarmRespJModel.fromJson(e as Map<String, dynamic>))
          .toList()
      ..lv_index = json['lv_index'] as int?
      ..issettobeupdated = json['issettobeupdated'] as bool?
      ..deleted = json['deleted'] as bool?;

Map<String, dynamic> _$FarmerRespJModelToJson(FarmerRespJModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'onlineid': instance.onlineid,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'member_number': instance.member_number,
      'gender': instance.gender,
      'phone_number': instance.phone_number,
      'email': instance.email,
      'farms': instance.farms,
      'lv_index': instance.lv_index,
      'issettobeupdated': instance.issettobeupdated,
      'deleted': instance.deleted,
    };
