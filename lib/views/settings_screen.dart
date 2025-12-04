import 'package:flutter/material.dart';
import 'package:sandwich_shop/views/app_scaffold.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      currentRoute: '/settings',
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Settings',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            SwitchListTile(
              title: const Text('Enable notifications'),
              value: true,
              onChanged: (value) {},
            ),
            ListTile(
              title: const Text('Theme'),
              trailing: DropdownButton<String>(
                value: 'Light',
                items: const [
                  DropdownMenuItem(value: 'Light', child: Text('Light')),
                  DropdownMenuItem(value: 'Dark', child: Text('Dark')),
                ],
                onChanged: (value) {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
