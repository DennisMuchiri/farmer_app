// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:farmer_app/model/repository/local/counter/i_counter_repository.dart';
import 'package:farmer_app/model/repository/local/counter/repositories/mock_counter_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:farmer_app/main.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:farmer_app/view_model/bloc/counter/counter_bloc.dart';
import 'package:farmer_app/view_model/bloc/counter/counter_event.dart';
import 'package:farmer_app/view_model/counter/CounterChangeNotifier.dart';
import 'package:provider/provider.dart';
import 'package:farmer_app/injection/injection.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  //late MockCounterRepository? mockCounterRepository;

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {});

  //test homepage
  /*testWidgets('home page is created', (WidgetTester tester) async {
    configureInjection(Env.prod);
    final testWidget = MyApp();

    await tester.pumpWidget(testWidget);
    await tester.pumpAndSettle();
  });*/

  setUp(() {
    //configureInjection(Env.testenv);
    //mockCounterRepository = MockCounterRepository();
  });

  int incr = 1;
  test('should get increment no 1', () async {
    configureInjection(Env.testenv);
    //mockCounterRepository = MockCounterRepository();

    final mockCounterRepository=getIt<ICounterRepository>();
    //ICounterRepository? mockCounterRepository;
    //arrange
    when(mockCounterRepository.
    getIncrement()).
    thenReturn(incr);

    /*await untilCalled(mockCounterRepository?.
    getIncrement()).then((value) {
      print(value.toString());
    });*/
    /*thenAnswer((inv) {
      return incr;
    });*/
    //act
    final result=  mockCounterRepository.getIncrement();

    //assert
    expect(result, incr);
    verify(mockCounterRepository.getIncrement()).called(1);
  });
}
