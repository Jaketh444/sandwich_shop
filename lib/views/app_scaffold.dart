import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final String currentRoute;
  final Widget? floatingActionButton;
  final PreferredSizeWidget? appBar;

  const AppScaffold({
    Key? key,
    required this.body,
    required this.currentRoute,
    this.floatingActionButton,
    this.appBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width > 600;
    return Scaffold(
      appBar: appBar ??
          AppBar(
            title: const Text('Sandwich Shop'),
            leading: isWideScreen
                ? null
                : Builder(
                    builder: (context) => IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                      tooltip: 'Open navigation menu',
                    ),
                  ),
          ),
      drawer: isWideScreen ? null : _buildDrawer(context),
      body: Row(
        children: [
          if (isWideScreen) _buildNavigationRail(context),
          Expanded(child: body),
        ],
      ),
      floatingActionButton: floatingActionButton,
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text('Sandwich Shop',
                style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          _buildDrawerItem(context, Icons.home, 'Home', '/'),
          _buildDrawerItem(context, Icons.person, 'Profile', '/profile'),
          _buildDrawerItem(context, Icons.shopping_cart, 'Orders', '/orders'),
          _buildDrawerItem(context, Icons.settings, 'Settings', '/settings'),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
      BuildContext context, IconData icon, String title, String route) {
    final selected = currentRoute == route;
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      selected: selected,
      onTap: () {
        Navigator.pop(context);
        if (!selected) {
          Navigator.pushReplacementNamed(context, route);
        }
      },
      selectedTileColor: Colors.blue.shade100,
      focusColor: Colors.blue.shade50,
      hoverColor: Colors.blue.shade50,
      // Accessibility
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      visualDensity: VisualDensity.compact,
    );
  }

  Widget _buildNavigationRail(BuildContext context) {
    final destinations = [
      NavigationRailDestination(
          icon: const Icon(Icons.home), label: const Text('Home')),
      NavigationRailDestination(
          icon: const Icon(Icons.person), label: const Text('Profile')),
      NavigationRailDestination(
          icon: const Icon(Icons.shopping_cart), label: const Text('Orders')),
      NavigationRailDestination(
          icon: const Icon(Icons.settings), label: const Text('Settings')),
    ];
    final routeList = ['/', '/profile', '/orders', '/settings'];
    final selectedIndex = routeList.indexOf(currentRoute);
    return NavigationRail(
      selectedIndex: selectedIndex >= 0 ? selectedIndex : 0,
      onDestinationSelected: (index) {
        final route = routeList[index];
        if (currentRoute != route) {
          Navigator.pushReplacementNamed(context, route);
        }
      },
      labelType: NavigationRailLabelType.selected,
      destinations: destinations,
      leading: const Padding(
        padding: EdgeInsets.all(8.0),
        child: CircleAvatar(
          radius: 24,
          child: Text('S'),
        ),
      ),
    );
  }
}
