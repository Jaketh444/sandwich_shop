import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/main.dart';

void main() {
  group('App', () {
    testWidgets('renders OrderScreen as home', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();
      expect(find.byType(OrderScreen), findsOneWidget);
    });
  });

  group('OrderScreen - Quantity & Notes', () {
    testWidgets('shows initial quantity, title and default note',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();

      // App bar title
      expect(find.text('Sandwich Counter'), findsOneWidget);

      // Initial quantity line (uses default bread 'white' and default size 'footlong')
      expect(find.text('0 white footlong sandwich(es): '), findsOneWidget);

      // Default note text is provided by the screen when empty
      expect(find.text('Note: No notes added.'), findsOneWidget);
    });

    testWidgets('increments quantity when Add is tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();

      final Finder addButton = find.text('Add');
      expect(addButton, findsOneWidget);

      await tester.tap(addButton);
      await tester.pumpAndSettle();

      expect(find.text('1 white footlong sandwich(es): 🥪'), findsOneWidget);
    });

    testWidgets('decrements quantity when Remove is tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();

      final Finder addButton = find.text('Add');
      final Finder removeButton = find.text('Remove');

      // increment once, then decrement back to 0
      await tester.tap(addButton);
      await tester.pumpAndSettle();

      expect(find.text('1 white footlong sandwich(es): 🥪'), findsOneWidget);

      await tester.tap(removeButton);
      await tester.pumpAndSettle();

      expect(find.text('0 white footlong sandwich(es): '), findsOneWidget);
    });

    testWidgets('does not decrement below zero', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();

      final Finder removeButton = find.text('Remove');

      // tap Remove multiple times, should stay at 0
      await tester.tap(removeButton);
      await tester.pumpAndSettle();
      await tester.tap(removeButton);
      await tester.pumpAndSettle();

      expect(find.text('0 white footlong sandwich(es): '), findsOneWidget);
    });

    testWidgets('does not increment above maxQuantity',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();

      final Finder addButton = find.text('Add');

      // App uses maxQuantity: 5 (from App.home)
      for (int i = 0; i < 7; i++) {
        await tester.tap(addButton);
        await tester.pumpAndSettle();
      }

      expect(find.text('5 white footlong sandwich(es): 🥪🥪🥪🥪🥪'),
          findsOneWidget);
    });

    testWidgets('updates the note when typing into the TextField',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();

      final Finder notesField = find.byKey(const Key('notes_textfield'));
      expect(notesField, findsOneWidget);

      await tester.enterText(notesField, 'Extra mayo');
      await tester.pumpAndSettle();

      expect(find.text('Note: Extra mayo'), findsOneWidget);
    });
  });

  group('OrderScreen - Controls', () {
    testWidgets('changes bread type with DropdownMenu',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();

      // Open the dropdown menu
      final Finder dropdown = find.byType(DropdownMenu<BreadType>);
      expect(dropdown, findsOneWidget);

      await tester.tap(dropdown);
      await tester.pumpAndSettle();

      // Select 'wheat' option
      final Finder wheatOption = find.text('wheat').last;
      expect(wheatOption, findsWidgets);

      await tester.tap(wheatOption);
      await tester.pumpAndSettle();

      // The OrderItemDisplay should update to reflect the selected bread
      expect(find.text('0 wheat footlong sandwich(es): '), findsOneWidget);
    });

    testWidgets('toggles sandwich size using the Switch',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();

      // Labels sit next to the Switch; initial is footlong
      expect(find.text('0 white footlong sandwich(es): '), findsOneWidget);

      final Finder switchFinder = find.byKey(const Key('size_switch'));
      expect(switchFinder, findsOneWidget);

      await tester.tap(switchFinder);
      await tester.pumpAndSettle();

      // After toggling, size becomes six-inch
      expect(find.text('0 white six-inch sandwich(es): '), findsOneWidget);
    });
  });

  group('OrderScreen - Toast Switch', () {
    testWidgets('toggles toast state and updates display',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();

      // Find the toast status Text by key to avoid colliding with label text
      final Finder statusFinder = find.byKey(const Key('toast_status'));
      expect(statusFinder, findsOneWidget);
      final Text initialStatus = tester.widget<Text>(statusFinder);
      expect(initialStatus.data, 'untoasted');

      final Finder toastSwitch = find.byKey(const Key('toast_switch'));
      expect(toastSwitch, findsOneWidget);

      await tester.tap(toastSwitch);
      await tester.pumpAndSettle();

      // After toggling, toast status should update to 'toasted'
      final Text toggledStatus = tester.widget<Text>(statusFinder);
      expect(toggledStatus.data, 'toasted');
    });
  });
}
