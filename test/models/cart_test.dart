import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/models/cart.dart';
import 'package:sandwich_shop/models/sandwich.dart';
import 'package:sandwich_shop/repositories/pricing_repository.dart';

void main() {
  group('Cart Model', () {
    late Cart cart;
    late Sandwich sandwich1;
    late Sandwich sandwich2;

    setUp(() {
      cart = Cart(pricingRepository: PricingRepository());
      sandwich1 = Sandwich(
        type: SandwichType.chickenTeriyaki,
        isFootlong: false,
        breadType: BreadType.white,
      );
      sandwich2 = Sandwich(
        type: SandwichType.tunaMelt,
        isFootlong: true,
        breadType: BreadType.wheat,
      );
    });

    test('Add item to cart', () {
      cart.addItem(sandwich1, quantity: 2);
      expect(cart.items.length, 1);
      expect(cart.items.first.sandwich, sandwich1);
      expect(cart.items.first.quantity, 2);
    });

    test('Remove item from cart', () {
      cart.addItem(sandwich1);
      cart.removeItem(sandwich1);
      expect(cart.items.length, 0);
    });

    test('Update item quantity', () {
      cart.addItem(sandwich1, quantity: 1);
      cart.updateQuantity(sandwich1, 5);
      expect(cart.items.first.quantity, 5);
    });

    test('Update item quantity to zero removes item', () {
      cart.addItem(sandwich1, quantity: 1);
      cart.updateQuantity(sandwich1, 0);
      expect(cart.items.length, 0);
    });

    test('Calculate total price', () {
      cart.addItem(sandwich1, quantity: 2); // 2 x $7.00 = $14.00
      cart.addItem(sandwich2, quantity: 1); // 1 x $11.00 = $11.00
      expect(cart.totalPrice, 25.00);
    });

    test('Clear cart', () {
      cart.addItem(sandwich1);
      cart.addItem(sandwich2);
      cart.clear();
      expect(cart.items.length, 0);
    });
  });
}
