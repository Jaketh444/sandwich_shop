import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/main.dart';
import 'package:sandwich_shop/models/sandwich.dart';

void main() {
  group('App', () {
    testWidgets('renders OrderScreen as home', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(OrderScreen), findsOneWidget);
    });
  });

  group('OrderScreen - Quantity', () {
    testWidgets('shows initial quantity and title',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.text('Sandwich Counter'), findsOneWidget);
      expect(find.byKey(const Key('quantity_text')), findsOneWidget);
      expect(find.text('1'), findsOneWidget); // Initial quantity is 1
    });

    testWidgets('increments quantity when Add is tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      final increaseButton = find.byKey(const Key('increase_quantity_button'));
      await tester.ensureVisible(increaseButton);
      expect(tester.widget<IconButton>(increaseButton).onPressed != null, true);
      await tester.tap(increaseButton);
      await tester.pump();
      expect(find.text('2'), findsOneWidget);
    });

    testWidgets('decrements quantity when Remove is tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      final increaseButton = find.byKey(const Key('increase_quantity_button'));
      final decreaseButton = find.byKey(const Key('decrease_quantity_button'));
      await tester.ensureVisible(increaseButton);
      await tester.ensureVisible(decreaseButton);
      expect(tester.widget<IconButton>(increaseButton).onPressed != null, true);
      await tester.tap(increaseButton);
      await tester.pump();
      expect(find.text('2'), findsOneWidget);
      expect(tester.widget<IconButton>(decreaseButton).onPressed != null, true);
      await tester.tap(decreaseButton);
      await tester.pump();
      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('does not decrement below one', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.text('1'), findsOneWidget);
      await tester.tap(find.byKey(const Key('decrease_quantity_button')));
      await tester.pump();
      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('does not increment above maxQuantity',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      final increaseButton = find.byKey(const Key('increase_quantity_button'));
      for (int i = 0; i < 10; i++) {
        await tester.ensureVisible(increaseButton);
        if (tester.widget<IconButton>(increaseButton).onPressed != null) {
          await tester.tap(increaseButton);
          await tester.pump();
        }
      }
      expect(find.text('5'), findsOneWidget); // maxQuantity is 5 for test
    });
  });

  group('OrderScreen - Controls', () {
    testWidgets('toggles sandwich type with Switch',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.byKey(const Key('sandwich_type_dropdown')), findsOneWidget);
      expect(find.text('Veggie Delight'), findsWidgets); // At least one
      await tester.tap(find.byType(Switch));
      await tester.pump();
      // No direct text, but you can check state change or selection
    });
    testWidgets('changes bread type with DropdownMenu',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      await tester.tap(find.byKey(const Key('bread_type_dropdown')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('wheat').last);
      await tester.pumpAndSettle();
      expect(find.text('wheat'), findsWidgets);
      await tester.tap(find.byKey(const Key('bread_type_dropdown')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('wholemeal').last);
      await tester.pumpAndSettle();
      expect(find.text('wholemeal'), findsWidgets);
    });
  });

  group('StyledButton', () {
    testWidgets('renders with icon and label', (WidgetTester tester) async {
      const testButton = StyledButton(
        onPressed: null,
        icon: Icons.add,
        label: 'Test Add',
        backgroundColor: Colors.blue,
      );
      const testApp = MaterialApp(
        home: Scaffold(body: testButton),
      );
      await tester.pumpWidget(testApp);
      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.text('Test Add'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });
}
