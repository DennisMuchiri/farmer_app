import 'package:injectable/injectable.dart';
import 'package:farmer_app/model/repository/local/counter/i_counter_repository.dart';

const prod = Environment('dev');
@dev
@Injectable(as: ICounterRepository)
class DevCounterRepository implements ICounterRepository {
  @override
  int getIncrement() => 2;
}