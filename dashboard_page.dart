import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'tourist_demographics_card.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<_SidebarItemData> _sidebarItems = [
    _SidebarItemData("Dashboard", Icons.dashboard, '/dashboard'),
    _SidebarItemData("Visitor Tracking", Icons.people, '/visitortracking'),
    _SidebarItemData("Resort Management", Icons.beach_access, '/resortmanagement'),
    _SidebarItemData("Environmental Fees", Icons.attach_money, '/environmentalfees'),
    _SidebarItemData("Itineraries", Icons.map, '/itineraries'),
    _SidebarItemData("Analytics", Icons.bar_chart, '/analytics'),
  ];

  String get _currentRoute => ModalRoute.of(context)?.settings.name ?? '/dashboard';

  void _onSidebarItemTap(String route) {
    if (route != _currentRoute) {
      Navigator.pushReplacementNamed(context, route);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    Widget sidebar = _Sidebar(
      sidebarItems: [
        ..._sidebarItems,
        _SidebarItemData("Settings", Icons.settings, '/settings'),
      ],
      currentRoute: _currentRoute,
      onSidebarItemTap: (route) {
        _onSidebarItemTap(route);
      },
    );

    Widget mainContent = Column(
      children: [
        isMobile
            ? _DashboardMobileAppBar(
                onMenuTap: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
                onProfileTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Profile'),
                      content: Text('Admin\nadmin@lobo.ph'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Close'),
                        ),
                      ],
                    ),
                  );
                },
              )
            : _DashboardAppBar(
                onProfileTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Profile'),
                      content: Text('Admin\nadmin@lobo.ph'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Close'),
                        ),
                      ],
                    ),
                  );
                },
              ),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(isMobile ? 12 : 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Summary cards row
                Wrap(
                  spacing: isMobile ? 12 : 24,
                  runSpacing: isMobile ? 12 : 24,
                  children: [
                    _SummaryCard(
                      title: "Total Tourists",
                      value: "12,340",
                      subtitle: "This year",
                      icon: Icons.people,
                      color: Colors.teal,
                    ),
                    _SummaryCard(
                      title: "Active Resorts",
                      value: "24",
                      subtitle: "Currently operating",
                      icon: Icons.beach_access,
                      color: Colors.orange,
                    ),
                    _SummaryCard(
                      title: "Fees Collected",
                      value: "₱1.2M",
                      subtitle: "2024 YTD",
                      icon: Icons.attach_money,
                      color: Colors.green,
                    ),
                    _SummaryCard(
                      title: "Itineraries",
                      value: "320",
                      subtitle: "Created this year",
                      icon: Icons.map,
                      color: Colors.blue,
                    ),
                  ],
                ),
                SizedBox(height: isMobile ? 16 : 32),
                // Charts and lists
                isMobile
                    ? Column(
                        children: [
                          _TouristVolumeChart(),
                          SizedBox(height: 16),
                          TouristDemographicsCard(),
                          SizedBox(height: 16),
                          _RecentTouristLogins(),
                          SizedBox(height: 16),
                          _TopResortsCard(),
                          SizedBox(height: 16),
                          _QuickActionsCard(),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Left column
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                _TouristVolumeChart(),
                                const SizedBox(height: 24),
                                TouristDemographicsCard(),
                                const SizedBox(height: 24),
                                _RecentTouristLogins(),
                              ],
                            ),
                          ),
                          const SizedBox(width: 24),
                          // Right column
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                _TopResortsCard(),
                                const SizedBox(height: 24),
                                _QuickActionsCard(),
                              ],
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ],
    );

    return Scaffold(
      key: _scaffoldKey,
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
          // Branding/logo
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
          // Sidebar navigation items
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
                        Navigator.of(context).maybePop(); // close drawer if open
                        onSidebarItemTap(item.route);
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
          // User info/profile section
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: Colors.teal.shade800),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Admin",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        "admin@lobo.ph",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 12,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.logout, color: Colors.white.withOpacity(0.8)),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: const Color(0xFFF6FBFA),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                        title: const Text(
                          'Confirm Logout',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black87),
                        ),
                        content: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'Are you sure you want to log out?',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, color: Colors.black87),
                          ),
                        ),
                        actionsAlignment: MainAxisAlignment.center,
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.teal.shade700,
                                  textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                ),
                                child: const Text('Cancel'),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal.shade700,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                elevation: 0,
                              ),
                              child: const Text('Logout', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                              onPressed: () {
                                Navigator.pop(context); // Close dialog
                                Navigator.pushReplacementNamed(context, '/'); // Go to login page
                              },
                            ),
                          ),
                        ],
                      ),
                    );
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

class _SidebarItemData {
  final String title;
  final IconData icon;
  final String route;
  const _SidebarItemData(this.title, this.icon, this.route);
}

class _DashboardAppBar extends StatelessWidget {
  final VoidCallback? onProfileTap;
  const _DashboardAppBar({this.onProfileTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          const Text(
            "Lobo Tourism Management Dashboard",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.teal),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: onProfileTap,
            child: CircleAvatar(
              backgroundColor: Colors.teal.shade100,
              child: const Icon(Icons.account_circle, color: Colors.teal, size: 28),
            ),
          ),
        ],
      ),
    );
  }
}

class _DashboardMobileAppBar extends StatelessWidget {
  final VoidCallback onMenuTap;
  final VoidCallback? onProfileTap;
  const _DashboardMobileAppBar({required this.onMenuTap, this.onProfileTap});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.teal.shade800,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.menu, color: Colors.white),
        onPressed: onMenuTap,
      ),
      title: const Text(
        "Lobo Tourism Dashboard",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_none, color: Colors.white),
          onPressed: () {},
        ),
        GestureDetector(
          onTap: onProfileTap,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: const Icon(Icons.account_circle, color: Colors.teal, size: 28),
          ),
        ),
        SizedBox(width: 8),
      ],
    );
  }
}

// Minimal placeholder widgets for missing classes

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color color;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    return Card(
      elevation: 3,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Container(
        width: isMobile ? double.infinity : 210,
        constraints: BoxConstraints(minWidth: 150, maxWidth: isMobile ? double.infinity : 220),
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(8),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 10),
            Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color)),
            const SizedBox(height: 4),
            Text(title, style: TextStyle(fontSize: 15, color: Colors.black87)),
            const SizedBox(height: 6),
            Text(subtitle, style: TextStyle(fontSize: 13, color: color)),
          ],
        ),
      ),
    );
  }
}

class _TouristVolumeChart extends StatelessWidget {
  final List<FlSpot> _chartData = const [
    FlSpot(0, 1200),
    FlSpot(1, 1500),
    FlSpot(2, 1800),
    FlSpot(3, 1700),
    FlSpot(4, 2100),
    FlSpot(5, 2500),
    FlSpot(6, 2300),
    FlSpot(7, 2600),
    FlSpot(8, 2800),
    FlSpot(9, 3000),
    FlSpot(10, 3200),
    FlSpot(11, 3100),
  ];

  final List<String> _months = const [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        height: 240,
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Tourist Volume (Monthly)",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: true, drawVerticalLine: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true, reservedSize: 40),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          int idx = value.toInt();
                          if (idx < 0 || idx >= _months.length) return const SizedBox.shrink();
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(_months[idx], style: const TextStyle(fontSize: 12)),
                          );
                        },
                        interval: 1,
                      ),
                    ),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  minY: 0,
                  lineBarsData: [
                    LineChartBarData(
                      spots: _chartData,
                      isCurved: true,
                      color: Colors.teal,
                      barWidth: 3,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(show: true, color: Colors.teal.withOpacity(0.15)),
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
}

class _TopResortsCard extends StatelessWidget {
  final List<Map<String, dynamic>> _topResorts = const [
    {'name': 'Aqua Paradise Resort', 'visits': 3100},
    {'name': 'Emerald Bay Resort', 'visits': 2800},
    {'name': 'Sunnyside Beach Resort', 'visits': 2500},
    {'name': 'Coral Cove', 'visits': 2100},
    {'name': 'Palm Springs', 'visits': 1800},
    {'name': 'Blue Waters Resort', 'visits': 1700},
    {'name': 'Lobo Beach House', 'visits': 1600},
    {'name': 'Sunset Point', 'visits': 1500},
    {'name': 'White Sand Haven', 'visits': 1400},
    {'name': 'Batangas Bay Resort', 'visits': 1300},
  ];

  const _TopResortsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Top 10 Most Visited Resorts in Lobo, Batangas",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),
            ..._topResorts.asMap().entries.map((entry) {
              int idx = entry.key + 1;
              var resort = entry.value;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: idx == 1
                          ? Colors.amber.shade400
                          : idx == 2
                              ? Colors.grey.shade400
                              : idx == 3
                                  ? Colors.brown.shade300
                                  : Colors.teal.shade100,
                      child: Text('$idx', style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        resort['name'],
                        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                      ),
                    ),
                    Text(
                      '${resort['visits']} visits',
                      style: const TextStyle(fontSize: 13, color: Colors.teal, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _RecentTouristLogins extends StatelessWidget {
  final List<Map<String, String>> _logins = const [
    {
      'name': 'Juan Dela Cruz',
      'resort': 'Aqua Paradise',
      'time': '10:15 AM',
    },
    {
      'name': 'Maria Santos',
      'resort': 'Emerald Bay',
      'time': '09:50 AM',
    },
    {
      'name': 'Jose Rizal',
      'resort': 'Sunnyside Beach',
      'time': '09:30 AM',
    },
    {
      'name': 'Ana Lopez',
      'resort': 'Aqua Paradise',
      'time': '09:10 AM',
    },
    {
      'name': 'Pedro Pascual',
      'resort': 'Emerald Bay',
      'time': '08:55 AM',
    },
  ];

  const _RecentTouristLogins({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Recent Tourist Logins",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),
            ..._logins.map((login) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.teal.shade100,
                        child: Icon(Icons.person, color: Colors.teal.shade700),
                        radius: 18,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              login['name'] ?? '',
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                            Text(
                              login['resort'] ?? '',
                              style: const TextStyle(fontSize: 12, color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        login['time'] ?? '',
                        style: const TextStyle(fontSize: 12, color: Colors.teal, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class _QuickActionsCard extends StatelessWidget {
  const _QuickActionsCard({Key? key}) : super(key: key);

  void _exportData(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 1));
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Export Data'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Exporting visitor tracking data as CSV...'),
            SizedBox(height: 12),
            Text('Sample Data:'),
            SizedBox(height: 6),
            SelectableText(
              'Name,Resort,Date,Fee\n'
              'Maxene Jarlego,Aqua Paradise,2024-07-18,₱50.00\n'
              'Jayne Hernandez,Emerald Bay,2024-07-18,₱50.00\n'
              'Liza Dela Rosa,Sunnyside Beach,2024-07-18,₱50.00',
              style: TextStyle(fontFamily: 'monospace', fontSize: 13),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _generateReport(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 1));
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Generate Report'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Visitor Report Summary:'),
            SizedBox(height: 10),
            Text('• Total Tourists: 15,823'),
            Text('• Most Visited Resort: Aqua Paradise Resort (3,100 visits)'),
            Text('• Environmental Fees Collected: ₱45,210.00'),
            Text('• Peak Visiting Day: Saturday'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _manageResorts(BuildContext context) {
    Navigator.of(context).pushReplacementNamed('/resortmanagement');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: const Color(0xFFF6FBFA),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Quick Actions",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.file_download, color: Colors.white),
              label: const Text(
                "Export Data",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal.shade700,
                minimumSize: const Size.fromHeight(44),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 0,
              ),
              onPressed: () => _exportData(context),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              icon: const Icon(Icons.insert_chart, color: Colors.white),
              label: const Text(
                "Generate Report",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange.shade700,
                minimumSize: const Size.fromHeight(44),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 0,
              ),
              onPressed: () => _generateReport(context),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              icon: const Icon(Icons.settings, color: Colors.white),
              label: const Text(
                "Manage Resorts",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
                minimumSize: const Size.fromHeight(44),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 0,
              ),
              onPressed: () => _manageResorts(context),
            ),
          ],
        ),
      ),
    );
  }
}
