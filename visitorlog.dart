import 'package:flutter/material.dart';
import 'package:resort/dashboard.dart';

void main() =>   runApp(
    const MaterialApp(
      home: VisitorLogsContent(),
      debugShowCheckedModeBanner: false,
    ),
  );

class VisitorLogsContent extends StatefulWidget {
  const VisitorLogsContent({super.key});

  @override
  State<VisitorLogsContent> createState() => _VisitorLogsContentState();
}

class _VisitorLogsContentState extends State<VisitorLogsContent> {
  final List<Map<String, dynamic>> allLogs = [
   {
      'name': 'Alice Wonderland',
      'groupSize': 2,
      'attractions': 'Water Park, Fine Dining',
      'checkIn': '2024-07-02',
      'checkOut': '2024-07-05',
      'duration': '3 days',
      'status': 'Checked Out',
    },
    {
      'name': 'Bob Thebuilder',
      'groupSize': 1,
      'attractions': 'Adventure Trails',
      'checkIn': '2024-08-02',
      'checkOut': '2024-08-06',
      'duration': '4 days',
      'status': 'Checked Out',
    },
    {
      'name': 'Charlie Chaplin',
      'groupSize': 1,
      'attractions': 'Spa & Wellness, Fine Dining',
      'checkIn': '2024-08-01',
      'checkOut': '2024-08-05',
      'duration': '4 days',
      'status': 'Checked In',
    },
    {
      'name': 'Diana Prince',
      'groupSize': 3,
      'attractions': 'Kids’ Club, Water Park',
      'checkIn': '2024-07-31',
      'checkOut': '2024-08-04',
      'duration': '4 days',
      'status': 'Checked In',
    },
    {
      'name': 'Eve Harrington',
      'groupSize': 5,
      'attractions': 'Beach Access',
      'checkIn': '2024-08-01',
      'checkOut': '2024-08-05',
      'duration': '4 days',
      'status': 'Checked Out',
    },
    {
      'name': 'Frank Castle',
      'groupSize': 4,
      'attractions': 'Water Park, Fine Dining' 'Beach Access',
      'checkIn': '2024-07-02',
      'checkOut': '2024-07-08',
      'duration': '2 days',
      'status': 'Checked Out',
    },
  ];
  List<Map<String, dynamic>> filteredLogs = [];
  String? selectedDuration = 'Any';
  String? selectedAttraction = 'Any';
  DateTime? startDate;
  DateTime? endDate;

  @override
  void initState() {
    super.initState();
    filteredLogs = List.from(allLogs);
  }

  void _applyFilters() {
    setState(() {
      filteredLogs = allLogs.where((log) {
        final logDate = DateTime.parse(log['checkIn']);
        final matchesDate = (startDate == null || endDate == null) ||
            (logDate.isAfter(startDate!.subtract(const Duration(days: 1))) &&
                logDate.isBefore(endDate!.add(const Duration(days: 1))));
        final matchesDuration = selectedDuration == null ||
            selectedDuration == 'Any' ||
            log['duration'] == selectedDuration;
        final matchesAttraction = selectedAttraction == null ||
            selectedAttraction == 'Any' ||
            log['attractions'].contains(selectedAttraction!);
        return matchesDate && matchesDuration && matchesAttraction;
      }).toList();
    });
  }

  void _clearFilters() {
    setState(() {
      selectedDuration = 'Any';
      selectedAttraction = 'Any';
      startDate = null;
      endDate = null;
      filteredLogs = List.from(allLogs);
    });
  }

  void _filterBySearch(String query) {
    setState(() {
      filteredLogs = allLogs.where((log) {
        final name = log['name'].toLowerCase();
        final attraction = log['attractions'].toLowerCase();
        final search = query.toLowerCase();
        return name.contains(search) || attraction.contains(search);
      }).toList();
    });
  }

  Future<void> _selectDateRange() async {
    final pickedRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Center(
          child: Container(
            width: 350,
            height: 400,
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(12),
            child: Material(
              elevation: 8,
              borderRadius: BorderRadius.circular(20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: child,
              ),
            ),
          ),
        );
      },
    );

    if (pickedRange != null) {
      setState(() {
        startDate = pickedRange.start;
        endDate = pickedRange.end;
      });
    }
  }

  

  @override
Widget build(BuildContext context) {
  final isMobile = MediaQuery.of(context).size.width < 600;

  return Scaffold(
    appBar: AppBar(
      title: const Text("Visitor Logs Overview"),
      titleTextStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 28,
        color: Colors.teal,
        fontFamily: 'Pacifico',
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.teal),
    ),
    body: Container(
      color: Colors.white,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _sectionHeader(context, Icons.bar_chart, "Visitor Statistics"),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 12,
              runSpacing: 12,
              children: _statCards(),
            ),
            const SizedBox(height: 24),
            Divider(thickness: 2, color: Colors.teal[100]),
            _sectionHeader(context, Icons.filter_alt, "Filter Logs"),
            if (isMobile)
              Column(
                children: [
                  _buildFilterPanel(),
                  const SizedBox(height: 16),
                  Divider(thickness: 2, color: Colors.teal[100]),
                  _sectionHeader(context, Icons.list_alt, "Detailed Visitor Logs"),
                  _buildDataSection(),
                ],
              )
            else
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 1,
                    child: Column(
                      children: [
                        _buildFilterPanel(),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Flexible(
                    flex: 4,
                    child: Column(
                      children: [
                        Divider(thickness: 2, color: Colors.teal[100]),
                        _sectionHeader(context, Icons.list_alt, "Detailed Visitor Logs"),
                        _buildDataSection(),
                      ],
                    ),
                  ),
                ],
              )
          ],
        ),
      ),
    ),
  );
}

  Widget _sectionHeader(BuildContext context, IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.teal[700], size: 28),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.teal,
              fontFamily: 'Pacifico',
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _statCards() {
    return [
      _statCard("Today's Visitors", "125", "+5% from yesterday"),
      _statCard("Avg. Group Size", "3.2", "Consistent with last week"),
      _statCard("Most Visited Attraction", "Water Park", "Consistently popular"),
      _statCard("Current Check-ins", "18", "Ongoing arrivals"),
    ];
  }

  Widget _statCard(String title, String value, String caption) {
    return SizedBox(
      width: 180,
      child: Card(
        elevation: 8,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: const BorderSide(color: Color(0xFF008080), width: 2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(13),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF006064))),
              Text(value, style: const TextStyle(fontSize: 24, color: Color(0xFF006064))),
              const SizedBox(height: 4),
              Text(caption, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterPanel() {
    return SizedBox(
      width: 320,
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18), side: const BorderSide(color: Color(0xFF008080), width: 2)),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Filter Visitor Logs", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF006064))),
              const SizedBox(height: 10),
              ListTile(
                title: Text(
                  startDate != null && endDate != null
                      ? 'From    ${startDate!.toLocal().toString().split(' ')[0]} to ${endDate!.toLocal().toString().split(' ')[0]}'
                      : 'Select Date Range',
                ),
                tileColor: Colors.teal[50],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                onTap: _selectDateRange,
              ),
              const SizedBox(height: 10),
              _filterDropdown("Duration", ['Any', '2 days', '3 days', '4 days', '5 days'], (value) => setState(() => selectedDuration = value)),
              _filterDropdown("Attractions Visited", [
                'Any',
                'Water Park',
                'Fine Dining',
                'Adventure Trails',
                'Spa & Wellness',
                'Kids’ Club',
                'Beach Access'
              ], (value) => setState(() => selectedAttraction = value)),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[700],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: _applyFilters,
                child: const Text("Apply Filters"),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.teal,
                ),
                onPressed: _clearFilters,
                child: const Text("Clear Filters"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _filterDropdown(String label, List<String> options, Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 14, color: Colors.teal)),
          const SizedBox(height: 5),
          DropdownButtonFormField<String>(
            value: 'Any',
            items: options.map((item) {
              return DropdownMenuItem(value: item, child: Text(item));
            }).toList(),
            onChanged: onChanged,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              filled: true,
              fillColor: Colors.teal[50],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Detailed Visitor Logs", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.teal)),
            SizedBox(
              width: 200,
              child: TextField(
                onChanged: _filterBySearch,
                decoration: InputDecoration(
                  hintText: 'Search name or attraction...',
                  prefixIcon: const Icon(Icons.search, color: Colors.teal),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  filled: true,
                  fillColor: Colors.teal[50],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: _buildDataTable(),
        ),
      ],
    );
  }

  Widget _buildDataTable() {
    return DataTable(
      headingRowColor: MaterialStateProperty.resolveWith<Color?>((states) => Colors.teal[50]),
      columns: const [
        DataColumn(label: Text('Visitor Name', style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold))),
        DataColumn(label: Text('Group Size', style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold))),
        DataColumn(label: Text('Attractions Visited', style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold))),
        DataColumn(label: Text('Check-In Date', style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold))),
        DataColumn(label: Text('Check-Out Date', style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold))),
        DataColumn(label: Text('Duration', style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold))),
        DataColumn(label: Text('Status', style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold))),
      ],
      rows: filteredLogs.map((log) {
        final isCheckedIn = log['status'] == 'Checked In';
        return DataRow(cells: [
          DataCell(Text(log['name'])),
          DataCell(Text('${log['groupSize']}')),
          DataCell(Text(log['attractions'])),
          DataCell(Text(log['checkIn'])),
          DataCell(Text(log['checkOut'])),
          DataCell(Text(log['duration'])),
          DataCell(Text(
            log['status'],
            style: TextStyle(
              color: isCheckedIn ? Colors.teal : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          )),
        ]);
      }).toList(),
    );
  }
}