import 'package:flutter/material.dart';

enum SandwichSize {
  sixInch,
  footlong;

  String get displayName {
    switch (this) {
      case SandwichSize.sixInch:
        return 'Six Inch';
      case SandwichSize.footlong:
        return 'Footlong';
    }
  }
}

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

class OrderItemsGrid extends StatelessWidget {
  const OrderItemsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.count(
        crossAxisCount: 3,
        shrinkWrap: true,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        children: const [
          OrderItemDisplay(5, 'Footlong'),
          OrderItemDisplay(2, 'Six Inch'),
          OrderItemDisplay(3, 'Wrap'),
        ],
      ),
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
  int _quantity = 0;
  String _note = ''; // user-entered note for the current order
  SandwichSize _currentSize = SandwichSize.footlong;

  void _increaseQuantity() {
    if (_quantity < widget.maxQuantity) {
      setState(() => _quantity++);
    }
  }

  void _decreaseQuantity() {
    if (_quantity > 0) {
      setState(() => _quantity--);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sandwich Counter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SegmentedButton<SandwichSize>(
                segments: const [
                  ButtonSegment<SandwichSize>(
                    value: SandwichSize.sixInch,
                    label: Text('Six Inch'),
                    icon: Icon(Icons.lunch_dining),
                  ),
                  ButtonSegment<SandwichSize>(
                    value: SandwichSize.footlong,
                    label: Text('Footlong'),
                    icon: Icon(Icons.lunch_dining),
                  ),
                ],
                selected: {_currentSize},
                onSelectionChanged: (Set<SandwichSize> selected) {
                  setState(() {
                    _currentSize = selected.first;
                  });
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (states) => states.contains(MaterialState.selected)
                        ? Colors.amberAccent
                        : null,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            OrderItemDisplay(
              _quantity,
              _currentSize.displayName,
              note: _note,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Special requests',
                  hintText: 'e.g., no onions, extra pickles',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _note = value;
                  });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StyledButton(
                  onPressed:
                      _quantity < widget.maxQuantity ? _increaseQuantity : null,
                  icon: Icons.add,
                  label: 'Add',
                  backgroundColor: Colors.green,
                ),
                const SizedBox(width: 12),
                StyledButton(
                  onPressed: _quantity > 0 ? _decreaseQuantity : null,
                  icon: Icons.remove,
                  label: 'Remove',
                  backgroundColor: Colors.red,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class OrderItemDisplay extends StatelessWidget {
  final String itemType;
  final int quantity;
  final String? note;

  const OrderItemDisplay(this.quantity, this.itemType, {this.note, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 80,
      color: Colors.amberAccent,
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        '$quantity $itemType sandwich(es): ${'🥪' * quantity}'
        '${note != null && note!.isNotEmpty ? '\nNote: $note' : ''}',
        textAlign: TextAlign.center,
      ),
    );
  }
}

/// A small reusable button with the common styling used for Add/Remove actions.
class StyledButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final String label;
  final Color backgroundColor;
  final Color foregroundColor;
  final EdgeInsetsGeometry? padding;

  const StyledButton({
    super.key,
    this.onPressed,
    required this.icon,
    required this.label,
    this.backgroundColor = Colors.blue,
    this.foregroundColor = Colors.white,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 20),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        // colors used when the button is disabled
        disabledBackgroundColor: backgroundColor.withOpacity(0.45),
        disabledForegroundColor: foregroundColor.withOpacity(0.65),
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}

class OrderItemsList extends StatelessWidget {
  const OrderItemsList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OrderItemDisplay(5, 'Footlong'),
        OrderItemDisplay(2, 'Six Inch'),
        OrderItemDisplay(3, 'Wrap'),
      ],
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'My Sandwich Shop'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
