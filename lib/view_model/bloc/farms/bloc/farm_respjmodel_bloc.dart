import 'package:bloc/bloc.dart';
import 'package:farmer_app/view_model/bloc/farms/bloc/farm_respjmodel_bloc_event.dart';
import 'package:farmer_app/view_model/bloc/farms/bloc/farm_respjmodel_state.dart';

class FarmRespJModelBloc
    extends Bloc<FarmRespJModelEvent, FarmRespJModelState> {
  FarmRespJModelBloc() : super(FarmRespJModelInitial());

  @override
  FarmRespJModelState get initialState => FarmRespJModelInitial();

  @override
  Stream<FarmRespJModelState> mapEventToState(
    FarmRespJModelEvent event,
  ) async* {
    if (event is FarmObjChanged) {
      final obj = (event.obj);
      yield FarmRespJModelLoaded(obj);
    } else {
      yield FarmRespJModelLoading();
    }
  }

  @override
  void dispose() {
    this.dispose();
  }
}
