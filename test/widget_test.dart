import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iris/main.dart';

void main() {
  testWidgets('Iris Prediction App Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the app starts with the correct title.
    expect(find.text('Iris Prediction App'), findsOneWidget);

    // Enter sample values in text fields.
    await tester.enterText(find.byKey(const Key('sepalLength')), '5.1');
    await tester.enterText(find.byKey(const Key('sepalWidth')), '3.5');
    await tester.enterText(find.byKey(const Key('petalLength')), '1.4');
    await tester.enterText(find.byKey(const Key('petalWidth')), '0.2');

    // Tap the predict button.
    await tester.tap(find.byType(ElevatedButton));

    // Wait for the response.
    await tester.pump();

    // Verify that the predicted species is displayed in the alert.
    expect(find.text('Predicted Iris Species'), findsOneWidget);
  });
}
