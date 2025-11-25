import 'package:flutter/material.dart';
import 'package:sandwich_shop/views/app_styles.dart';
import 'package:sandwich_shop/models/sandwich.dart';
import 'package:sandwich_shop/models/cart.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Sandwich Shop App',
      home: OrderScreen(maxQuantity: 5),
    );
  }
}

class OrderScreen extends StatefulWidget {
  final int maxQuantity;

  const OrderScreen({super.key, this.maxQuantity = 10});

  @override
  State<OrderScreen> createState() {
    return _OrderScreenState();
  }
}

class _OrderScreenState extends State<OrderScreen> {
  void _showCartModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext ctx) {
        final cartItems = _cart.items;
        final pricingRepo = _cart.pricingRepository;
        if (cartItems.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(24.0),
            child: Center(
              child: Text('Your cart is empty.', style: normalText),
            ),
          );
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Your Cart', style: heading1),
            ),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  final sandwich = item.sandwich;
                  final sizeText =
                      sandwich.isFootlong ? 'Footlong' : 'Six-inch';
                  final itemPrice = pricingRepo.calculatePrice(
                    quantity: item.quantity,
                    isFootlong: sandwich.isFootlong,
                  );
                  return ListTile(
                    leading: Icon(Icons.fastfood),
                    title: Text('${item.quantity} x ${sandwich.name}'),
                    subtitle:
                        Text('$sizeText on ${sandwich.breadType.name} bread'),
                    trailing: Text('£${itemPrice.toStringAsFixed(2)}'),
                  );
                },
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total:', style: heading2),
                  Text('£${_cart.totalPrice.toStringAsFixed(2)}',
                      style: heading2),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  final Cart _cart = Cart();
  final TextEditingController _notesController = TextEditingController();

  SandwichType _selectedSandwichType = SandwichType.veggieDelight;
  bool _isFootlong = true;
  BreadType _selectedBreadType = BreadType.white;
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    _notesController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _addToCart() {
    if (_quantity > 0) {
      final Sandwich sandwich = Sandwich(
        type: _selectedSandwichType,
        isFootlong: _isFootlong,
        breadType: _selectedBreadType,
      );

      setState(() {
        _cart.addItem(sandwich, quantity: _quantity);
      });

      String sizeText = _isFootlong ? 'footlong' : 'six-inch';
      String confirmationMessage =
          'Added $_quantity $sizeText ${sandwich.name} sandwich(es) on ${_selectedBreadType.name} bread to cart';

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(confirmationMessage),
          duration: const Duration(seconds: 2),
        ),
      );

      debugPrint(confirmationMessage);
    }
  }

  VoidCallback? _getAddToCartCallback() {
    if (_quantity > 0) {
      return _addToCart;
    }
    return null;
  }

  List<DropdownMenuEntry<SandwichType>> _buildSandwichTypeEntries() {
    List<DropdownMenuEntry<SandwichType>> entries = [];
    for (SandwichType type in SandwichType.values) {
      Sandwich sandwich =
          Sandwich(type: type, isFootlong: true, breadType: BreadType.white);
      DropdownMenuEntry<SandwichType> entry = DropdownMenuEntry<SandwichType>(
        value: type,
        label: sandwich.name,
      );
      entries.add(entry);
    }
    return entries;
  }

  List<DropdownMenuEntry<BreadType>> _buildBreadTypeEntries() {
    List<DropdownMenuEntry<BreadType>> entries = [];
    for (BreadType bread in BreadType.values) {
      DropdownMenuEntry<BreadType> entry = DropdownMenuEntry<BreadType>(
        value: bread,
        label: bread.name,
      );
      entries.add(entry);
    }
    return entries;
  }

  String _getCurrentImagePath() {
    final Sandwich sandwich = Sandwich(
      type: _selectedSandwichType,
      isFootlong: _isFootlong,
      breadType: _selectedBreadType,
    );
    return sandwich.image;
  }

  void _onSandwichTypeChanged(SandwichType? value) {
    if (value != null) {
      setState(() {
        _selectedSandwichType = value;
      });
    }
  }

  void _onSizeChanged(bool value) {
    setState(() {
      _isFootlong = value;
    });
  }

  void _onBreadTypeChanged(BreadType? value) {
    if (value != null) {
      setState(() {
        _selectedBreadType = value;
      });
    }
  }

  void _increaseQuantity() {
    setState(() {
      if (_quantity < widget.maxQuantity) {
        _quantity++;
      }
    });
  }

  void _decreaseQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  VoidCallback? _getDecreaseCallback() {
    if (_quantity > 0) {
      return _decreaseQuantity;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sandwich Counter',
          style: heading1,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            tooltip: 'View Cart',
            onPressed: () => _showCartModal(context),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 300,
                child: Image.asset(
                  _getCurrentImagePath(),
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Text(
                        'Image not found',
                        style: normalText,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              DropdownMenu<SandwichType>(
                key: const Key('sandwich_type_dropdown'),
                width: double.infinity,
                label: const Text('Sandwich Type'),
                textStyle: normalText,
                initialSelection: _selectedSandwichType,
                onSelected: _onSandwichTypeChanged,
                dropdownMenuEntries: _buildSandwichTypeEntries(),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Six-inch', style: normalText),
                  Switch(
                    value: _isFootlong,
                    onChanged: _onSizeChanged,
                  ),
                  const Text('Footlong', style: normalText),
                ],
              ),
              const SizedBox(height: 20),
              DropdownMenu<BreadType>(
                key: const Key('bread_type_dropdown'),
                width: double.infinity,
                label: const Text('Bread Type'),
                textStyle: normalText,
                initialSelection: _selectedBreadType,
                onSelected: _onBreadTypeChanged,
                dropdownMenuEntries: _buildBreadTypeEntries(),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Quantity: ', style: normalText),
                  IconButton(
                    key: const Key('decrease_quantity_button'),
                    onPressed: _getDecreaseCallback(),
                    icon: const Icon(Icons.remove),
                  ),
                  Text('$_quantity',
                      key: const Key('quantity_text'), style: heading2),
                  IconButton(
                    key: const Key('increase_quantity_button'),
                    onPressed: _increaseQuantity,
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              StyledButton(
                key: const Key('add_to_cart_button'),
                onPressed: _getAddToCartCallback(),
                icon: Icons.add_shopping_cart,
                label: 'Add to Cart',
                backgroundColor: Colors.green,
              ),
              const SizedBox(height: 20),
              StyledButton(
                key: const Key('view_cart_button'),
                onPressed: () => _showCartModal(context),
                icon: Icons.shopping_cart,
                label: 'View Cart',
                backgroundColor: Colors.blue,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class StyledButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final String label;
  final Color backgroundColor;

  const StyledButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.label,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    ButtonStyle myButtonStyle = ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      foregroundColor: Colors.white,
      textStyle: normalText,
    );

    return ElevatedButton(
      onPressed: onPressed,
      style: myButtonStyle,
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }
}
