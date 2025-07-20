import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'analytics.dart';
import 'help.dart';
import 'resortinfo.dart';
import 'visitorlog.dart';
import 'main.dart';


void main() {
  runApp(const ResortDashboardApp());
}

class ResortDashboardApp extends StatelessWidget {
  const ResortDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resort Manager',
      debugShowCheckedModeBanner: false,
      
      home: const DashboardScreen(),
      routes: {
        '/signin': (context) => const LoboTourismApp(),
      },
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String currentPage = 'Dashboard';

  void _navigateTo(String page) {
    setState(() {
      currentPage = page;
    });
  }

  Widget _getPageContent() {
    switch (currentPage) {
      case 'Dashboard':
        return _buildDashboardContent();
      case 'Visitor Logs':
        return VisitorLogsContent();
      case 'Manage Resort Info':
        return ManageResortInfoScreen();
      case 'Analytics':
        return AnalyticsDashboardScreen();
      case 'Help':
        return HelpCenterScreen();
      default:
        return const Center(child: Text("Unknown Page"));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 700;

    return Container(
      color: Colors.white, // Changed from gradient to solid white
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: isWide
            ? null
            : AppBar(
                title: const Text("Resort Manager", style: TextStyle(color: Color(0xFF008080))),
                backgroundColor: Colors.white,
                elevation: 0,
                iconTheme: const IconThemeData(color: Color(0xFF008080)),
              ),
        drawer: isWide
            ? null
            : Drawer(
                child: Sidebar(
                  onItemSelected: (item) {
                    Navigator.pop(context);
                    _navigateTo(item);
                  },
                  currentPage: currentPage,
                ),
              ),
        body: SafeArea(
          child: Row(
            children: [
              if (isWide)
                Sidebar(
                  onItemSelected: _navigateTo,
                  currentPage: currentPage,
                ),
              Expanded(child: _getPageContent()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Resort Dashboard",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF008080), fontFamily: 'Pacifico')),
          const SizedBox(height: 24),
          _buildTopCards(),
          const SizedBox(height: 24),
          _buildVisitorTrendsChart(),
          const SizedBox(height: 24),
          _buildOccupancyChart(),
          const SizedBox(height: 24),
          _buildVisitorDemographics(),
          const SizedBox(height: 24),
          _buildCheckInTable(),
          const SizedBox(height: 24),
          _buildRecentActivity(),
          const SizedBox(height: 24),
          _buildQuickActions(context),
        ],
      ),
    );
  }


  Widget _buildTopCards() {
  return Center(
    child: Wrap(
      alignment: WrapAlignment.center,
      spacing: 16,
      runSpacing: 16,
      children: [
        _infoCard("Visitors", "5,870", Icons.people),
        _infoCard("Avg. Stay", "3.2 Days", Icons.calendar_today),
        _infoCard("Peak Day", "Saturday", Icons.bar_chart),
        _infoCard("Occupancy", "76%", Icons.hotel),
      ],
    ),
  );
}

  Widget _infoCard(String title, String value, IconData icon) {
  return Card(
    color: Colors.white, // Changed to white
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: const BorderSide(color: Color(0xFF008080), width: 1), // Teal border
    ),
    shadowColor: Colors.teal[100],
    child: Container(
      width: 160,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 32, color: Color(0xFF008080)), // Teal icon
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontFamily: 'Pacifico', color: Color(0xFF008080))),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF006064),
              fontFamily: 'Segoe UI',
            ),
          ),
        ],
      ),
    ),
  );
}

  Widget _buildVisitorTrendsChart() {
    return Card(
      color: Colors.white, // White card
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFF008080), width: 1),
      ),
      shadowColor: Colors.teal[100],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text("Monthly Visitor Trends",
                style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF008080))),
            SizedBox(
              height: 200,
              child: LineChart(LineChartData(
                lineBarsData: [
                  LineChartBarData(
                    isCurved: true,
                    color: Color(0xFF008080), // Teal line
                    barWidth: 3,
                    spots: [
                      FlSpot(1, 200),
                      FlSpot(2, 320),
                      FlSpot(3, 400),
                      FlSpot(4, 500),
                      FlSpot(5, 300),
                      FlSpot(6, 600),
                    ],
                    dotData: FlDotData(show: true),
                  ),
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOccupancyChart() {
    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFF008080), width: 1),
      ),
      shadowColor: Colors.teal[100],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text("Daily Occupancy by Room Type",
                style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF008080))),
            SizedBox(
              height: 200,
              child: BarChart(BarChartData(
                barGroups: [
                  BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 80, color: Color(0xFF008080))]), // Teal
                  BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 65, color: Colors.orange)]),
                  BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 90, color: Colors.green)]),
                ],
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, _) {
                        switch (value.toInt()) {
                          case 0:
                            return const Text('Standard', style: TextStyle(color: Color(0xFF008080)));
                          case 1:
                            return const Text('Deluxe', style: TextStyle(color: Color(0xFF008080)));
                          case 2:
                            return const Text('Suite', style: TextStyle(color: Color(0xFF008080)));
                          default:
                            return const Text('');
                        }
                      },
                    ),
                  ),
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVisitorDemographics() {
    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFF008080), width: 1),
      ),
      shadowColor: Colors.teal[100],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text("Visitor Demographics",
                style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF008080))),
            SizedBox(
              height: 200,
              child: PieChart(PieChartData(sections: [
                PieChartSectionData(color: Color(0xFF008080), value: 40, title: 'Families', radius: 50),
                PieChartSectionData(color: Colors.orange, value: 30, title: 'Couples', radius: 50),
                PieChartSectionData(color: Colors.blue, value: 20, title: 'Solo', radius: 50),
                PieChartSectionData(color: Colors.purple, value: 10, title: 'Groups', radius: 50),
              ])),
            ),
          ],
        ),
      ),
    );
  }

     Widget _buildCheckInTable() {
  return Card(
    color: Colors.white,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: const BorderSide(color: Color(0xFF008080), width: 1),
    ),
    shadowColor: Colors.teal[100],
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Recent Check-ins & Check-outs",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF008080),
            ),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Name', style: TextStyle(color: Color(0xFF008080)))),
                DataColumn(label: Text('Room', style: TextStyle(color: Color(0xFF008080)))),
                DataColumn(label: Text('Check-in', style: TextStyle(color: Color(0xFF008080)))),
                DataColumn(label: Text('Check-out', style: TextStyle(color: Color(0xFF008080)))),
                DataColumn(label: Text('Status', style: TextStyle(color: Color(0xFF008080)))),
              ],
              rows: const [
                DataRow(cells: [
                  DataCell(Text("John Doe")),
                  DataCell(Text("201")),
                  DataCell(Text("July 5")),
                  DataCell(Text("July 8")),
                  DataCell(Text("Checked-in")),
                ]),
                DataRow(cells: [
                  DataCell(Text("Jane Smith")),
                  DataCell(Text("202")),
                  DataCell(Text("July 6")),
                  DataCell(Text("July 9")),
                  DataCell(Text("Checked-in")),
                ]),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}


      Widget _buildRecentActivity() {
        return Card(
          color: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Color(0xFF008080), width: 1),
          ),
          shadowColor: Colors.teal[100],
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: const [
                Text("Recent Resort Activity", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF008080))),
                ListTile(title: Text("Pool closed for maintenance")),
                ListTile(title: Text("New booking from AirBnB")),
                ListTile(title: Text("Guest left a 5-star review")),
              ],
            ),
          ),
        );
      }

        
      Widget _buildQuickActions(BuildContext context) {
      return Card(
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFF008080), width: 1),
        ),
        shadowColor: Colors.teal[100],
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.center,
                child: Text("Quick Actions", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF008080))),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.teal[50], // Teal touch
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Color(0xFF008080), width: 1),
                ),
                child: ListTile(
                  leading: const Icon(Icons.campaign, color: Color(0xFF008080)),
                  title: const Text("Promo", style: TextStyle(color: Color(0xFF008080))),
                  onTap: () => _showAddReservationForm(context),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Color(0xFF008080), width: 1),
                ),
                child: ListTile(
                  leading: const Icon(Icons.attach_money, color: Colors.orange),
                  title: const Text("Update Room Rates", style: TextStyle(color: Color(0xFF008080))),
                  onTap: () => _showUpdateRoomRatesForm(context),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Color(0xFF008080), width: 1),
                ),
                child: ListTile(
                  leading: const Icon(Icons.message, color: Colors.blue),
                  title: const Text("Send Message to Guests", style: TextStyle(color: Color(0xFF008080))),
                  onTap: () => _showSendMessageForm(context),
                ),
              ),
            ],
          ),
        ),
      );
    }

    void _showAddReservationForm(BuildContext context) {
      final _formKey = GlobalKey<FormState>();
      String promoName = '';
      String discount = '';
      DateTime? startDate;
      DateTime? endDate;

      showDialog(
        context: context,
        builder: (_) => Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            padding: const EdgeInsets.all(24),
            width: 320,
            color: const Color(0xFFF6F1FA),
            child: StatefulBuilder(
              builder: (context, setState) {
                return Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Promo",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Promo Name'),
                        onChanged: (val) => promoName = val,
                        validator: (val) => val!.isEmpty ? 'Enter promo name' : null,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Discount (%)'),
                        keyboardType: TextInputType.number,
                        onChanged: (val) => discount = val,
                        validator: (val) => val!.isEmpty ? 'Enter discount' : null,
                      ),
                      const SizedBox(height: 10),
                      ListTile(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        tileColor: Colors.grey[200],
                        title: Text(
                          startDate != null
                              ? 'Start Date: ${startDate!.toLocal().toString().split(' ')[0]}'
                              : 'Select Start Date',
                        ),
                        trailing: const Icon(Icons.calendar_today),
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2035),
                          );
                          if (picked != null) setState(() => startDate = picked);
                        },
                      ),
                      const SizedBox(height: 8),
                      ListTile(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        tileColor: Colors.grey[200],
                        title: Text(
                          endDate != null
                              ? 'End Date: ${endDate!.toLocal().toString().split(' ')[0]}'
                              : 'Select End Date',
                        ),
                        trailing: const Icon(Icons.calendar_today),
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now().add(const Duration(days: 1)),
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2035),
                          );
                          if (picked != null) setState(() => endDate = picked);
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.pop(context), // Cancel button
                            child: const Text("Cancel", style: TextStyle(color: Colors.purple)),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple[100],
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Navigator.pop(context); // Close on submit
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Promo Created')),
                                );
                              }
                            },
                            child: const Text("Submit"),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      );
    }

    void _showUpdateRoomRatesForm(BuildContext context) {
      final _formKey = GlobalKey<FormState>();
      String roomType = '';
      String rate = '';

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Update Room Rates"),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Room Type'),
                  onChanged: (value) => roomType = value,
                  validator: (value) => value!.isEmpty ? 'Enter room type' : null,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'New Rate'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) => rate = value,
                  validator: (value) => value!.isEmpty ? 'Enter rate' : null,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // Cancel
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.pop(context); // Submit
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Room rate updated')),
                  );
                }
              },
              child: const Text("Update"),
            ),
          ],
        ),
      );
    }

    void _showSendMessageForm(BuildContext context) {
      final _formKey = GlobalKey<FormState>();
      String subject = '';
      String message = '';

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Send Message"),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Subject'),
                  onChanged: (value) => subject = value,
                  validator: (value) => value!.isEmpty ? 'Enter subject' : null,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Message'),
                  maxLines: 3,
                  onChanged: (value) => message = value,
                  validator: (value) => value!.isEmpty ? 'Enter message' : null,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // Cancel
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.pop(context); // Submit
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Message sent')),
                  );
                }
              },
              child: const Text("Send"),
            ),
          ],
        ),
      );
    }
}






// ----------------------------- Sidebar -----------------------------
class Sidebar extends StatelessWidget {
  final void Function(String) onItemSelected;
  final String currentPage;

  const Sidebar({super.key, required this.onItemSelected, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    final menuItems = [
      'Dashboard',
      'Visitor Logs',
      'Manage Resort Info',
      'Analytics',
      'Help',
    ];

    return Container(
      width: 220,
      decoration: const BoxDecoration(
        color: Color(0xFF008080), // Solid teal
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Lobo Resort Manager",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white, fontFamily: 'Pacifico'),
          ),
          const SizedBox(height: 24),

          // Menu Items
          ...menuItems.map((item) {
            final isSelected = currentPage == item;
            return Container(
              margin: const EdgeInsets.only(bottom: 4),
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                title: Text(
                  item, 
                  style: TextStyle(
                    fontSize: 16, 
                    color: isSelected ? Color(0xFF008080) : Colors.white, 
                    fontFamily: 'Segoe UI',
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  )
                ),
                onTap: () => onItemSelected(item),
                hoverColor: isSelected ? Colors.transparent : Colors.white24,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            );
          }),

          const Spacer(),
          const Divider(color: Colors.white),

          // User Info
          Row(
            children: const [
              CircleAvatar(child: Text("RA", style: TextStyle(color: Color(0xFF008080))), backgroundColor: Colors.white),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Resort Admin", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  Text("admin@lobo.com", style: TextStyle(fontSize: 12, color: Colors.white70)),
                ],
              )
            ],
          ),
          const SizedBox(height: 12),

          // Logout Button
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.logout, color: Colors.white),
            title: const Text("Logout", style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/signin');
            },
          ),
        ],
      ),
    );
  }
}