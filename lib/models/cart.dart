import 'sandwich.dart';
import 'package:sandwich_shop/repositories/pricing_repository.dart';

class Cart {
  final Map<Sandwich, int> _items = {};

  // For undo functionality
  Sandwich? _lastRemovedSandwich;
  int? _lastRemovedQuantity;

  // Returns a read-only copy of the items and their quantities
  Map<Sandwich, int> get items => Map.unmodifiable(_items);

  void add(Sandwich sandwich, {int quantity = 1}) {
    if (_items.containsKey(sandwich)) {
      _items[sandwich] = _items[sandwich]! + quantity;
    } else {
      _items[sandwich] = quantity;
    }
  }

  void remove(Sandwich sandwich, {int quantity = 1}) {
    if (_items.containsKey(sandwich)) {
      final currentQty = _items[sandwich]!;
      if (currentQty > quantity) {
        _items[sandwich] = currentQty - quantity;
      } else {
        _items.remove(sandwich);
      }
    }
  }

  void clear() {
    _items.clear();
  }

  double get totalPrice {
    final pricingRepository = PricingRepository();
    double total = 0.0;

    for (Sandwich sandwich in _items.keys) {
      int quantity = _items[sandwich]!;
      total += pricingRepository.calculatePrice(
        quantity: quantity,
        isFootlong: sandwich.isFootlong,
      );
    }

    return total;
  }

  bool get isEmpty => _items.isEmpty;

  int get length => _items.length;

  int get countOfItems {
    int total = 0;
    for (Sandwich sandwich in _items.keys) {
      total += _items[sandwich]!;
    }
    return total;
  }

  int getQuantity(Sandwich sandwich) {
    if (_items.containsKey(sandwich)) {
      return _items[sandwich]!;
    }
    return 0;
  }

  // Increase the quantity of a sandwich by 1
  void increaseQuantity(Sandwich sandwich) {
    add(sandwich, quantity: 1);
  }

  // Decrease the quantity of a sandwich by 1
  void decreaseQuantity(Sandwich sandwich) {
    if (_items.containsKey(sandwich)) {
      if (_items[sandwich]! > 1) {
        _items[sandwich] = _items[sandwich]! - 1;
      } else {
        removeItem(sandwich);
      }
    }
  }

  // Remove a sandwich entirely from the cart and store for undo
  void removeItem(Sandwich sandwich) {
    if (_items.containsKey(sandwich)) {
      _lastRemovedSandwich = sandwich;
      _lastRemovedQuantity = _items[sandwich];
      _items.remove(sandwich);
    }
  }

  // Restore the last removed sandwich (for undo)
  void restoreLastRemoved() {
    if (_lastRemovedSandwich != null && _lastRemovedQuantity != null) {
      _items[_lastRemovedSandwich!] = _lastRemovedQuantity!;
      _lastRemovedSandwich = null;
      _lastRemovedQuantity = null;
    }
  }
}
