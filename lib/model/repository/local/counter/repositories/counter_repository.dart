import 'package:injectable/injectable.dart';
import 'package:farmer_app/model/repository/local/counter/i_counter_repository.dart';

const prod = Environment('prod');
@prod
@Injectable(as: ICounterRepository)
class CounterRepository implements ICounterRepository {
  @override
  int getIncrement() => 1;
}