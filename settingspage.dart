import 'package:flutter/material.dart';
// Import the file where AdminProfile is defined

class _SidebarItemData {
  final String title;
  final IconData icon;
  final String route;
  const _SidebarItemData(this.title, this.icon, this.route);
}

class _Sidebar extends StatelessWidget {
  final List<_SidebarItemData> sidebarItems;
  final String currentRoute;
  final Function(String) onSidebarItemTap;

  const _Sidebar({
    required this.sidebarItems,
    required this.currentRoute,
    required this.onSidebarItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.teal.shade800,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 8,
            offset: const Offset(2, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.explore, color: Colors.white, size: 32),
                const SizedBox(width: 10),
                Text(
                  "Lobo Tourism",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),
          Divider(color: Colors.white.withOpacity(0.15), thickness: 1),
          Expanded(
            child: ListView.builder(
              itemCount: sidebarItems.length,
              itemBuilder: (context, index) {
                final item = sidebarItems[index];
                final selected = item.route == currentRoute;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
                  child: Material(
                    color: selected ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {
                        if (!selected) {
                          Navigator.pushReplacementNamed(context, item.route);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                        child: Row(
                          children: [
                            Icon(
                              item.icon,
                              color: selected ? Colors.teal.shade800 : Colors.white,
                              size: 24,
                            ),
                            const SizedBox(width: 16),
                            Text(
                              item.title,
                              style: TextStyle(
                                color: selected ? Colors.teal.shade800 : Colors.white,
                                fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: Colors.teal.shade800),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    "Admin",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.logout, color: Colors.white.withOpacity(0.8)),
                  onPressed: () {
                    // Add logout logic here
                  },
                  tooltip: "Logout",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkMode = false;


  void _navigateToChangePassword(BuildContext context) {
    Navigator.pushNamed(context, '/changepassword');
  }


  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Confirm Logout',
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Are you sure you want to log out from Lobo Tourism Management?\nYou will need to sign in again to access your account.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Checkbox(value: false, onChanged: null), // Placeholder for "Keep me logged in"
                const Expanded(child: Text("Keep me logged in for 30 days on this device")),
              ],
            ),
          ],
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () async {
                // Example: Clear session or token here if you use shared_preferences or similar
                // final prefs = await SharedPreferences.getInstance();
                // await prefs.clear();

                Navigator.of(context).pop(); // Close dialog
                Navigator.pushReplacementNamed(context, '/login'); // Go to login page
              },
              child: const Text('Logout', style: TextStyle(color: Colors.white)),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Stay Logged In'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    final List<_SidebarItemData> sidebarItems = [
      _SidebarItemData("Dashboard", Icons.dashboard, '/dashboard'),
      _SidebarItemData("Visitor Tracking", Icons.people, '/visitortracking'),
      _SidebarItemData("Resort Management", Icons.beach_access, '/resortmanagement'),
      _SidebarItemData("Environmental Fees", Icons.attach_money, '/environmentalfees'),
      _SidebarItemData("Itineraries", Icons.map, '/itineraries'),
      _SidebarItemData("Analytics", Icons.bar_chart, '/analytics'),
      _SidebarItemData("Settings", Icons.settings, '/settings'),
    ];
    final String currentRoute = ModalRoute.of(context)?.settings.name ?? '/settings';

    Widget sidebar = _Sidebar(
      sidebarItems: sidebarItems,
      currentRoute: currentRoute,
      onSidebarItemTap: (route) {
        if (route != currentRoute) {
          Navigator.pushReplacementNamed(context, route);
        }
      },
    );

    Widget mainContent = Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: 600),
        padding: EdgeInsets.all(isMobile ? 12 : 32),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: isMobile ? 18 : 32, horizontal: isMobile ? 12 : 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Account",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
                ),
                const SizedBox(height: 12),
                ListTile(
                  leading: const Icon(Icons.lock, color: Colors.teal),
                  title: const Text("Change Password"),
                  subtitle: const Text("Update your account password"),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () => _navigateToChangePassword(context),
                ),
                ListTile(
                  leading: const Icon(Icons.settings_applications, color: Colors.teal),
                  title: const Text("Other Settings"),
                  subtitle: const Text("Manage other application settings"),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/othersettings');
                  },
                ),
                const Divider(height: 32),
                const Text(
                  "App Preferences",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
                ),
                const SizedBox(height: 12),
                SwitchListTile(
                  value: isDarkMode,
                  onChanged: (val) {
                    setState(() {
                      isDarkMode = val;
                    });
                    // Add dark mode toggle logic here (e.g., update theme)
                  },
                  title: const Text("Dark Mode"),
                  secondary: const Icon(Icons.dark_mode, color: Colors.teal),
                ),
                const Divider(height: 32),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const Text("Logout", style: TextStyle(color: Colors.red)),
                  onTap: () => _showLogoutDialog(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF6FBFA),
      appBar: isMobile
          ? AppBar(
              backgroundColor: Colors.teal.shade800,
              title: const Text(
                'Settings',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              iconTheme: const IconThemeData(color: Colors.white),
              elevation: 0,
              leading: Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu, color: Colors.white),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              ),
            )
          : null,
      drawer: isMobile
          ? Drawer(
              child: SafeArea(
                child: sidebar,
              ),
            )
          : null,
      body: isMobile
          ? SafeArea(child: mainContent)
          : Row(
              children: [
                SizedBox(
                  width: 250,
                  child: sidebar,
                ),
                Expanded(child: mainContent),
              ],
            ),
    );
  }
}