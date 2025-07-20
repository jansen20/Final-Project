import 'package:flutter/material.dart';
import 'package:tourist_page/home.dart';
import 'package:tourist_page/Visitlog.dart' hide HelpCenterScreen;
import 'package:tourist_page/helpcenter.dart' as helpcenter hide DashboardPage;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tourist Navigator',
      theme: ThemeData(
        primarySwatch: Colors.green,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green).copyWith(
          primary: const Color.fromARGB(255, 0, 137, 68),
          secondary: const Color.fromARGB(255, 0, 137, 68),
        ),
        fontFamily: 'Segoe UI',
        scaffoldBackgroundColor: const Color(0xFFE0F2F1),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      initialRoute: '/itinerary',
      routes: {
        '/home': (context) => const DashboardPage(),
        '/visitlog': (context) => VisitLogScreen(),
        '/itinerary': (context) => const ItineraryScreen(),
        '/helpcenter': (context) => const helpcenter.HelpCenterScreen(),
        // '/logout': (context) => const _LogoutScreen(),
      },
    );
  }
}

class ItineraryScreen extends StatefulWidget {
  const ItineraryScreen({super.key});

  @override
  State<ItineraryScreen> createState() => _ItineraryScreenState();
}

class _ItineraryScreenState extends State<ItineraryScreen> {
  int? selectedIndex;
  List<Map<String, dynamic>> plans = [
    {
      'title': 'Visit Malabrigo Lighthouse',
      'time': '9:00 AM - 11:30 AM',
      'duration': '2.5 hours',
      'location': 'Lobo, Batangas',
      'image': 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=400&q=80',
      'cost': 200,
    },
    {
      'title': 'Paraiso Verde',
      'time': '1:00 PM - 4:00 PM',
      'duration': '3 hours',
      'location': 'Lobo, Batangas',
      'image': 'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=400&q=80',
      'cost': 350,
    },
    {
      'title': 'La Playa Beach Resort',
      'time': '4:30 PM - 7:00 PM',
      'duration': '2.5 hours',
      'location': 'Lobo, Batangas',
      'image': 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=400&q=80',
      'cost': 250,
    },
    {
      'title': 'Sawang Dive Resort',
      'time': '7:30 PM - 9:00 PM',
      'duration': '1.5 hours',
      'location': 'Lobo, Batangas',
      'image': 'https://images.unsplash.com/photo-1502086223501-7ea6ecd79368?auto=format&fit=crop&w=400&q=80',
      'cost': 150,
    },
    {
      'title': 'White Sand Resort',
      'time': '8:00 AM - 12:00 PM',
      'duration': '4 hours',
      'location': 'Lobo, Batangas',
      'image': 'https://images.unsplash.com/photo-1465156799763-2c087c332922?auto=format&fit=crop&w=400&q=80',
      'cost': 480,
    },
    {
      'title': 'Sunset Bay Resort',
      'time': '9:00 AM - 3:00 PM',
      'duration': '6 hours',
      'location': 'Lobo, Batangas',
      'image': 'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=400&q=80',
      'cost': 220,
    },
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.9),
        elevation: 4,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Color(0xFF008943)),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: const Text('Itinerary', style: TextStyle(color: Color(0xFF008943), fontWeight: FontWeight.bold)),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(18)),
        ),
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
            _drawerItem(Icons.home, "Home", false, () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/home');
            }),
            _drawerItem(Icons.history, "Visit Log", false, () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/visitlog');
            }),
            _drawerItem(Icons.map, "Itinerary", true, () {
              Navigator.pop(context);
            }),
            _drawerItem(
              Icons.help_center,
              "Help Center",
              false,
              () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const helpcenter.HelpCenterPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.black, size: 28),
              title: const Text('Log Out', style: TextStyle(color: Colors.black)),
              onTap: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
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
            colors: [Color(0xFF009688), Color(0xFF1CBE5D)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Page Title & Subtitle
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 18, 24, 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Plan My Itinerary',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          )),
                      SizedBox(height: 6),
                      Text('Visualize and organize your perfect travel adventure.',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          )),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Expanded(
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 900),
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.85),
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 24,
                          offset: const Offset(0, 8),
                        ),
                      ],
                      border: Border.all(color: Colors.white.withOpacity(0.3), width: 1.5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Your Daily Plan for Tuesday, July 8, 2025',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF008943),
                            letterSpacing: 0.2,
                          ),
                        ),
                        const SizedBox(height: 18),

                        // Itinerary List
                        Expanded(
                          child: ListView.builder(
                            itemCount: plans.length,
                            itemBuilder: (context, index) {
                              final item = plans[index];
                              final isSelected = selectedIndex == index;
                              return MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = index;
                                    });
                                  },
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    margin: const EdgeInsets.symmetric(vertical: 10),
                                    decoration: BoxDecoration(
                                      color: isSelected ? const Color(0xFFE6F7EF) : Colors.white,
                                      borderRadius: BorderRadius.circular(22),
                                      border: Border(
                                        left: BorderSide(
                                          color: isSelected ? const Color(0xFF008943) : Colors.transparent,
                                          width: 7,
                                        ),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.07),
                                          blurRadius: 14,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: ListTile(
                                      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
                                      leading: ClipRRect(
                                        borderRadius: BorderRadius.circular(14),
                                        child: SizedBox(
                                          width: 72,
                                          height: 72,
                                          child: Image.network(
                                            item['image'],
                                            fit: BoxFit.cover,
                                            frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                                              if (wasSynchronouslyLoaded) return child;
                                              return AnimatedOpacity(
                                                opacity: frame == null ? 0 : 1,
                                                duration: const Duration(milliseconds: 500),
                                                child: child,
                                              );
                                            },
                                            loadingBuilder: (context, child, loadingProgress) {
                                              if (loadingProgress == null) return child;
                                              return Container(
                                                color: Colors.grey[200],
                                                child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                                              );
                                            },
                                            errorBuilder: (context, error, stackTrace) => Container(
                                              color: Colors.grey[200],
                                              child: const Center(
                                                child: Icon(Icons.broken_image, color: Colors.redAccent, size: 36),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      title: Text(
                                        item['title'],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 19,
                                          color: isSelected ? const Color(0xFF008943) : Colors.black87,
                                        ),
                                      ),
                                      subtitle: Padding(
                                        padding: const EdgeInsets.only(top: 7),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(Icons.access_time, size: 16, color: Color(0xFF008943)),
                                                const SizedBox(width: 4),
                                                Text(item['time'], style: const TextStyle(fontSize: 13)),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Icon(Icons.place, size: 16, color: Color(0xFF008943)),
                                                const SizedBox(width: 4),
                                                Text(item['location'], style: const TextStyle(fontSize: 13)),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Icon(Icons.timer, size: 16, color: Color(0xFF008943)),
                                                const SizedBox(width: 4),
                                                Text('Duration: ${item['duration']}', style: const TextStyle(fontSize: 13)),
                                              ],
                                            ),
                                            if (item['cost'] != null)
                                              Row(
                                                children: [
                                                  const Icon(Icons.attach_money, size: 16, color: Color(0xFF008943)),
                                                  const SizedBox(width: 4),
                                                  Text('₱${item['cost']}', style: const TextStyle(fontSize: 13)),
                                                ],
                                              ),
                                          ],
                                        ),
                                      ),
                                      trailing: IconButton(
                                        icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                                        tooltip: 'Delete Plan',
                                        onPressed: () async {
                                          final confirm = await showDialog<bool>(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: const Text('Delete Plan'),
                                              content: const Text('Are you sure you want to delete this plan?'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () => Navigator.pop(context, false),
                                                  child: const Text('Cancel'),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () => Navigator.pop(context, true),
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.redAccent,
                                                  ),
                                                  child: const Text('Delete'),
                                                ),
                                              ],
                                            ),
                                          );
                                          if (confirm == true) {
                                            setState(() {
                                              if (selectedIndex == index) selectedIndex = null;
                                              plans.removeAt(index);
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              );
                              },
                            ),
                          ),

                        // Summary Section
                        Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          color: const Color(0xFFe0f7fa),
                          child: Padding(
                            padding: const EdgeInsets.all(22),
                            child: selectedIndex == null
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      _summaryIcon(Icons.timer, 'Total Duration', '${_totalDuration().toStringAsFixed(1)} h'),
                                      _summaryIcon(Icons.attach_money, 'Total Cost', '₱${_totalCost()}'),
                                      _summaryIcon(Icons.place, 'Attractions', '${plans.length}'),
                                    ],
                                  )
                                : Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: const [
                                          Icon(Icons.info_outline, color: Color(0xFF008943), size: 22),
                                          SizedBox(width: 10),
                                          Text(
                                            'Selected Itinerary',
                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF008943)),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 14),
                                      Text('Title: ${plans[selectedIndex!]['title']}', style: const TextStyle(fontWeight: FontWeight.bold)),
                                      Text('Time: ${plans[selectedIndex!]['time']}'),
                                      Text('Location: ${plans[selectedIndex!]['location']}'),
                                      Text('Duration: ${plans[selectedIndex!]['duration']}'),
                                      Text('Cost: ₱${plans[selectedIndex!]['cost']}'),
                                      const Divider(),
                                      _summaryRow(Icons.timer, 'Total Duration', '${_singleDuration(selectedIndex!).toStringAsFixed(1)} hours'),
                                      const Divider(),
                                      _summaryRow(Icons.attach_money, 'Total Cost', '₱${plans[selectedIndex!]['cost']}'),
                                      const Divider(),
                                      _summaryRow(Icons.place, 'Attractions Planned', '1'),
                                      const SizedBox(height: 10),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: TextButton.icon(
                                          onPressed: () => setState(() => selectedIndex = null),
                                          icon: const Icon(Icons.arrow_back),
                                          label: const Text('Show Full Summary'),
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Drawer item helper
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

  // Summary row helper
  Widget _summaryRow(IconData icon, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: Color(0xFF008943)),
            const SizedBox(width: 6),
            Text(label, style: const TextStyle(fontSize: 14)),
          ],
        ),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      ],
    );
  }

  double _singleDuration(int index) {
    final match = RegExp(r'([\d.]+)').firstMatch(plans[index]['duration'] ?? '');
    if (match != null) {
      return double.tryParse(match.group(1) ?? '0') ?? 0;
    }
    return 0;
  }

  int _totalCost() {
    int sum = 0;
    for (var plan in plans) {
      sum += (plan['cost'] ?? 0) as int;
    }
    return sum;
  }

  double _totalDuration() {
    double sum = 0;
    for (var plan in plans) {
      final match = RegExp(r'([\d.]+)').firstMatch(plan['duration'] ?? '');
      if (match != null) {
        sum += double.tryParse(match.group(1) ?? '0') ?? 0;
      }
    }
    return sum;
  }

  // Add this helper for summary icons:
  Widget _summaryIcon(IconData icon, String label, String value) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: const Color(0xFF008943),
          child: Icon(icon, color: Colors.white),
        ),
        const SizedBox(height: 8),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        Text(label, style: const TextStyle(fontSize: 13, color: Colors.black54)),
      ],
    );
  }
}