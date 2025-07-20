import 'package:flutter/material.dart';
import 'package:lobo_tourism_management/addentrypage.dart';

// Main Page Widget
class EnvironmentalFeesPage extends StatefulWidget {
  @override
  State<EnvironmentalFeesPage> createState() => _EnvironmentalFeesPageState();
}

class _EnvironmentalFeesPageState extends State<EnvironmentalFeesPage> {
  String searchText = '';
  String selectedResort = 'All Resorts';
  String selectedMethod = 'All Methods';
  String selectedStatus = 'All Statuses';

  final List<Map<String, String>> transactions = [
    {
      'id': 'TXN001',
      'date': '2024-03-01',
      'name': 'Alice Johnson',
      'resort': 'Blue Lagoon Resort',
      'amount': '₱15.00',
      'method': 'Credit Card',
      'status': 'Paid',
    },
    {
      'id': 'TXN002',
      'date': '2024-03-01',
      'name': 'Bob Williams',
      'resort': 'Sunset Beach Club',
      'amount': '₱12.00',
      'method': 'Cash',
      'status': 'Paid',
    },
    {
      'id': 'TXN003',
      'date': '2024-03-02',
      'name': 'Carla Reyes',
      'resort': 'Hidden Falls Sanctuary',
      'amount': '₱20.00',
      'method': 'Credit Card',
      'status': 'Paid',
    },
    {
      'id': 'TXN004',
      'date': '2024-03-02',
      'name': 'David Cruz',
      'resort': 'Azure Paradise Resort',
      'amount': '₱18.00',
      'method': 'Cash',
      'status': 'Paid',
    },
    {
      'id': 'TXN005',
      'date': '2024-03-03',
      'name': 'Ella Santos',
      'resort': 'Coral Sands Inn',
      'amount': '₱14.00',
      'method': 'Credit Card',
      'status': 'Refunded',
    },
    {
      'id': 'TXN006',
      'date': '2024-03-03',
      'name': 'Francis Lim',
      'resort': 'Sunset Beach Club',
      'amount': '₱16.00',
      'method': 'Cash',
      'status': 'Paid',
    },
    {
      'id': 'TXN007',
      'date': '2024-03-04',
      'name': 'Grace Tan',
      'resort': 'Blue Lagoon Resort',
      'amount': '₱15.00',
      'method': 'Credit Card',
      'status': 'Paid',
    },
    {
      'id': 'TXN008',
      'date': '2024-03-04',
      'name': 'Henry Yu',
      'resort': 'Azure Paradise Resort',
      'amount': '₱13.00',
      'method': 'Cash',
      'status': 'Pending',
    },
    {
      'id': 'TXN009',
      'date': '2024-03-05',
      'name': 'Ivy Gomez',
      'resort': 'Hidden Falls Sanctuary',
      'amount': '₱17.00',
      'method': 'Credit Card',
      'status': 'Paid',
    },
    {
      'id': 'TXN010',
      'date': '2024-03-05',
      'name': 'Jake dela Cruz',
      'resort': 'Coral Sands Inn',
      'amount': '₱14.00',
      'method': 'Cash',
      'status': 'Paid',
    },
    {
      'id': 'TXN011',
      'date': '2024-03-06',
      'name': 'Karen Lee',
      'resort': 'Sunset Beach Club',
      'amount': '₱15.00',
      'method': 'Credit Card',
      'status': 'Paid',
    },
    {
      'id': 'TXN012',
      'date': '2024-03-06',
      'name': 'Leo Ramos',
      'resort': 'Blue Lagoon Resort',
      'amount': '₱12.00',
      'method': 'Cash',
      'status': 'Paid',
    },
    {
      'id': 'TXN013',
      'date': '2024-03-07',
      'name': 'Mia Torres',
      'resort': 'Azure Paradise Resort',
      'amount': '₱18.00',
      'method': 'Credit Card',
      'status': 'Paid',
    },
    {
      'id': 'TXN014',
      'date': '2024-03-07',
      'name': 'Noel Cruz',
      'resort': 'Hidden Falls Sanctuary',
      'amount': '₱20.00',
      'method': 'Cash',
      'status': 'Paid',
    },
    {
      'id': 'TXN015',
      'date': '2024-03-08',
      'name': 'Olivia Reyes',
      'resort': 'Coral Sands Inn',
      'amount': '₱14.00',
      'method': 'Credit Card',
      'status': 'Paid',
    },
  ];

  List<String> get resortOptions => [
        'All Resorts',
        ...{
          for (var txn in transactions) txn['resort'] ?? ''
        }..remove(''),
      ];

  List<String> get methodOptions => [
        'All Methods',
        ...{
          for (var txn in transactions) txn['method'] ?? ''
        }..remove(''),
      ];

  List<String> get statusOptions => [
        'All Statuses',
        ...{
          for (var txn in transactions) txn['status'] ?? ''
        }..remove(''),
      ];

  List<Map<String, String>> get filteredTransactions => transactions.where((txn) {
        final query = searchText.toLowerCase();
        final matchesSearch = query.isEmpty ||
            (txn['name']?.toLowerCase().contains(query) ?? false) ||
            (txn['id']?.toLowerCase().contains(query) ?? false) ||
            (txn['resort']?.toLowerCase().contains(query) ?? false);
        final matchesResort = selectedResort == 'All Resorts' || txn['resort'] == selectedResort;
        final matchesMethod = selectedMethod == 'All Methods' || txn['method'] == selectedMethod;
        final matchesStatus = selectedStatus == 'All Statuses' || txn['status'] == selectedStatus;
        return matchesSearch && matchesResort && matchesMethod && matchesStatus;
      }).toList();

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;
    return Scaffold(
      backgroundColor: const Color(0xFFF6FAF9),
      drawer: !isWide
          ? Drawer(
              elevation: 16,
              backgroundColor: const Color(0xFF00695C),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(topRight: Radius.circular(40)),
                child: SidebarMenu(
                  selectedIndex: 3,
                  onSelect: (index) => _onSidebarSelect(context, index),
                ),
              ),
            )
          : null,
      body: isWide ? _buildWideLayout(context) : _buildMobileLayout(context),
    );
  }

  void _onSidebarSelect(BuildContext context, int index) {
    final routes = [
      '/dashboard',
      '/visitortracking',
      '/resortmanagement',
      '/environmentalfees',
      '/itineraries',
      '/analytics',
      '/settings',
    ];
    final route = routes[index];
    if (ModalRoute.of(context)?.settings.name != route) {
      Navigator.pushReplacementNamed(context, route);
    }
  }

  Widget _buildWideLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SidebarMenu(
          selectedIndex: 3,
          onSelect: (index) => _onSidebarSelect(context, index),
        ),
        VerticalDivider(width: 1, color: Colors.grey[300]),
        Expanded(
          child: Column(
            children: [
              _TopBar(),
              Divider(height: 1, color: Colors.grey.shade200),
              Expanded(
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 1200),
                    margin: const EdgeInsets.only(top: 32),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 12, offset: Offset(0, 4))],
                    ),
                    padding: const EdgeInsets.all(32),
                    child: _MainContent(
                      resortOptions: resortOptions,
                      methodOptions: methodOptions,
                      statusOptions: statusOptions,
                      selectedResort: selectedResort,
                      selectedMethod: selectedMethod,
                      selectedStatus: selectedStatus,
                      searchText: searchText,
                      onSearchChanged: (v) => setState(() => searchText = v),
                      onResortChanged: (v) => setState(() => selectedResort = v ?? 'All Resorts'),
                      onMethodChanged: (v) => setState(() => selectedMethod = v ?? 'All Methods'),
                      onStatusChanged: (v) => setState(() => selectedStatus = v ?? 'All Statuses'),
                      transactions: filteredTransactions,
                      onAddEntry: () async {
                        final newEntry = await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AddEntryPage()),
                        );
                        if (newEntry != null && newEntry is Map<String, String>) {
                          setState(() {
                            transactions.add(newEntry);
                          });
                        }
                      },
                      onGenerateReport: () {},
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        _MobileAppBar(),
        Expanded(
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1200),
              margin: const EdgeInsets.only(top: 32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 12, offset: Offset(0, 4))],
              ),
              padding: const EdgeInsets.all(32),
              child: _MainContent(
                resortOptions: resortOptions,
                methodOptions: methodOptions,
                statusOptions: statusOptions,
                selectedResort: selectedResort,
                selectedMethod: selectedMethod,
                selectedStatus: selectedStatus,
                searchText: searchText,
                onSearchChanged: (v) => setState(() => searchText = v),
                onResortChanged: (v) => setState(() => selectedResort = v ?? 'All Resorts'),
                onMethodChanged: (v) => setState(() => selectedMethod = v ?? 'All Methods'),
                onStatusChanged: (v) => setState(() => selectedStatus = v ?? 'All Statuses'),
                transactions: filteredTransactions,
                onAddEntry: () async {
                  final newEntry = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddEntryPage()),
                  );
                  if (newEntry != null && newEntry is Map<String, String>) {
                    setState(() {
                      transactions.add(newEntry);
                    });
                  }
                },
                onGenerateReport: () {},
                isMobile: true,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Top Bar for Desktop
class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Row(
        children: [
          const SizedBox(width: 32),
          const Text(
            "Lobo Tourism Management Environmental Fees",
            style: TextStyle(
              color: Color(0xFF00796B),
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const Spacer(),
          const Icon(Icons.notifications_none, color: Color(0xFF00796B)),
          const SizedBox(width: 18),
          const CircleAvatar(
            backgroundColor: Color(0xFFB2DFDB),
            child: Icon(Icons.person, color: Color(0xFF00796B)),
          ),
          const SizedBox(width: 32),
        ],
      ),
    );
  }
}


// Main Content Widget
class _MainContent extends StatelessWidget {
  final List<String> resortOptions;
  final List<String> methodOptions;
  final List<String> statusOptions;
  final String selectedResort;
  final String selectedMethod;
  final String selectedStatus;
  final String searchText;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<String?> onResortChanged;
  final ValueChanged<String?> onMethodChanged;
  final ValueChanged<String?> onStatusChanged;
  final List<Map<String, String>> transactions;
  final VoidCallback onAddEntry;
  final VoidCallback onGenerateReport;
  final bool isMobile;

  const _MainContent({
    required this.resortOptions,
    required this.methodOptions,
    required this.statusOptions,
    required this.selectedResort,
    required this.selectedMethod,
    required this.selectedStatus,
    required this.searchText,
    required this.onSearchChanged,
    required this.onResortChanged,
    required this.onMethodChanged,
    required this.onStatusChanged,
    required this.transactions,
    required this.onAddEntry,
    required this.onGenerateReport,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    final isMobileScreen = MediaQuery.of(context).size.width < 600;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Responsive summary cards
          isMobileScreen
              ? Stack(
                  children: [
                    // Decorative icon or color on the right
                    Positioned(
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: Opacity(
                        opacity: 0.08,
                        child: Icon(
                          Icons.eco,
                          size: 320,
                          color: Colors.teal.shade200,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        _SummaryCard(
                          icon: Icons.attach_money,
                          value: '₱125,450',
                          label: 'Total Fees Collected (Month)',
                          subLabel: 'Up by 17% from last month',
                          color: Colors.teal,
                        ),
                        const SizedBox(height: 12),
                        _SummaryCard(
                          icon: Icons.person,
                          value: '₱15.20',
                          label: 'Average Fee per Tourist',
                          subLabel: 'Consistent with previous quarter',
                          color: Colors.orange,
                        ),
                        const SizedBox(height: 12),
                        _SummaryCard(
                          icon: Icons.swap_horiz,
                          value: '8,253',
                          label: 'Total Transactions',
                          subLabel: 'Increased by 8% this week',
                          color: Colors.green,
                        ),
                        const SizedBox(height: 12),
                        _SummaryCard(
                          icon: Icons.undo,
                          value: '45',
                          label: 'Refunds Processed',
                          subLabel: '2% of total transactions',
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                      child: _SummaryCard(
                        icon: Icons.attach_money,
                        value: '₱125,450',
                        label: 'Total Fees Collected (Month)',
                        subLabel: 'Up by 17% from last month',
                        color: Colors.teal,
                      ),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: _SummaryCard(
                        icon: Icons.person,
                        value: '₱15.20',
                        label: 'Average Fee per Tourist',
                        subLabel: 'Consistent with previous quarter',
                        color: Colors.orange,
                      ),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: _SummaryCard(
                        icon: Icons.swap_horiz,
                        value: '8,253',
                        label: 'Total Transactions',
                        subLabel: 'Increased by 8% this week',
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: _SummaryCard(
                        icon: Icons.undo,
                        value: '45',
                        label: 'Refunds Processed',
                        subLabel: '2% of total transactions',
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
          const SizedBox(height: 28),
          // Add Entry Button
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Add Entry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF009688),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: onAddEntry, // <-- Use the callback from parent
            ),
          ),
          const SizedBox(height: 18),
          // Fee Logs Table Section
          Text(
            'Fee Logs',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.teal.shade900,
            ),
          ),
          const SizedBox(height: 12),
          // Responsive filter fields
          isMobileScreen
              ? Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Search by name, ID, or resort...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                      ),
                      onChanged: onSearchChanged,
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: selectedResort,
                      items: resortOptions
                          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: onResortChanged,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                      ),
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: selectedMethod,
                      items: methodOptions
                          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: onMethodChanged,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                      ),
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: selectedStatus,
                      items: statusOptions
                          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: onStatusChanged,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                      ),
                    ),
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search by name, ID, or resort...',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                        ),
                        onChanged: onSearchChanged,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: selectedResort,
                        items: resortOptions
                            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        onChanged: onResortChanged,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: selectedMethod,
                        items: methodOptions
                            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        onChanged: onMethodChanged,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: selectedStatus,
                        items: statusOptions
                            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        onChanged: onStatusChanged,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                        ),
                      ),
                    ),
                  ],
                ),
          const SizedBox(height: 16),
          // Responsive table container
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFF3F8F6),
              borderRadius: BorderRadius.circular(18),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: isMobileScreen
                        ? 600 // minimum width for mobile, so table scrolls horizontally
                        : MediaQuery.of(context).size.width - 128,
                  ),
                  child: _TransactionTable(transactions: transactions),
                ),
              ),
            ),
          ),
          const SizedBox(height: 28),
        ],
      ),
    );
  }
  
  void setState(Null Function() param0) {}
}

// AppBar for Mobile
class _MobileAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      color: const Color(0xFF00695C),
      child: Row(
        children: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            "Lobo Tourism",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              letterSpacing: 1.1,
            ),
          ),
        ],
      ),
    );
  }
}

// Main Content Widget
// Summary Card Widget
class _SummaryCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final String subLabel;
  final Color color;
  const _SummaryCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.subLabel,
    required this.color,
  });
  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Container(
      width: isMobile ? double.infinity : 220, // <-- Make it full width on mobile
      margin: isMobile ? const EdgeInsets.symmetric(horizontal: 4) : null, // Optional: add horizontal margin on mobile
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 22.0, horizontal: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: color.withOpacity(0.1),
                child: Icon(icon, color: color, size: 28),
                radius: 22,
              ),
              const SizedBox(height: 14),
              Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color)),
              const SizedBox(height: 6),
              Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[800])),
              const SizedBox(height: 6),
              Text(subLabel, style: TextStyle(fontSize: 12, color: Colors.grey[500])),
            ],
          ),
        ),
      ),
    );
  }
}

// Transaction Table Widget (scrollable)
class _TransactionTable extends StatelessWidget {
  final List<Map<String, String>> transactions;
  const _TransactionTable({required this.transactions});
  @override
  Widget build(BuildContext context) {
    return DataTable(
      columnSpacing: 16,
      columns: const [
        DataColumn(label: Text('Transaction ID')),
        DataColumn(label: Text('Date')),
        DataColumn(label: Text('Tourist Name')),
        DataColumn(label: Text('Resort')),
        DataColumn(label: Text('Amount')),
        DataColumn(label: Text('Payment Method')),
        DataColumn(label: Text('Status')),
      ],
      rows: transactions.map((txn) {
        Color statusColor;
        switch (txn['status']) {
          case 'Paid':
            statusColor = Colors.green;
            break;
          case 'Refunded':
            statusColor = Colors.red;
            break;
          case 'Pending':
            statusColor = Colors.orange;
            break;
          default:
            statusColor = Colors.grey;
        }
        return DataRow(cells: [
          DataCell(Text(txn['id'] ?? '')),
          DataCell(Text(txn['date'] ?? '')),
          DataCell(Text(txn['name'] ?? '')),
          DataCell(Text(txn['resort'] ?? '')),
          DataCell(Text(txn['amount'] ?? '')),
          DataCell(Text(txn['method'] ?? '')),
          DataCell(Text(
            txn['status'] ?? '',
            style: TextStyle(color: statusColor, fontWeight: FontWeight.bold),
          )),
        ]);
      }).toList(),
    );
  }
}

// SidebarMenu Widget
class SidebarMenu extends StatelessWidget {
  final int selectedIndex;
  final Function(int)? onSelect;
  const SidebarMenu({this.selectedIndex = 0, this.onSelect});

  @override
  Widget build(BuildContext context) {
    final sidebarItems = [
      _SidebarItemData("Dashboard", Icons.dashboard, '/dashboard'),
      _SidebarItemData("Visitor Tracking", Icons.people, '/visitortracking'),
      _SidebarItemData("Resort Management", Icons.travel_explore, '/resortmanagement'),
      _SidebarItemData("Environmental Fees", Icons.attach_money, '/environmentalfees'),
      _SidebarItemData("Itineraries", Icons.map, '/itineraries'),
      _SidebarItemData("Analytics", Icons.bar_chart, '/analytics'),
      _SidebarItemData("Settings", Icons.settings, '/settings'),
    ];

    String currentRoute = ModalRoute.of(context)?.settings.name ?? '/environmentalfees';

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF00695C),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 8,
            offset: const Offset(2, 0),
          ),
        ],
      ),
      width: 250,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.explore, color: Colors.white, size: 32),
                SizedBox(width: 10),
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
                final selected = selectedIndex == index;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
                  child: Material(
                    color: selected ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {
                        if (item.route != currentRoute) {
                          Navigator.pushReplacementNamed(context, item.route);
                        }
                        if (onSelect != null) onSelect!(index);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                        child: Row(
                          children: [
                            Icon(
                              item.icon,
                              color: selected ? const Color(0xFF00695C) : Colors.white,
                              size: 24,
                            ),
                            const SizedBox(width: 16),
                            Text(
                              item.title,
                              style: TextStyle(
                                color: selected ? const Color(0xFF00695C) : Colors.white,
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
                const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: Color(0xFF00695C)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
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

class _SidebarItemData {
  final String title;
  final IconData icon;
  final String route;
  _SidebarItemData(this.title, this.icon, this.route);
}
