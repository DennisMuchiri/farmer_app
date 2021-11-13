
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:farmer_app/main.dart';
import 'package:mockito/mockito.dart';
import 'package:farmer_app/injection/injection.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  testWidgets('Test App is inflated', (WidgetTester tester) async {
    configureInjection(Env.prod);
    final testWidget = MyApp();

    await tester.pumpWidget(testWidget);
    await tester.pumpAndSettle();
  });

}
