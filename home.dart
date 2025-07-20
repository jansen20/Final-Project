import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'Visitlog.dart';
import 'Itinerary.dart';
import 'helpcenter.dart';
import 'userlogin.dart';
void main() {
  runApp(const TouristNavigatorApp());
}

class TouristNavigatorApp extends StatelessWidget {
  const TouristNavigatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tourist Navigator',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[50],
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 0, 150, 75)),
        useMaterial3: true,
        fontFamily: 'Segoe UI',
      ),
      home: DashboardPage(),
      routes: {
        '/home': (context) => DashboardPage(),
        '/visitlog': (context) => VisitLogScreen(),
        '/itinerary': (context) => const ItineraryScreen(),
        '/helpcenter': (context) => const HelpCenterScreen(),
        // '/logout': (context) => const _LogoutScreen(),
        '/login': (context) => const LoginPage(),
      },
    );
  }
}

// ignore: must_be_immutable
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  static const List<String> attractionTitles = [
    "Malabrigo Lighthouse",
    "Submarine Garden Beach Resort",
    "Honey Beach Resort",
    "Serenidad Beach Resort"
  ];
  static const List<String> attractionLocations = [
    "Malabrigo, Lobo, Batangas",
    "Sawang, Lobo, Batangas",
    "Sawang, Lobo, Batangas",
    "Malabrigo, Lobo, Batangas"
  ];
  static const List<String> attractionImages = [
    "https://upload.wikimedia.org/wikipedia/commons/3/3a/Malabrigo_Lighthouse_2017.jpg",
    "https://www.lakwatsero.com/wp-content/uploads/2018/06/submarinegarden1.jpg",
    "https://media-cdn.tripadvisor.com/media/photo-s/0e/2d/7f/2b/honey-beach-resort.jpg",
    "https://media-cdn.tripadvisor.com/media/photo-s/0e/2d/7f/2b/serenidad-beach-resort.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color.fromARGB(255, 0, 150, 75), Color.fromARGB(255, 2, 138, 59)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: const Row(
            children: [
              Icon(Icons.travel_explore, color: Colors.white),
              SizedBox(width: 8),
              Text('Tourist Navigator', style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 0, 150, 75),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 36, color: Color.fromARGB(255, 0, 150, 75)),
                  ),
                  SizedBox(height: 12),
                  Text('Welcome, Traveler!', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text('tourist@email.com', style: TextStyle(color: Colors.white70, fontSize: 13)),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Visit Log'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/visitlog');
              },
            ),
            ListTile(
              leading: const Icon(Icons.map),
              title: const Text('Itinerary'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/itinerary');
              },
            ),
            ListTile(
              leading: const Icon(Icons.help_center),
              title: const Text('Help Center'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HelpCenterPage()),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log Out', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
              },
            ),
          ],
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 700;
          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // HERO BANNER
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 48, vertical: isMobile ? 24 : 36),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.teal.shade300, Colors.teal.shade700],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome Back, Traveler!",
                              style: TextStyle(
                                fontSize: isMobile ? 26 : 34,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Your personalized dashboard for tracking visits, planning new adventures, and getting support for your journeys.",
                              style: TextStyle(fontSize: 16, color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                      if (!isMobile)
                        Padding(
                          padding: const EdgeInsets.only(left: 32),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              "https://upload.wikimedia.org/wikipedia/commons/3/3a/Malabrigo_Lighthouse_2017.jpg",
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Center(child: CircularProgressIndicator()),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) => Container(
                                color: Colors.teal[50],
                                width: 100,
                                height: 100,
                                child: const Center(child: Icon(Icons.image, size: 40, color: Color.fromARGB(255, 0, 150, 72))),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: isMobile ? 0 : 16),
                  child: Column(
                    children: [
                      Wrap(
                        spacing: 24,
                        runSpacing: 24,
                        children: [
                          SizedBox(width: isMobile ? double.infinity : 420, child: _currentVisitSummary(context)),
                          SizedBox(width: isMobile ? double.infinity : 420, child: _recentVisitLogs(context)),
                          SizedBox(width: isMobile ? double.infinity : 900, child: _suggestedAttractions(isMobile)),
                        ],
                      ),
                      const SizedBox(height: 24),
                      _annualVisitorTrends(context),
                      const SizedBox(height: 24),
                      _topVisitedResorts(context),
                    ],
                  ),
                ),
                const SizedBox(height: 48),
                _footerSection(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _currentVisitSummary(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(Icons.summarize, color: Colors.teal),
                SizedBox(width: 8),
                Text("Current Visit Summary", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal)),
              ],
            ),
            const Divider(),
            const SizedBox(height: 8),
            _infoRow(Icons.hotel, "Resort Name", "Elysian Sands Resort & Spa"),
            _infoRow(Icons.people, "Total Guests", "4"),
            _infoRow(Icons.date_range, "Visit Dates", "August 12–19, 2024"),
            _infoRow(Icons.timer, "Duration", "7 Days, 6 Nights"),
            _infoRow(Icons.eco, "Environmental Fee", "₱120.00"),
          ],
        ),
      ),
    );
  }

  Widget _recentVisitLogs(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(Icons.history, color: Colors.teal),
                SizedBox(width: 8),
                Text("Recent Visit Log Entries", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal)),
              ],
            ),
            const Divider(),
            const SizedBox(height: 8),
            _logEntry("July 25, 2024", "El Nido Tour A, Coron Island", "₱60.00"),
            _logEntry("June 10, 2024", "Boracay White Beach", "₱90.00"),
            _logEntry("May 01, 2024", "Banaue Rice Terraces", "₱40.00"),
          ],
        ),
      ),
    );
  }

  Widget _suggestedAttractions(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Suggested Attractions Near You",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: isMobile ? 350 * attractionTitles.length.toDouble() : 400, // Increased height
          child: GridView.count(
            crossAxisCount: isMobile ? 1 : 4,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: isMobile ? 1 : 0.68, // Make cards taller
            children: List.generate(
              attractionTitles.length,
              (index) => _attractionCard(
                index,
                attractionTitles,
                attractionLocations,
                attractionImages,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _attractionCard(int index, List<String> titles, List<String> locations, List<String> images) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 140, // Slightly reduced for better fit
            width: double.infinity,
            child: Image.network(
              images[index],
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(child: CircularProgressIndicator());
              },
              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.teal[50],
                child: const Center(child: Icon(Icons.image, size: 40, color: Color.fromARGB(255, 0, 150, 72))),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(titles[index], style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(locations[index], style: const TextStyle(color: Colors.black54)),
                const SizedBox(height: 4),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add_location_alt, size: 18),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(100, 36),
                  ),
                  label: const Text("Plan Visit"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _topVisitedResorts(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(Icons.star, color: Colors.teal),
                SizedBox(width: 8),
                Text("Top Visited Resorts", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal)),
              ],
            ),
            const Divider(),
            const SizedBox(height: 8),
            _resortRow("Punta Verde Resort", "₱350"),
            _resortRow("Gerthel Beach", "₱420"),
            _resortRow("Coral Cove", "₱280"),
            _resortRow("Paraiso Verde", "₱310"),
            _resortRow("Sunset Bay", "₱380"),
          ],
        ),
      ),
    );
  }

  Widget _annualVisitorTrends(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(Icons.show_chart, color: Colors.teal),
                SizedBox(width: 8),
                Text("Annual Visitor Trends", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal)),
              ],
            ),
            const Divider(),
            const SizedBox(height: 8),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: true, drawVerticalLine: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true, reservedSize: 32),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
                          if (value.toInt() >= 0 && value.toInt() < months.length) {
                            return Text(months[value.toInt()], style: const TextStyle(fontSize: 12));
                          }
                          return const SizedBox.shrink();
                        },
                        reservedSize: 28,
                      ),
                    ),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: true, border: Border.all(color: Colors.teal, width: 1)),
                  minX: 0,
                  maxX: 5,
                  minY: 0,
                  maxY: 100,
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        FlSpot(0, 30),
                        FlSpot(1, 50),
                        FlSpot(2, 40),
                        FlSpot(3, 70),
                        FlSpot(4, 60),
                        FlSpot(5, 90),
                      ],
                      isCurved: true,
                      color: Colors.teal,
                      barWidth: 3,
                      dotData: FlDotData(show: true),
                      // ignore: deprecated_member_use
                      belowBarData: BarAreaData(show: true, color: Colors.teal.withOpacity(0.12)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _footerSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: const [
          Text("Tourist Navigator", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color.fromARGB(255, 0, 150, 60))),
          SizedBox(height: 6),
          Text("Stay updated on the latest travel destinations and tips!"),
          SizedBox(height: 12),
          Text("Made with ❤️ using Flutter", style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  // Helper widgets for info rows
  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.teal),
          const SizedBox(width: 8),
          Text("$label: ", style: const TextStyle(fontWeight: FontWeight.w500)),
          Expanded(child: Text(value, style: const TextStyle(color: Colors.black87))),
        ],
      ),
    );
  }

  Widget _logEntry(String date, String place, String fee) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          const Icon(Icons.check_circle, size: 16, color: Colors.teal),
          const SizedBox(width: 8),
          Text(date, style: const TextStyle(fontWeight: FontWeight.w500)),
          const SizedBox(width: 8),
          Expanded(child: Text(place)),
          Text(fee, style: const TextStyle(color: Colors.teal)),
        ],
      ),
    );
  }

  Widget _resortRow(String name, String fee) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          const Icon(Icons.place, size: 16, color: Colors.teal),
          const SizedBox(width: 8),
          Expanded(child: Text(name)),
          Text(fee, style: const TextStyle(color: Colors.teal)),
        ],
      ),
    );
  }
}

// Help Center Screen with Drawer Navigation
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
                Navigator.popUntil(context, (route) => route.isFirst);
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