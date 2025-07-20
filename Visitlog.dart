import 'package:flutter/material.dart';
import 'package:tourist_page/Itinerary.dart';
import 'package:tourist_page/home.dart';
import 'package:tourist_page/helpcenter.dart' hide DashboardPage; // Import your HelpCenterPage

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Tourist Navigator',
    home: VisitLogScreen(),
    routes: {
      '/home': (context) => const DashboardPage(),
      '/visitlog': (context) => VisitLogScreen(),
      '/itinerary': (context) => const ItineraryScreen(),
      '/helpcenter': (context) => const HelpCenterScreen(),
    },
  ));
}

class VisitLogScreen extends StatelessWidget {
  final List<Visit> visits = [
    Visit('2023-11-15', '5 Days', 'Serenidad Beach Resort', 3),
    Visit('2023-10-28', '3 Days', 'Punta Verde Resort', 2),
    Visit('2023-09-01', '7 Days', 'De Marvic Beach Resort', 4),
    Visit('2023-08-10', '4 Days', 'Gerthel Beach', 2),
    Visit('2023-07-22', '2 Days', 'Honey Beach Resort', 1),
    Visit('2023-06-05', '6 Days', 'Lawas Seaside Beach Resort', 5),
    Visit('2023-05-18', '3 Days', 'Submarine Garden Resort', 2),
    Visit('2023-04-01', '5 Days', 'Playa De Oro Beach Resort', 3),
    Visit('2023-03-10', '4 Days', 'Punta Malabrigo Beach Resort', 2),
    Visit('2023-02-20', '3 Days', 'RockView Beach Resort', 4),
  ];

  VisitLogScreen({super.key});

  double get averageDuration =>
      visits.map((v) => int.parse(v.duration.split(' ')[0])).reduce((a, b) => a + b) / visits.length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visit Log', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: const Color(0xFF008943),
        elevation: 0,
      ),
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
            _drawerItem(
              context,
              icon: Icons.home,
              title: "Home",
              selected: false,
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/home');
              },
            ),
            _drawerItem(
              context,
              icon: Icons.history,
              title: "Visit Log",
              selected: true,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            _drawerItem(
              context,
              icon: Icons.map,
              title: "Itinerary",
              selected: false,
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/itinerary');
              },
            ),
            _drawerItem(
              context,
              icon: Icons.help_center,
              title: "Help Center",
              selected: false,
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HelpCenterPage()),
                );
              },
            ),
            // Move Log Out directly after Help Center
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.black87),
              title: const Text('Log Out', style: TextStyle(color: Colors.black87)),
              onTap: () {
                Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
              },
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              hoverColor: Colors.red.withOpacity(0.08),
            ),
            const Spacer(),
            const Divider(),
            const SizedBox(height: 12),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF6FAF9), Color(0xFFE0F2F1)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                child: Row(
                  children: [
                    const Icon(Icons.history, color: Color(0xFF008943), size: 32),
                    const SizedBox(width: 12),
                    const Text(
                      'My Visit Log',
                      style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF008943)),
                    ),
                    const Spacer(),
                    Chip(
                      label: Text(
                        'Avg. Duration: ${averageDuration.toStringAsFixed(1)} days',
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      backgroundColor: Colors.teal,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(24),
                  padding: const EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.07),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                        decoration: BoxDecoration(
                          color: Colors.teal[50],
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(22),
                            topRight: Radius.circular(22),
                          ),
                        ),
                        child: Row(
                          children: const [
                            Expanded(child: Text('Date', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54))),
                            Expanded(child: Text('Duration', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54))),
                            Expanded(child: Text('Attractions', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54))),
                            Expanded(child: Text('Guests', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54))),
                            Expanded(child: Text('Fee', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54))),
                          ],
                        ),
                      ),
                      const Divider(height: 0, thickness: 1),
                      Expanded(
                        child: ListView.separated(
                          itemCount: visits.length,
                          separatorBuilder: (_, __) => const Divider(height: 0),
                          itemBuilder: (context, index) {
                            final v = visits[index];
                            return Material(
                              color: index % 2 == 0 ? Colors.white : Colors.teal.withOpacity(0.03),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                                child: Row(
                                  children: [
                                    Expanded(child: Text(v.date, style: const TextStyle(fontSize: 15))),
                                    Expanded(child: Text(v.duration, style: const TextStyle(fontSize: 15))),
                                    Expanded(child: Text(v.attractions, style: const TextStyle(fontSize: 15))),
                                    Expanded(child: Text('${v.guests}', style: const TextStyle(fontSize: 15))),
                                    Expanded(child: Text('₱20.00', style: const TextStyle(fontSize: 15, color: Color(0xFF008943), fontWeight: FontWeight.bold))),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 18),
                child: Text(
                  "Tourist Navigator © 2025",
                  style: TextStyle(
                    color: Colors.teal[700],
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _drawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required bool selected,
    required VoidCallback onTap,
  }) {
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

class Visit {
  final String date;
  final String duration;
  final String attractions;
  final int guests;

  Visit(this.date, this.duration, this.attractions, this.guests);
}

// Placeholder Help Center screen
class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Help Center')),
      body: const Center(child: Text('Help Center Content Here')),
    );
  }
}
