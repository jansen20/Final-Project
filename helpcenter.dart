import 'package:flutter/material.dart';
import 'package:tourist_page/Itinerary.dart';
import 'package:tourist_page/home.dart'; // Make sure this file exports DashboardPage
import 'package:tourist_page/Visitlog.dart' hide HelpCenterScreen;

import 'userlogin.dart' show LoginPage;

void main() {
  runApp(const MyApp());
}

// Simple LogoutScreen implementation
class _LogoutScreen extends StatelessWidget {
  const _LogoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // You can add your logout logic here, for now just navigate to root after a short delay
    Future.delayed(const Duration(milliseconds: 500), () {
      Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
    });
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tourist Navigator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green).copyWith(
          primary: const Color.fromARGB(255, 0, 137, 68),
          secondary: const Color.fromARGB(255, 0, 137, 68),
        ),
        fontFamily: 'Segoe UI',
        scaffoldBackgroundColor: const Color(0xFFF6FAF9),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      initialRoute: '/helpcenter',
      routes: {
        '/': (context) => const LoginPage(),
        '/home': (context) => const ItineraryScreen(), // <--- Use this if DashboardPage is missing
        '/visitlog': (context) => VisitLogScreen(),
        '/itinerary': (context) => const ItineraryScreen(),
        '/helpcenter': (context) => const HelpCenterPage(),
        '/logout': (context) => const _LogoutScreen(),
      },
    );
  }
}

class HelpCenterPage extends StatelessWidget {
  const HelpCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF008943), Color(0xFF1CBE5D)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              accountName: const Text('Welcome, Traveler!'),
              accountEmail: const Text('tourist@email.com'),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 38, color: Color(0xFF008943)),
              ),
            ),
            _drawerItem(Icons.home, "Home", false, () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/home');
            }),
            _drawerItem(Icons.history, "Visit Log", false, () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/visitlog');
            }),
            _drawerItem(Icons.map, "Itinerary", false, () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/itinerary');
            }),
            _drawerItem(Icons.help_center, "Help Center", true, () {
              Navigator.pop(context);
            }),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Log Out', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
              },
            ),
            const Spacer(),
            const Divider(),
            const SizedBox(height: 12),
          ],
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF008943), Color(0xFF1CBE5D)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Row(
          children: [
            Icon(Icons.help_center, color: Colors.white),
            SizedBox(width: 8),
            Text('Help Center', style: TextStyle(color: Colors.white)),
          ],
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF6FAF9), Color(0xFFE0F2F1)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          children: [
            // Modern Card Banner
            Container(
              margin: const EdgeInsets.all(24),
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.teal.withOpacity(0.08),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
                border: Border.all(color: Colors.teal.shade100, width: 1.5),
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.teal.shade50,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    padding: const EdgeInsets.all(18),
                    child: const Icon(Icons.support_agent, size: 48, color: Color(0xFF008943)),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Need Help?',
                          style: TextStyle(
                            color: Color(0xFF008943),
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Find answers, resources, and support for your travel journey. Our team is here to help you every step of the way.',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // FAQ Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
              child: Text(
                'Frequently Asked Questions',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF008943)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Wrap(
                spacing: 18,
                runSpacing: 18,
                children: [
                  FAQCard(
                    title: 'General Inquiries',
                    items: const [
                      FAQItem(question: 'What is Tourist Navigator?', answer: 'Tourist Navigator helps you track and plan your visits and adventures.'),
                      FAQItem(question: 'How do I create an account?', answer: 'You can sign up using your email or through social media accounts.'),
                      FAQItem(question: 'Is it free to use?', answer: 'Yes, Tourist Navigator is free to use with optional paid features.')
                    ],
                  ),
                  FAQCard(
                    title: 'Visit Planning & Logs',
                    items: const [
                      FAQItem(question: 'How to create an itinerary?', answer: 'You can easily build one using the itinerary section.'),
                      FAQItem(question: 'Can I edit my visit log?', answer: 'Yes, you can edit, remove, and organize your log items.'),
                      FAQItem(question: 'How to download logs?', answer: 'Use the export button on the Visit Log page to download logs.')
                    ],
                  ),
                  FAQCard(
                    title: 'Support & Troubleshooting',
                    items: const [
                      FAQItem(question: 'App is not loading, what do I do?', answer: 'Try closing and reopening the app, or check your connection.'),
                      FAQItem(question: 'How to contact support?', answer: 'Visit the Help section or email us at support@touristnavigator.com.'),
                      FAQItem(question: 'Where to report bugs?', answer: 'Use the in-app Report Bug feature or email us directly.'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // Resources Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
              child: Text(
                'Explore Our Resources',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF008943)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Wrap(
                spacing: 18,
                runSpacing: 18,
                children: const [
                  ResourceCard(
                    title: 'Personalized Itineraries',
                    description: 'Create travel plans tailored to your preferences.',
                    icon: Icons.map,
                  ),
                  ResourceCard(
                    title: 'Knowledge Base',
                    description: 'Browse articles and documentation.',
                    icon: Icons.menu_book,
                  ),
                  ResourceCard(
                    title: 'Community Support',
                    description: 'Join forums and ask fellow users.',
                    icon: Icons.people,
                  ),
                  ResourceCard(
                    title: 'Administrative Guides',
                    description: 'For staff and operators managing destinations.',
                    icon: Icons.admin_panel_settings,
                  ),
                  ResourceCard(
                    title: 'Safety & Security',
                    description: 'Learn how we keep your data protected.',
                    icon: Icons.lock,
                  ),
                  ResourceCard(
                    title: 'Other Support Options',
                    description: 'Explore additional ways to get help.',
                    icon: Icons.help_outline,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 36),
            // Contact Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                color: Colors.teal.shade50,
                child: ListTile(
                  leading: const Icon(Icons.email, color: Color(0xFF008943), size: 32),
                  title: const Text('Contact Support', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF008943))),
                  subtitle: const Text('support@touristnavigator.com'),
                  trailing: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF008943),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    icon: const Icon(Icons.send),
                    label: const Text('Email Us'),
                    onPressed: () {
                      // You can add email launch logic here
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 36),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 18),
                decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: const Text(
                  "Tourist Navigator © 2025",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF008943),
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem(IconData icon, String title, bool selected, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: selected ? const Color(0xFF008943) : Colors.black54),
      title: Text(
        title,
        style: TextStyle(
          color: selected ? const Color(0xFF008943) : Colors.black87,
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: selected,
      selectedTileColor: const Color(0xFFB2F2D7),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }
}

class FAQCard extends StatelessWidget {
  final String title;
  final List<FAQItem> items;

  const FAQCard({super.key, required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 340,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF008943))),
              const SizedBox(height: 12),
              ...items.map((item) {
                return Theme(
                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    tilePadding: EdgeInsets.zero,
                    title: Row(
                      children: [
                        const Icon(Icons.question_answer, size: 20, color: Colors.teal),
                        const SizedBox(width: 8),
                        Expanded(child: Text(item.question, style: const TextStyle(fontWeight: FontWeight.w500))),
                      ],
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 28, right: 8, bottom: 8),
                        child: Text(item.answer, style: const TextStyle(color: Colors.black87)),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class FAQItem {
  final String question;
  final String answer;

  const FAQItem({required this.question, required this.answer});
}

class ResourceCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const ResourceCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
  });

  void _showResourceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(icon, color: const Color.fromARGB(255, 3, 110, 85)),
            const SizedBox(width: 8),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        content: Text(description),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => _showResourceDialog(context),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, size: 38, color: Colors.teal),
                const SizedBox(height: 14),
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF008943))),
                const SizedBox(height: 8),
                Text(description, style: const TextStyle(fontSize: 13, color: Colors.black87)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: const Center(child: Text('Dashboard Page')),
    );
  }
}

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFF008943),
              ),
              accountName: const Text('Welcome, Traveler!'),
              accountEmail: const Text('tourist@email.com'),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 38, color: Color(0xFF008943)),
              ),
            ),
            _drawerItem(context, Icons.home, "Home", false, '/home'),
            _drawerItem(context, Icons.history, "Visit Log", false, '/visitlog'),
            _drawerItem(context, Icons.map, "Itinerary", false, '/itinerary'),
            _drawerItem(context, Icons.help_center, "Help Center", true, '/helpcenter'),
            const Spacer(),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Log Out', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
              },
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Help Center', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF008943),
        elevation: 0,
      ),
      body: Center(
        child: Text(
          'Help Center Content Here',
          style: TextStyle(fontSize: 22, color: Colors.teal[900], fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _drawerItem(BuildContext context, IconData icon, String title, bool selected, String route) {
    return ListTile(
      leading: Icon(icon, color: selected ? const Color(0xFF008943) : Colors.black54),
      title: Text(
        title,
        style: TextStyle(
          color: selected ? const Color(0xFF008943) : Colors.black87,
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: selected,
      selectedTileColor: const Color(0xFFB2F2D7),
      onTap: () {
        Navigator.pop(context);
        if (!selected) {
          Navigator.pushReplacementNamed(context, route);
        }
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }
}