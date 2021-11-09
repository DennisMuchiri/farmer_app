
import 'package:equatable/equatable.dart';
import 'package:farmer_app/model/model/jsonserializable/api/from/farmer/FarmRespJModel.dart';


abstract class FarmRespJModelEvent extends Equatable {
  const FarmRespJModelEvent();
}

class FarmObjChanged extends FarmRespJModelEvent {
  final List<FarmRespJModel> obj;

  const FarmObjChanged(this.obj);

  @override
  List<Object> get props => [obj];
}
