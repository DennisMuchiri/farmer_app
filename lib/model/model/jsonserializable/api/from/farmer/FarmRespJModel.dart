import 'package:json_annotation/json_annotation.dart';

part 'FarmRespJModel.g.dart';

@JsonSerializable()
class FarmRespJModel {
  int? id;
  String? farm_name;
  String? farm_size;

  //layout
  int? lv_index;

  FarmRespJModel() {}
  factory FarmRespJModel.fromJson(Map<String, dynamic> json) =>
      _$FarmRespJModelFromJson(json);
  Map<String, dynamic> toJson() => _$FarmRespJModelToJson(this);
}
