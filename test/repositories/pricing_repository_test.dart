import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/repositories/pricing_repository.dart';

void main() {
  group('PricingRepository', () {
    const repo = PricingRepository();

    test('price per sandwich for six-inch is £7', () {
      expect(repo.pricePerSandwich(isFootlong: false), 7);
    });

    test('price per sandwich for footlong is £11', () {
      expect(repo.pricePerSandwich(isFootlong: true), 11);
    });

    test('total price calculates quantity * unit price', () {
      expect(repo.totalPricePounds(isFootlong: false, quantity: 3), 21);
      expect(repo.totalPricePounds(isFootlong: true, quantity: 2), 22);
    });

    test('formattedTotal returns a string with the pound sign', () {
      expect(repo.formattedTotal(isFootlong: true, quantity: 2), '£22');
    });

    test('total is 0 for zero or negative quantities', () {
      expect(repo.totalPricePounds(isFootlong: true, quantity: 0), 0);
      expect(repo.totalPricePounds(isFootlong: false, quantity: -5), 0);
    });
  });
}
