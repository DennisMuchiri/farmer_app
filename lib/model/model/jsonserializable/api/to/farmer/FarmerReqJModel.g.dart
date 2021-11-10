// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FarmerReqJModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FarmerReqJModel _$FarmerReqJModelFromJson(Map<String, dynamic> json) =>
    FarmerReqJModel()
      ..id = json['id'] as int?
      ..first_name = json['first_name'] as String?
      ..last_name = json['last_name'] as String?
      ..member_number = json['member_number'] as String?
      ..gender = json['gender'] as String?
      ..phone_number = json['phone_number'] as String?
      ..email = json['email'] as String?;

Map<String, dynamic> _$FarmerReqJModelToJson(FarmerReqJModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'member_number': instance.member_number,
      'gender': instance.gender,
      'phone_number': instance.phone_number,
      'email': instance.email,
    };
