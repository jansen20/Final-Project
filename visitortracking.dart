import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class VisitorsTrackingPage extends StatefulWidget {
  const VisitorsTrackingPage({super.key});

  @override
  State<VisitorsTrackingPage> createState() => _VisitorsTrackingPageState();
}

class _VisitorsTrackingPageState extends State<VisitorsTrackingPage> {
  // Map sidebar items to their routes
  final List<_SidebarItemData> _sidebarItems = [
    _SidebarItemData("Dashboard", Icons.dashboard, '/dashboard'),
    _SidebarItemData("Visitor Tracking", Icons.people, '/visitortracking'),
    _SidebarItemData("Resort Management", Icons.beach_access, '/resortmanagement'),
    _SidebarItemData("Environmental Fees", Icons.attach_money, '/environmentalfees'),
    _SidebarItemData("Itineraries", Icons.map, '/itineraries'),
    _SidebarItemData("Analytics", Icons.bar_chart, '/analytics'),
  ];



  String get _currentRoute => ModalRoute.of(context)?.settings.name ?? '/VisitorTracking';

  @override
  Widget build(BuildContext context) {
    final isPhone = MediaQuery.of(context).size.width < 700;
    return Scaffold(
      drawer: isPhone ? _SidebarDrawer(sidebarItems: _sidebarItems, currentRoute: _currentRoute) : null,
      appBar: isPhone
          ? AppBar(
              backgroundColor: Colors.teal.shade700,
              elevation: 0,
              title: const Text("Lobo Tourism", style: TextStyle(color: Colors.white)),
              iconTheme: const IconThemeData(color: Colors.white),
            )
          : null,
      body: Row(
        children: [
          if (!isPhone)
            SizedBox(
              width: 250,
              child: _Sidebar(
                sidebarItems: [
                  ..._sidebarItems,
                  _SidebarItemData("Settings", Icons.settings, '/settings'),
                ],
                currentRoute: _currentRoute,
                onSidebarItemTap: (route) {
                  if (route != _currentRoute) {
                    Navigator.pushReplacementNamed(context, route);
                  }
                },
              ),
            ),
          Expanded(
            child: isPhone
                ? _PhoneLayout()
                : Column(
                    children: [
                      _VisitorTrackingAppBar(),
                      Expanded(
                        child: Container(
                          color: const Color.fromARGB(255, 251, 254, 254),
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: ListView(
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.people, color: Colors.teal, size: 28),
                                    const SizedBox(width: 8),
                                    const Text("Visitor Tracking", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      _SummaryCard(
                                        title: "Total Tourists This Month",
                                        value: "15,823",
                                        subtitle: "↑ 12% from last month",
                                        icon: Icons.people,
                                        color: Colors.teal,
                                      ),
                                      SizedBox(width: 16),
                                      _SummaryCard(
                                        title: "Most Visited Resort",
                                        value: "Aqua Paradise Resort",
                                        subtitle: "3,100 visits this month",
                                        icon: Icons.beach_access,
                                        color: Colors.orange,
                                      ),
                                      SizedBox(width: 16),
                                      _SummaryCard(
                                        title: "Environmental Fees Collected",
                                        value: "₱45,210.00",
                                        subtitle: "↑ 8% from last quarter",
                                        icon: Icons.attach_money,
                                        color: Colors.green,
                                      ),
                                      SizedBox(width: 16),
                                      _SummaryCard(
                                        title: "Peak Visiting Day",
                                        value: "Saturday",
                                        subtitle: "Avg. 2,100 visitors",
                                        icon: Icons.calendar_today,
                                        color: Colors.blue,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 32),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(flex: 2, child: _TouristVolumeChart()),
                                    const SizedBox(width: 24),
                                    Expanded(flex: 1, child: _TopResortsCard()),
                                  ],
                                ),
                                const SizedBox(height: 32),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(flex: 2, child: _RecentTouristLogins()),
                                    const SizedBox(width: 24),
                                    Expanded(flex: 1, child: _QuickActionsCard()),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

// Responsive Drawer for phone
class _SidebarDrawer extends StatelessWidget {
  final List<_SidebarItemData> sidebarItems;
  final String currentRoute;
  const _SidebarDrawer({required this.sidebarItems, required this.currentRoute});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Container(
        color: Colors.teal.shade800,
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
            ...sidebarItems.map((item) {
              final selected = item.route == currentRoute;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                child: Material(
                  color: selected ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      Navigator.pop(context);
                      if (!selected) {
                        Navigator.pushReplacementNamed(context, item.route);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
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
            }).toList(),
            const Spacer(),
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
                    onPressed: () {},
                    tooltip: "Logout",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Phone layout for main content
class _PhoneLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 251, 254, 254),
      child: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          // Title
          Row(
            children: [
              const Icon(Icons.people, color: Colors.teal, size: 24),
              const SizedBox(width: 8),
              const Text("Visitor Tracking", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 16),
          // Summary cards stacked vertically
          _SummaryCard(
            title: "Total Tourists This Month",
            value: "15,823",
            subtitle: "↑ 12% from last month",
            icon: Icons.people,
            color: Colors.teal,
          ),
          const SizedBox(height: 12),
          _SummaryCard(
            title: "Most Visited Resort",
            value: "Aqua Paradise Resort",
            subtitle: "3,100 visits this month",
            icon: Icons.beach_access,
            color: Colors.orange,
          ),
          const SizedBox(height: 12),
          _SummaryCard(
            title: "Environmental Fees Collected",
            value: "₱45,210.00",
            subtitle: "↑ 8% from last quarter",
            icon: Icons.attach_money,
            color: Colors.green,
          ),
          const SizedBox(height: 12),
          _SummaryCard(
            title: "Peak Visiting Day",
            value: "Saturday",
            subtitle: "Avg. 2,100 visitors",
            icon: Icons.calendar_today,
            color: Colors.blue,
          ),
          const SizedBox(height: 20),
          // Charts and cards stacked vertically
          _TouristVolumeChart(),
          const SizedBox(height: 16),
          _TopResortsCard(),
          const SizedBox(height: 16),
          _RecentTouristLogins(),
          const SizedBox(height: 16),
          _QuickActionsCard(),
        ],
      ),
    );
  }
}

// Sidebar item data class
class _SidebarItemData {
  final String title;
  final IconData icon;
  final String route;
  const _SidebarItemData(this.title, this.icon, this.route);
}

// Permanent Sidebar Navigation
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

// ====== Dashboard Overview Widgets (Stubs) ======
class _VisitorTrackingAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(0, 129, 122, 122),
      elevation: 0,
      title: const Text(
        "Visitor Tracking Dashboard",
        style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
      ),
      centerTitle: false,
      automaticallyImplyLeading: false,
    );
  }
}

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
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 220,
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(title, style: const TextStyle(fontSize: 15)),
            const SizedBox(height: 6),
            Text(subtitle, style: TextStyle(fontSize: 13, color: color)),
          ],
        ),
      ),
    );
  }
}

class _TouristVolumeChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        height: 220,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Tourist Volume (Last 6 Months)", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
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
                          const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
                          if (value.toInt() >= 0 && value.toInt() < months.length) {
                            return Text(months[value.toInt()]);
                          }
                          return const Text('');
                        },
                        interval: 1,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  minX: 0,
                  maxX: 5,
                  minY: 0,
                  maxY: 20000,
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        FlSpot(0, 12000),
                        FlSpot(1, 13500),
                        FlSpot(2, 12800),
                        FlSpot(3, 14200),
                        FlSpot(4, 15823),
                        FlSpot(5, 15100),
                      ],
                      isCurved: true,
                      color: Colors.teal,
                      barWidth: 4,
                      dotData: FlDotData(show: true),
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
  @override
  Widget build(BuildContext context) {
    final data = [
      {'name': 'Aqua Paradise', 'visits': 3100, 'color': Colors.orange},
      {'name': 'Emerald Bay', 'visits': 2200, 'color': Colors.teal},
      {'name': 'Sunnyside Beach', 'visits': 1800, 'color': Colors.blue},
    ];
    final total = data.fold<int>(0, (sum, item) => sum + (item['visits'] as int));
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Text("Top Resorts", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
            const SizedBox(height: 10),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: DataTable(
                  columnSpacing: 32,
                  headingRowHeight: 32,
                  dataRowHeight: 32,
                  columns: const [
                    DataColumn(label: Text('Resort', style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('Visits', style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('Share', style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                  rows: data.map((item) {
                    final percent = (item['visits'] as int) / total * 100;
                    return DataRow(
                      cells: [
                        DataCell(Row(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: item['color'] as Color,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(item['name'] as String, style: const TextStyle(fontSize: 13)),
                          ],
                        )),
                        DataCell(Text(item['visits'].toString(), style: const TextStyle(fontSize: 13))),
                        DataCell(Text(
                          "${percent.toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: 13,
                            color: item['color'] as Color,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Total visits: $total",
                  style: const TextStyle(fontSize: 13, color: Colors.teal, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RecentTouristLogins extends StatelessWidget {
  final List<Map<String, dynamic>> recentLogins = const [
    {
      'name': 'Maxene Jarlego',
      'resort': 'Aqua Paradise',
      'time': '09:15 AM',
      'avatar': 'M',
    },
    {
      'name': 'Jayne Hernandez',
      'resort': 'Emerald Bay',
      'time': '08:47 AM',
      'avatar': 'J',
    },
    {
      'name': 'Liza Dela Rosa',
      'resort': 'Sunnyside Beach',
      'time': '08:30 AM',
      'avatar': 'L',
    },
    {
      'name': 'Jansen Cruzat',
      'resort': 'Aqua Paradise',
      'time': '08:10 AM',
      'avatar': 'J',
    },
    {
      'name': 'Anna Lim',
      'resort': 'Emerald Bay',
      'time': '07:55 AM',
      'avatar': 'A',
    },
    {
      'name': 'Hannah Maranan',
      'resort': 'Sunnyside Beach',
      'time': '07:40 AM',
      'avatar': 'H',
    },
    {
      'name': 'Micaela Bruce',
      'resort': 'Aqua Paradise',
      'time': '07:25 AM',
      'avatar': 'M',
    },
    {
      'name': 'Lizette Macalindol',
      'resort': 'Emerald Bay',
      'time': '07:10 AM',
      'avatar': 'L',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        height: 340, // Increased height for more entries and scrolling
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Recent Tourist Logins", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.separated(
                itemCount: recentLogins.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final login = recentLogins[index];
                  return ListTile(
                    dense: true,
                    leading: CircleAvatar(
                      backgroundColor: Colors.teal.shade100,
                      child: Text(login['avatar'], style: const TextStyle(color: Colors.teal)),
                    ),
                    title: Text(login['name'], style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                    subtitle: Text(login['resort'], style: const TextStyle(fontSize: 12)),
                    trailing: Text(login['time'], style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActionsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        height: 240,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Quick Actions", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
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
              onPressed: () {
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
              },
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
              onPressed: () {
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
              },
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
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/resortmanagement');
              },
            ),
          ],
        ),
      ),
    );
  }
}
// === Components ===

class _AddVisitorDialog extends StatefulWidget {
  const _AddVisitorDialog({Key? key}) : super(key: key);

  @override
  State<_AddVisitorDialog> createState() => _AddVisitorDialogState();
}

class _AddVisitorDialogState extends State<_AddVisitorDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _resortController = TextEditingController();
  final _durationController = TextEditingController();
  final _feeController = TextEditingController();
  String _status = 'Active';

  @override
  void dispose() {
    _nameController.dispose();
    _resortController.dispose();
    _durationController.dispose();
    _feeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Log New Visitor'),
      content: SizedBox(
        width: 350,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Tourist Name'),
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                ),
                TextFormField(
                  controller: _resortController,
                  decoration: const InputDecoration(labelText: 'Resort Visited'),
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                ),
                TextFormField(
                  controller: _durationController,
                  decoration: const InputDecoration(labelText: 'Duration (e.g. 3 days)'),
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                ),
                TextFormField(
                  controller: _feeController,
                  decoration: const InputDecoration(labelText: 'Environmental Fee (e.g. ₱50.00)'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                ),
                DropdownButtonFormField<String>(
                  value: _status,
                  items: const [
                    DropdownMenuItem(value: 'Active', child: Text('Active')),
                    DropdownMenuItem(value: 'Archived', child: Text('Archived')),
                    DropdownMenuItem(value: 'Pending', child: Text('Pending')),
                  ],
                  onChanged: (val) => setState(() => _status = val!),
                  decoration: const InputDecoration(labelText: 'Status'),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.pop(context, {
                'name': _nameController.text,
                'resort': _resortController.text,
                'duration': _durationController.text,
                'fee': _feeController.text,
                'status': _status,
              });
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}