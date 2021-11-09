import 'package:equatable/equatable.dart';
import 'package:farmer_app/model/model/jsonserializable/api/from/farmer/FarmRespJModel.dart';

abstract class FarmRespJModelState extends Equatable {
  const FarmRespJModelState();
}

class FarmRespJModelInitial extends FarmRespJModelState {
  const FarmRespJModelInitial();
  @override
  List<Object> get props => [];
}

class FarmRespJModelLoading extends FarmRespJModelState {
  const FarmRespJModelLoading();
  @override
  List<Object> get props => [];
}

class FarmRespJModelLoaded extends FarmRespJModelState {
  final List<FarmRespJModel> obj;
  const FarmRespJModelLoaded(this.obj);
  @override
  List<Object> get props => [obj];
}
