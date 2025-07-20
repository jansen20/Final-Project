import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({Key? key}) : super(key: key);

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<_SidebarItemData> _sidebarItems = [
    _SidebarItemData("Dashboard", Icons.dashboard, '/dashboard'),
    _SidebarItemData("Visitor Tracking", Icons.people, '/visitortracking'),
    _SidebarItemData("Resort Management", Icons.beach_access, '/resortmanagement'),
    _SidebarItemData("Environmental Fees", Icons.attach_money, '/environmentalfees'),
    _SidebarItemData("Itineraries", Icons.map, '/itineraries'),
    _SidebarItemData("Analytics", Icons.bar_chart, '/analytics'),
    _SidebarItemData("Settings", Icons.settings, '/settings'),
  ];

  String get _currentRoute => ModalRoute.of(context)?.settings.name ?? '/analytics';

  void _onSidebarItemTap(String route) {
    if (route != _currentRoute) {
      Navigator.pushReplacementNamed(context, route);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    Widget sidebar = _Sidebar(
      sidebarItems: _sidebarItems,
      currentRoute: _currentRoute,
      onSidebarItemTap: _onSidebarItemTap,
    );

    Widget mainContent = Column(
      children: [
        if (isMobile)
          AppBar(
            backgroundColor: Colors.teal.shade800,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.menu, color: Colors.white),
              onPressed: () => _scaffoldKey.currentState?.openDrawer(),
            ),
            title: const Text(
              "Tourism Analytics",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 10 : 28,
              vertical: isMobile ? 10 : 18,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tourism Analytics Overview",
                  style: TextStyle(
                    fontSize: isMobile ? 18 : 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal.shade900,
                  ),
                ),
                const SizedBox(height: 18),
                // Top Stats
                isMobile
                    ? Column(
                        children: [
                          _StatCard(
                            title: "Total Tourists This Month",
                            value: "18,231",
                            sub: "+2.5% compared to last month",
                            color: Colors.teal,
                            compact: true,
                          ),
                          const SizedBox(height: 10),
                          _StatCard(
                            title: "Average Daily Visitors",
                            value: "607",
                            sub: "-3.1% from previous week",
                            color: Colors.orange,
                            compact: true,
                          ),
                          const SizedBox(height: 10),
                          _StatCard(
                            title: "Top Barangay Visited",
                            value: "San Jose",
                            sub: "",
                            color: Colors.blue,
                            compact: true,
                          ),
                          const SizedBox(height: 10),
                          _StatCard(
                            title: "Environmental Fees Collected",
                            value: "₱152,000",
                            sub: "+4.2% this quarter",
                            color: Colors.green,
                            compact: true,
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          _StatCard(
                            title: "Total Tourists This Month",
                            value: "18,231",
                            sub: "+2.5% compared to last month",
                            color: Colors.teal,
                          ),
                          const SizedBox(width: 18),
                          _StatCard(
                            title: "Average Daily Visitors",
                            value: "607",
                            sub: "-3.1% from previous week",
                            color: Colors.orange,
                          ),
                          const SizedBox(width: 18),
                          _StatCard(
                            title: "Top Barangay Visited",
                            value: "San Jose",
                            sub: "",
                            color: Colors.blue,
                          ),
                          const SizedBox(width: 18),
                          _StatCard(
                            title: "Environmental Fees Collected",
                            value: "₱152,000",
                            sub: "+4.2% this quarter",
                            color: Colors.green,
                          ),
                        ],
                      ),
                const SizedBox(height: 18),
                // Charts Row
                isMobile
                    ? Column(
                        children: [
                          _ChartCard(
                            title: "Tourist Volume Trends (Monthly)",
                            child: _PlaceholderChart(height: 120),
                          ),
                          const SizedBox(height: 12),
                          _ChartCard(
                            title: "Tourist Volume per Barangay",
                            child: _PlaceholderBarChart(height: 120),
                          ),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: _ChartCard(
                              title: "Tourist Volume Trends (Monthly)",
                              child: _PlaceholderChart(height: 140),
                            ),
                          ),
                          const SizedBox(width: 18),
                          Expanded(
                            flex: 1,
                            child: _ChartCard(
                              title: "Tourist Volume per Barangay",
                              child: _PlaceholderBarChart(height: 140),
                            ),
                          ),
                        ],
                      ),
                const SizedBox(height: 18),
                // Demographics and Top Resorts
                isMobile
                    ? Column(
                        children: [
                          _ChartCard(
                            title: "Visitor Demographics by Nationality",
                            child: _DemoTable(isMobile: true),
                          ),
                          const SizedBox(height: 12),
                          _ChartCard(
                            title: "Top Resorts by Visitor Count",
                            child: _ResortTable(isMobile: true),
                          ),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: _ChartCard(
                              title: "Visitor Demographics by Nationality",
                              child: _DemoTable(),
                            ),
                          ),
                          const SizedBox(width: 18),
                          Expanded(
                            flex: 1,
                            child: _ChartCard(
                              title: "Top Resorts by Visitor Count",
                              child: _ResortTable(),
                            ),
                          ),
                        ],
                      ),
                const SizedBox(height: 18),
                // Environmental Fee Trend
                _ChartCard(
                  title: "Environmental Fee Collection Trend",
                  child: _PlaceholderChart(height: isMobile ? 120 : 180),
                ),
              ],
            ),
          ),
        ),
      ],
    );

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFF6FAF9),
      drawer: isMobile
          ? Drawer(
              child: SafeArea(child: sidebar),
            )
          : null,
      body: isMobile
          ? SafeArea(child: mainContent)
          : Row(
              children: [
                SizedBox(width: 250, child: sidebar),
                Expanded(child: mainContent),
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
      width: 250, // Match Dashboard sidebar width
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

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String sub;
  final Color color;
  final bool compact;
  const _StatCard({
    required this.title,
    required this.value,
    required this.sub,
    required this.color,
    this.compact = false,
  });
  @override
  Widget build(BuildContext context) {
    return compact
        ? Card(
            elevation: 1,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(value, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: color)),
                  const SizedBox(height: 4),
                  Text(title, style: TextStyle(fontSize: 12, color: Colors.grey[800])),
                  if (sub.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(sub, style: TextStyle(fontSize: 11, color: Colors.grey[500])),
                    ),
                ],
              ),
            ),
          )
        : Expanded(
            child: Card(
              elevation: 1,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color)),
                    const SizedBox(height: 6),
                    Text(title, style: TextStyle(fontSize: 14, color: Colors.grey[800])),
                    if (sub.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(sub, style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                      ),
                  ],
                ),
              ),
            ),
          );
  }
}

class _ChartCard extends StatelessWidget {
  final String title;
  final Widget child;
  const _ChartCard({required this.title, required this.child});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.teal.shade900)),
            const SizedBox(height: 10),
            child,
          ],
        ),
      ),
    );
  }
}

class _PlaceholderChart extends StatelessWidget {
  final double height;
  const _PlaceholderChart({required this.height});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 8, top: 8, bottom: 8), // Add left padding
        child: LineChart(
          LineChartData(
            gridData: FlGridData(show: true, drawVerticalLine: false),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 48, // Increased from 40 to 48 for more space
                  interval: 1000,
                  getTitlesWidget: (value, meta) {
                    if (value % 1000 == 0) {
                      if (value == 0) return const Text('0');
                      if (value == 1000) return const Text('1K');
                      if (value == 2000) return const Text('2K');
                      if (value == 3000) return const Text('3K');
                      if (value == 3200) return const Text('3.2K');
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
                    int idx = value.toInt();
                    if (idx < 0 || idx >= months.length) return const SizedBox.shrink();
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(months[idx], style: const TextStyle(fontSize: 12)),
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
            maxY: 3200,
            lineBarsData: [
              LineChartBarData(
                spots: const [
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
                ],
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
    );
  }
}

class _PlaceholderBarChart extends StatelessWidget {
  final double height;
  const _PlaceholderBarChart({required this.height});
  @override
  Widget build(BuildContext context) {
    // Example bar chart using fl_chart
    final barangays = ['Brgy. A', 'Brgy. B', 'Brgy. C', 'Brgy. D', 'Brgy. E'];
    final values = [4200.0, 3500.0, 2800.0, 2100.0, 1800.0];
    return SizedBox(
      height: height,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 5000,
          barTouchData: BarTouchData(enabled: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true, reservedSize: 36),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  int idx = value.toInt();
                  if (idx < 0 || idx >= barangays.length) return const SizedBox.shrink();
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(barangays[idx], style: const TextStyle(fontSize: 11)),
                  );
                },
                interval: 1,
              ),
            ),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: false),
          barGroups: List.generate(
            barangays.length,
            (i) => BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: values[i],
                  color: Colors.teal,
                  width: 18,
                  borderRadius: BorderRadius.circular(6),
                  backDrawRodData: BackgroundBarChartRodData(
                    show: true,
                    toY: 5000,
                    color: Colors.teal.withOpacity(0.07),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DemoTable extends StatelessWidget {
  final bool isMobile;
  const _DemoTable({this.isMobile = false});
  @override
  Widget build(BuildContext context) {
    final rows = [
      ["Filipino", "12,500"],
      ["American", "1,500"],
      ["Korean", "900"],
      ["Japanese", "700"],
      ["Chinese", "500"],
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text("Nationality")),
          DataColumn(label: Text("Visitors")),
        ],
        rows: rows
            .map((r) => DataRow(cells: [
                  DataCell(Text(r[0])),
                  DataCell(Text(r[1])),
                ]))
            .toList(),
        headingRowHeight: isMobile ? 24 : 28,
        dataRowHeight: isMobile ? 24 : 28,
        columnSpacing: isMobile ? 12 : 24,
        horizontalMargin: 0,
        dividerThickness: 0.5,
        showCheckboxColumn: false,
        dataTextStyle: TextStyle(fontSize: isMobile ? 12 : 13, color: Colors.grey[800]),
        headingTextStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal[900]),
      ),
    );
  }
}

class _ResortTable extends StatelessWidget {
  final bool isMobile;
  const _ResortTable({this.isMobile = false});
  @override
  Widget build(BuildContext context) {
    final rows = [
      ["Sunrise Cove Resort", "San Jose", "4,500"],
      ["Hidden Gem Glamping", "Sta. Rita", "3,800"],
      ["Azure Waters Resort", "Poblacion", "3,200"],
      ["Emerald Forest Retreat", "Malabigaas", "2,800"],
      ["Coral Reef Inn", "Libertad", "2,500"],
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text("Resort Name")),
          DataColumn(label: Text("Barangay")),
          DataColumn(label: Text("Visitors")),
        ],
        rows: rows
            .map((r) => DataRow(cells: [
                  DataCell(Text(r[0])),
                  DataCell(Text(r[1])),
                  DataCell(Text(r[2])),
                ]))
            .toList(),
        headingRowHeight: isMobile ? 24 : 28,
        dataRowHeight: isMobile ? 24 : 28,
        columnSpacing: isMobile ? 10 : 16,
        horizontalMargin: 0,
        dividerThickness: 0.5,
        showCheckboxColumn: false,
        dataTextStyle: TextStyle(fontSize: isMobile ? 12 : 13, color: Colors.grey[800]),
        headingTextStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal[900]),
      ),
    );
  }
}