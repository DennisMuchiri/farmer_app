import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:farmer_app/model/repository/local/counter/repositories/counter_repository.dart';
import 'package:farmer_app/model/repository/local/counter/repositories/dev_counter_repository.dart';
import 'package:farmer_app/model/repository/local/counter/repositories/mock_counter_repository.dart';
import 'package:farmer_app/injection/injection.dart';

abstract class ICounterRepository {
  int getIncrement();
}


