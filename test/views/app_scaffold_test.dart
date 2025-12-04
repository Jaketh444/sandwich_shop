import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/views/app_scaffold.dart';

void main() {
  group('AppScaffold Navigation Bar', () {
    testWidgets('shows Drawer with navigation links on mobile', (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(400, 800);
      tester.binding.window.devicePixelRatioTestValue = 1.0;

      await tester.pumpWidget(
        const MaterialApp(
          home: AppScaffold(
            currentRoute: '/profile',
            body: Text('Profile Body'),
          ),
        ),
      );

      // Open Drawer
      await tester.tap(find.byTooltip('Open navigation menu'));
      await tester.pumpAndSettle();

      // Check navigation links
      for (final label in ['Home', 'Profile', 'Orders', 'Settings']) {
        expect(find.text(label), findsOneWidget);
      }

      // Clean up screen size
      addTearDown(() {
        tester.binding.window.clearPhysicalSizeTestValue();
        tester.binding.window.clearDevicePixelRatioTestValue();
      });
    });

    testWidgets('shows NavigationRail with navigation links on wide screens', (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(1200, 800);
      tester.binding.window.devicePixelRatioTestValue = 1.0;

      await tester.pumpWidget(
        const MaterialApp(
          home: AppScaffold(
            currentRoute: '/orders',
            body: Text('Orders Body'),
          ),
        ),
      );

      // Check NavigationRail and navigation links
      expect(find.byType(NavigationRail), findsOneWidget);
      for (final label in ['Home', 'Profile', 'Orders', 'Settings']) {
        expect(find.text(label), findsOneWidget);
      }

      // Clean up screen size
      addTearDown(() {
        tester.binding.window.clearPhysicalSizeTestValue();
        tester.binding.window.clearDevicePixelRatioTestValue();
      });
    });
  });
}
