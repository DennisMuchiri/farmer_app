import 'package:json_annotation/json_annotation.dart';

part 'FarmReqJModel.g.dart';

@JsonSerializable()
class FarmReqJModel {
  int? id;
  String? farm_name;
  String? farm_size;

  FarmReqJModel() {}

  factory FarmReqJModel.fromJson(Map<String, dynamic> json) =>
      _$FarmReqJModelFromJson(json);
  Map<String, dynamic> toJson() => _$FarmReqJModelToJson(this);
}