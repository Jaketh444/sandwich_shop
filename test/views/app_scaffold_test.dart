import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/views/app_scaffold.dart';

void main() {
  group('AppScaffold Navigation Bar', () {
    testWidgets('Drawer is present and contains navigation links on mobile', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: AppScaffold(
            currentRoute: '/profile',
            body: Text('Profile Body'),
          ),
        ),
      );

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

    testWidgets('NavigationRail is present on wide screens', (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(1200, 800);
      tester.binding.window.devicePixelRatioTestValue = 1.0;

      await tester.pumpWidget(
        MaterialApp(
          home: AppScaffold(
            currentRoute: '/orders',
            body: const Text('Orders Body'),
          ),
        ),
      );

      // Check for NavigationRail
      expect(find.byType(NavigationRail), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);
      expect(find.text('Orders'), findsOneWidget);
      expect(find.text('Settings'), findsOneWidget);

      // Clean up
      addTearDown(() {
        tester.binding.window.clearPhysicalSizeTestValue();
        tester.binding.window.clearDevicePixelRatioTestValue();
      });
    });
  });
}
