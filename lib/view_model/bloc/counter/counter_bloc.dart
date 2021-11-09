


import 'package:farmer_app/view_model/bloc/counter/counter_event.dart';
import 'package:bloc/bloc.dart';

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<Increment>((event, emit) => emit(state + 1));
    on<Decrement>((event, emit) => emit(state - 1));

  }
}