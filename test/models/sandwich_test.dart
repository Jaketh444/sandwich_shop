import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/models/sandwich.dart';

void main() {
  group('Sandwich model', () {
    test('name returns correct string for each type', () {
      expect(
          Sandwich(
                  type: SandwichType.veggieDelight,
                  isFootlong: true,
                  breadType: BreadType.white)
              .name,
          'Veggie Delight');
      expect(
          Sandwich(
                  type: SandwichType.chickenTeriyaki,
                  isFootlong: false,
                  breadType: BreadType.wheat)
              .name,
          'Chicken Teriyaki');
      expect(
          Sandwich(
                  type: SandwichType.tunaMelt,
                  isFootlong: true,
                  breadType: BreadType.wholemeal)
              .name,
          'Tuna Melt');
      expect(
          Sandwich(
                  type: SandwichType.meatballMarinara,
                  isFootlong: false,
                  breadType: BreadType.white)
              .name,
          'Meatball Marinara');
    });

    test('image returns correct asset path for size and type', () {
      final s1 = Sandwich(
          type: SandwichType.tunaMelt,
          isFootlong: true,
          breadType: BreadType.white);
      expect(s1.image, 'assets/images/tunaMelt_footlong.png');
      final s2 = Sandwich(
          type: SandwichType.chickenTeriyaki,
          isFootlong: false,
          breadType: BreadType.wheat);
      expect(s2.image, 'assets/images/chickenTeriyaki_six_inch.png');
    });

    test('breadType is stored and accessible', () {
      final sandwich = Sandwich(
          type: SandwichType.veggieDelight,
          isFootlong: true,
          breadType: BreadType.wholemeal);
      expect(sandwich.breadType, BreadType.wholemeal);
    });

    test('isFootlong is stored and accessible', () {
      final sandwich = Sandwich(
          type: SandwichType.meatballMarinara,
          isFootlong: false,
          breadType: BreadType.white);
      expect(sandwich.isFootlong, false);
    });
  });
}
