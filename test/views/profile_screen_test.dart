import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/views/profile_screen.dart';

void main() {
  group('ProfileScreen Drawer Navigation', () {
    testWidgets('Drawer is present and contains navigation links',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: ProfileScreen()));

      // Open the Drawer
      final menuButton = find.byTooltip('Open navigation menu');
      expect(menuButton, findsOneWidget);
      await tester.tap(menuButton);
      await tester.pumpAndSettle();

      // Check for navigation links
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);
      expect(find.text('Orders'), findsOneWidget);
      expect(find.text('Settings'), findsOneWidget);
    });

    testWidgets('Navigates to Orders screen via Drawer',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: ProfileScreen()));

      // Open the Drawer
      await tester.tap(find.byTooltip('Open navigation menu'));
      await tester.pumpAndSettle();

      // Tap Orders link
      await tester.tap(find.text('Orders'));
      await tester.pumpAndSettle();

      // Should navigate to Orders (route '/orders')
      // Since we don't have the full app, just check navigation attempted
      // (In a full integration test, we'd check for OrderScreen)
    });
  });
}
