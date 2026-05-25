import 'package:flutter_test/flutter_test.dart';
import 'package:f1_flutter/main.dart';

void main() {
  testWidgets('Splash View renders STRATEGY CONTROL', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const StrategyControlApp());

    // Verify that the title STRATEGY CONTROL is present.
    expect(find.text('STRATEGY CONTROL'), findsOneWidget);
  });
}
