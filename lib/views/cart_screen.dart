import 'package:flutter/material.dart';
import 'package:sandwich_shop/views/app_styles.dart';
import 'package:sandwich_shop/views/order_screen.dart';
import 'package:sandwich_shop/models/cart.dart';
import 'package:sandwich_shop/models/sandwich.dart';
import 'package:sandwich_shop/repositories/pricing_repository.dart';
import 'package:sandwich_shop/views/checkout_screen.dart';


class CartScreen extends StatefulWidget {
  final Cart cart;

  const CartScreen({super.key, required this.cart});

  @override
  State<CartScreen> createState() {
    return _CartScreenState();
  }
}

class _CartScreenState extends State<CartScreen> {
  void _goBack() {
    Navigator.pop(context);
  }

  String _getSizeText(bool isFootlong) {
    if (isFootlong) {
      return 'Footlong';
    } else {
      return 'Six-inch';
    }
  }

  double _getItemPrice(Sandwich sandwich, int quantity) {
    final PricingRepository pricingRepository = PricingRepository();
    return pricingRepository.calculatePrice(
      quantity: quantity,
      isFootlong: sandwich.isFootlong,
    );
  }

  void _showUndoSnackbar(String itemName, VoidCallback onUndo) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$itemName removed from cart'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: onUndo, // Undo logic in later tasks
        ),
      ),
    );
  }

  void _decreaseQuantity(Sandwich sandwich) {
    setState(() {
      widget.cart.decreaseQuantity(sandwich);
    });
  }

  void _increaseQuantity(Sandwich sandwich) {
    setState(() {
      widget.cart.increaseQuantity(sandwich);
    });
  }

  void _removeItem(Sandwich sandwich) {
    setState(() {
      widget.cart.removeItem(sandwich);
    });
    _showUndoSnackbar(sandwich.name, () {
      setState(() {
        widget.cart.restoreLastRemoved();
      });
    });
  }

  Future<void> _navigateToCheckout() async {
    if (widget.cart.items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Your cart is empty'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CheckoutScreen(cart: widget.cart),
      ),
    );

    if (result != null && mounted) {
      setState(() {
        widget.cart.clear();
      });

      final String orderId = result['orderId'] as String;
      final String estimatedTime = result['estimatedTime'] as String;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Order $orderId confirmed! Estimated time: $estimatedTime'),
          duration: const Duration(seconds: 4),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartIsEmpty = widget.cart.isEmpty;

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 100,
            child: Image.asset('assets/images/logo.png'),
          ),
        ),
        title: const Text(
          'Cart View',
          style: heading1,
        ),
      ),
      body: Center(
        child: cartIsEmpty
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 40),
                  Icon(Icons.shopping_cart_outlined,
                      size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Your cart is empty.',
                    style: heading2,
                  ),
                ],
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),
                    for (MapEntry<Sandwich, int> entry
                        in widget.cart.items.entries)
                      Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(entry.key.name, style: heading2),
                                    Text(
                                      '${_getSizeText(entry.key.isFootlong)} on ${entry.key.breadType.name} bread',
                                      style: normalText,
                                    ),
                                    Text(
                                      '£${_getItemPrice(entry.key, entry.value).toStringAsFixed(2)}',
                                      style: normalText,
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: () {
                                      _decreaseQuantity(entry.key);
                                    },
                                  ),
                                  Text('${entry.value}', style: heading2),
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () {
                                      _increaseQuantity(entry.key);
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete_outline),
                                    onPressed: () {
                                      _removeItem(entry.key);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    Text(
                      'Total: £${widget.cart.totalPrice.toStringAsFixed(2)}',
                      style: heading2,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    StyledButton(
                      onPressed: _goBack,
                      icon: Icons.arrow_back,
                      label: 'Back to Order',
                      backgroundColor: Colors.grey,
                    ),
                    const SizedBox(height: 20),
                    Builder(
                      builder: (BuildContext context) {
                        final bool cartHasItems = widget.cart.items.isNotEmpty;
                        if (cartHasItems) {
                          return StyledButton(
                            onPressed: _navigateToCheckout,
                            icon: Icons.payment,
                            label: 'Checkout',
                            backgroundColor: Colors.orange,
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
      ),
    );
  }
}
