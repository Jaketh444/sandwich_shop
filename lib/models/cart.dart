import 'sandwich.dart';
import '../repositories/pricing_repository.dart';

class CartItem {
  final Sandwich sandwich;
  int quantity;

  CartItem({required this.sandwich, this.quantity = 1});
}

class Cart {
  final List<CartItem> items = [];
  final PricingRepository pricingRepository;

  Cart({PricingRepository? pricingRepository})
      : pricingRepository = pricingRepository ?? PricingRepository();

  void addItem(Sandwich sandwich, {int quantity = 1}) {
    final index =
        items.indexWhere((item) => _isSameSandwich(item.sandwich, sandwich));
    if (index != -1) {
      items[index].quantity += quantity;
    } else {
      items.add(CartItem(sandwich: sandwich, quantity: quantity));
    }
  }

  void removeItem(Sandwich sandwich) {
    items.removeWhere((item) => _isSameSandwich(item.sandwich, sandwich));
  }

  void updateQuantity(Sandwich sandwich, int quantity) {
    final index =
        items.indexWhere((item) => _isSameSandwich(item.sandwich, sandwich));
    if (index != -1) {
      if (quantity > 0) {
        items[index].quantity = quantity;
      } else {
        items.removeAt(index);
      }
    }
  }

  double get totalPrice {
    double total = 0.0;
    for (final item in items) {
      total += pricingRepository.calculatePrice(
        quantity: item.quantity,
        isFootlong: item.sandwich.isFootlong,
      );
    }
    return total;
  }

  void clear() {
    items.clear();
  }

  bool _isSameSandwich(Sandwich a, Sandwich b) {
    return a.type == b.type &&
        a.isFootlong == b.isFootlong &&
        a.breadType == b.breadType;
  }
}
