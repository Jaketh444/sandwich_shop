import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/views/profile_screen.dart';

void main() {
  group('ProfileScreen Widget Tests', () {
    testWidgets('renders ProfileScreen and finds expected widgets',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ProfileScreen(),
        ),
      );

      // Example: Check for a title or key widget
      expect(find.byType(ProfileScreen), findsOneWidget);
      // Add more expectations based on ProfileScreen's UI
    });

    // Add more tests as needed
  });
}
