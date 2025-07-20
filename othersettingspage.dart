import 'package:flutter/material.dart';

class OtherSettingsPage extends StatelessWidget {
  const OtherSettingsPage({super.key});

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Lobo Tourism Management',
      applicationVersion: '1.0.0',
      applicationLegalese: '© 2025 Lobo Tourism',
    );
  }

  void _clearCache(BuildContext context) {
    // Example function for clearing cache
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Cache cleared!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = MediaQuery.of(context).size.width < 700;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor ?? Colors.teal.shade800,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/settings');
          },
        ),
        title: const Text(
          'Other Settings',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 500),
          padding: EdgeInsets.all(isMobile ? 12 : 32),
          child: Card(
            color: theme.cardColor,
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.settings_applications, size: 48, color: Colors.teal),
                  const SizedBox(height: 16),
                  const Text(
                    "Other Settings",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.teal),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "You can add more settings options here.",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  ListTile(
                    leading: const Icon(Icons.info_outline, color: Colors.teal),
                    title: const Text("About"),
                    onTap: () => _showAboutDialog(context),
                  ),
                  ListTile(
                    leading: const Icon(Icons.cleaning_services, color: Colors.teal),
                    title: const Text("Clear Cache"),
                    onTap: () => _clearCache(context),
                  ),
                  // Add more ListTile widgets for additional settings functions
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}