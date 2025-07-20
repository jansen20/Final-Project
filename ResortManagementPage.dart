import 'package:flutter/material.dart';
import 'package:lobo_tourism_management/AddResortPage.dart';
import 'package:lobo_tourism_management/PendingResortPage.dart'; // <-- Add this import

class _SidebarItemData {
  final String title;
  final IconData icon;
  final String route;
  const _SidebarItemData(this.title, this.icon, this.route);
}

class SidebarMenu extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  SidebarMenu({required this.selectedIndex, required this.onSelect});

  final List<_SidebarItemData> sidebarItems = const [
    _SidebarItemData("Dashboard", Icons.dashboard, '/dashboard'),
    _SidebarItemData("Visitor Tracking", Icons.people, '/visitortracking'),
    _SidebarItemData("Resort Management", Icons.beach_access, '/resortmanagement'),
    _SidebarItemData("Environmental Fees", Icons.attach_money, '/environmentalfees'),
    _SidebarItemData("Itineraries", Icons.map, '/itineraries'),
    _SidebarItemData("Analytics", Icons.bar_chart, '/analytics'),
    _SidebarItemData("Settings", Icons.settings, '/settings'),
  ];

  @override
  Widget build(BuildContext context) {
    String currentRoute = ModalRoute.of(context)?.settings.name ?? '/resortmanagement';

    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF00695C),
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
                        onSelect(index);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                        child: Row(
                          children: [
                            Icon(
                              item.icon,
                              color: selected ? Color(0xFF00695C) : Colors.white,
                              size: 24,
                            ),
                            const SizedBox(width: 16),
                            Text(
                              item.title,
                              style: TextStyle(
                                color: selected ? Color(0xFF00695C) : Colors.white,
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
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: Color(0xFF00695C)),
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

// Flat header bar, no Card, matches dashboard
class ResortManagementHeader extends StatelessWidget {
  final VoidCallback? onProfileTap;
  final VoidCallback? onMenuTap;
  const ResortManagementHeader({this.onProfileTap, this.onMenuTap});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;
    return Container(
      height: 64,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 32),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          if (!isWide)
            IconButton(
              icon: Icon(Icons.menu, color: Color(0xFF009688)),
              onPressed: onMenuTap ?? () => Scaffold.of(context).openDrawer(),
            ),
          Text(
            "Lobo Tourism Management Dashboard",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF009688),
              letterSpacing: 0.5,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Color(0xFF009688)),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: onProfileTap,
            child: CircleAvatar(
              backgroundColor: Color(0xFFE0F2F1),
              child: const Icon(Icons.account_circle, color: Color(0xFF009688), size: 28),
            ),
          ),
        ],
      ),
    );
  }
}

class ResortDashboardSummary extends StatelessWidget {
  final VoidCallback onAddResort;
  final VoidCallback onApprovePending;
  final VoidCallback onEditDetails;
  final VoidCallback onDeactivate;

  const ResortDashboardSummary({
    required this.onAddResort,
    required this.onApprovePending,
    required this.onEditDetails,
    required this.onDeactivate,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isPhone = MediaQuery.of(context).size.width < 600;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isPhone ? 8 : 24, vertical: 8),
      child: Column(
        children: [
          isPhone
              ? Column(
                  children: [
                    _SummaryCard(
                      icon: Icons.apartment,
                      value: '12',
                      label: 'Total Resorts',
                      sublabel: 'All active and pending listings',
                    ),
                    SizedBox(height: 12),
                    _SummaryCard(
                      icon: Icons.people_alt,
                      value: '815',
                      label: 'Average Visitors/Resort (Monthly)',
                      sublabel: 'Based on last 30 days data',
                    ),
                    SizedBox(height: 12),
                    _SummaryCard(
                      icon: Icons.playlist_add_check,
                      value: '2',
                      label: 'New Pending Resorts',
                      sublabel: 'Awaiting approval',
                    ),
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                      child: _SummaryCard(
                        icon: Icons.apartment,
                        value: '12',
                        label: 'Total Resorts',
                        sublabel: 'All active and pending listings',
                      ),
                    ),
                    SizedBox(width: 18),
                    Expanded(
                      child: _SummaryCard(
                        icon: Icons.people_alt,
                        value: '815',
                        label: 'Average Visitors/Resort (Monthly)',
                        sublabel: 'Based on last 30 days data',
                      ),
                    ),
                    SizedBox(width: 18),
                    Expanded(
                      child: _SummaryCard(
                        icon: Icons.playlist_add_check,
                        value: '2',
                        label: 'New Pending Resorts',
                        sublabel: 'Awaiting approval',
                      ),
                    ),
                  ],
                ),
          SizedBox(height: 20),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 18, horizontal: isPhone ? 12 : 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Quick Actions',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: isPhone ? 16 : 18)),
                  SizedBox(height: 4),
                  Text('Perform common management tasks quickly.',
                      style: TextStyle(color: Colors.grey[700], fontSize: isPhone ? 13 : 14)),
                  SizedBox(height: 16),
                  Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.add, color: Colors.blue),
                        title: Text('Add New Resort',
                            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                        onTap: onAddResort,
                        dense: isPhone,
                        minLeadingWidth: 0,
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.check_circle, color: Colors.teal),
                        title: Text('Approve Pending Resorts'),
                        onTap: onApprovePending,
                        dense: isPhone,
                        minLeadingWidth: 0,
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.delete, color: Colors.red),
                        title: Text('Deactivate Resort',
                            style: TextStyle(color: Colors.red)),
                        onTap: onDeactivate,
                        dense: isPhone,
                        minLeadingWidth: 0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final String sublabel;

  const _SummaryCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.sublabel,
  });

  @override
  Widget build(BuildContext context) {
    final isPhone = MediaQuery.of(context).size.width < 600;
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: isPhone ? 12 : 18, horizontal: isPhone ? 12 : 20),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.indigo.shade50,
              child: Icon(icon, color: Colors.indigo, size: isPhone ? 22 : 28),
              radius: isPhone ? 20 : 24,
            ),
            SizedBox(width: isPhone ? 10 : 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value,
                    style: TextStyle(fontSize: isPhone ? 16 : 22, fontWeight: FontWeight.bold)),
                Text(label,
                    style: TextStyle(fontSize: isPhone ? 12 : 15, color: Colors.black87)),
                Text(sublabel,
                    style: TextStyle(fontSize: isPhone ? 10 : 12, color: Colors.grey[600])),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ResortManagementPage extends StatefulWidget {
  @override
  State<ResortManagementPage> createState() => _ResortManagementPageState();
}

class _ResortManagementPageState extends State<ResortManagementPage> {
  final List<Map<String, dynamic>> resorts = [
    {
      'name': 'Azure Paradise Resort',
      'barangay': 'Poblacion',
      'visitors': 1250,
      'status': 'Active'
    },
    {
      'name': 'Coral Sands Inn',
      'barangay': 'Barangay Uno',
      'visitors': 720,
      'status': 'Pending'
    },
    {
      'name': 'Hidden Falls Sanctuary',
      'barangay': 'San Jose',
      'visitors': 400,
      'status': 'Deactivated'
    },
  ];

  String filterStatus = 'All';
  String searchText = '';

  void _addResort(BuildContext context) async {
    final newResort = await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => AddResortPage()),
    );
    if (newResort != null && newResort is Map<String, dynamic>) {
      setState(() {
        // Ensure status is set to 'Active' if not provided
        resorts.add({
          ...newResort,
          'status': newResort['status'] ?? 'Active',
        });
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Resort "${newResort['name']}" added!')),
      );
    }
  }

  void _approvePending(BuildContext context) {
    final pendingResorts = resorts.where((r) => r['status'] == 'Pending').toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PendingResortPage(
          pendingResorts: pendingResorts,
          onApprove: (resort) {
            setState(() {
              resort['status'] = 'Active';
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${resort['name']} approved!')),
            );
          },
          onReject: (resort) {
            setState(() {
              resorts.remove(resort);
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${resort['name']} rejected and removed!')),
            );
          },
        ),
      ),
    );
  }


  void _deactivate(BuildContext context) async {
    // Only show resorts that are not already deactivated
    final activeResorts = resorts.where((r) => r['status'] != 'Deactivated').toList();
    if (activeResorts.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No active or pending resorts to deactivate.')),
      );
      return;
    }

    Map<String, dynamic>? selectedResort = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Deactivate Resort'),
        content: SizedBox(
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Select a resort to deactivate:'),
              const SizedBox(height: 16),
              ...activeResorts.map((resort) => ListTile(
                    title: Text(resort['name']),
                    subtitle: Text('Status: ${resort['status']}'),
                    onTap: () => Navigator.of(context).pop(resort),
                  )),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );

    if (selectedResort != null) {
      setState(() {
        // Remove from active/pending list and set status to Deactivated
        resorts.remove(selectedResort);
        resorts.add({
          ...selectedResort,
          'status': 'Deactivated',
        });
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${selectedResort['name']} has been deactivated.')),
      );
    }
  }

  void _editResortDetails(BuildContext context) {
    // For demo, edit the first resort (customize as needed)
    if (resorts.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => EditResortPage(
            resort: resorts[0],
            onSave: (updatedResort) {
              setState(() {
                resorts[0] = updatedResort;
              });
            },
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No resort available to edit.')),
      );
    }
  }

  List<Map<String, dynamic>> get filteredResorts {
    return resorts.where((resort) {
      if (filterStatus == 'All') {
        return resort['status'] != 'Deactivated' &&
          resort['name'].toLowerCase().contains(searchText.toLowerCase());
      }
      return resort['status'] == filterStatus &&
        resort['name'].toLowerCase().contains(searchText.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;

    // Only Quick Actions card (not summary cards)
    final mainContent = SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 24.0),
        child: Column(
          children: [
            ResortDashboardSummary(
              onAddResort: () => _addResort(context),
              onApprovePending: () => _approvePending(context),
              onEditDetails: () => _editResortDetails(context),
              onDeactivate: () => _deactivate(context),
            ),
            ResortList(
              resorts: filteredResorts,
              filterStatus: filterStatus,
              onFilterChanged: (status) => setState(() => filterStatus = status ?? 'All'),
              searchText: searchText,
              onSearchChanged: (text) => setState(() => searchText = text),
            ),
            // --- Deactivated Account Table ---
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
              child: Card(
                elevation: 4,
                color: Colors.red.shade50,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.cancel, color: Colors.red.shade400, size: 32),
                          const SizedBox(width: 12),
                          const Text(
                            'Deactivated Account',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: Colors.red,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      Builder(
                        builder: (context) {
                          final deactivatedResorts = resorts.where((r) => r['status'] == 'Deactivated').toList();
                          if (deactivatedResorts.isEmpty) {
                            return const Padding(
                              padding: EdgeInsets.symmetric(vertical: 32),
                              child: Center(
                                child: Text('No deactivated resorts.', style: TextStyle(color: Colors.grey, fontSize: 16)),
                              ),
                            );
                          }
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.red.shade100.withOpacity(0.22),
                              border: Border.all(color: Colors.red.shade100, width: 1.2),
                            ),
                            child: DataTable(
                              columnSpacing: 40,
                              headingRowHeight: 44,
                              dataRowHeight: 44,
                              headingRowColor: MaterialStateProperty.resolveWith<Color?>(
                                (states) => Colors.red.shade100.withOpacity(0.7),
                              ),
                              columns: const [
                                DataColumn(label: Text('Resort', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red, fontSize: 16))),
                                DataColumn(label: Text('Barangay', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red, fontSize: 16))),
                                DataColumn(label: Text('Visitors', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red, fontSize: 16))),
                                DataColumn(label: Text('Action', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red, fontSize: 16))),
                              ],
                              rows: deactivatedResorts.map((resort) {
                                return DataRow(
                                  color: MaterialStateProperty.resolveWith<Color?>(
                                    (states) => Colors.red.shade50,
                                  ),
                                  cells: [
                                    DataCell(Row(
                                      children: [
                                        Icon(Icons.block, color: Colors.red.shade300, size: 22),
                                        const SizedBox(width: 8),
                                        Text(resort['name'] ?? '', style: const TextStyle(fontSize: 15, color: Colors.red, fontWeight: FontWeight.w600)),
                                      ],
                                    )),
                                    DataCell(Text(resort['barangay'] ?? '', style: const TextStyle(fontSize: 15, color: Colors.red))),
                                    DataCell(Text(resort['visitors'].toString(), style: const TextStyle(fontSize: 15, color: Colors.red))),
                                    DataCell(
                                      ElevatedButton.icon(
                                        icon: const Icon(Icons.check_circle, size: 20, color: Colors.white),
                                        label: const Text('Activate', style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold)),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green,
                                          minimumSize: const Size(110, 40),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                          elevation: 0,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            resort['status'] = 'Active';
                                          });
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text('${resort['name']} activated!')),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          );
                          }
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF6FAF9),
      drawer: !isWide
          ? Drawer(
              elevation: 16,
              backgroundColor: Color(0xFF00695C),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(40),
                ),
                child: Container(
                  color: Color(0xFF00695C),
                  child: SidebarMenu(
                    selectedIndex: 2,
                    onSelect: (index) {
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
                    },
                  ),
                ),
              ),
            )
          : null,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _addResort(context),
        icon: Icon(Icons.add),
        label: Text('Add Resort'),
        backgroundColor: Color(0xFF009688),
      ),
      body: isWide
          ? Row(
              children: [
                SidebarMenu(
                  selectedIndex: 2,
                  onSelect: (index) {
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
                  },
                ),
                VerticalDivider(width: 1, color: Colors.grey[300]),
                Expanded(
                  child: Column(
                    children: [
                      ResortManagementHeader(
                        onMenuTap: () => Scaffold.of(context).openDrawer(),
                      ),
                      Expanded(child: mainContent),
                    ],
                  ),
                ),
              ],
            )
          : Column(
              children: [
                // Custom AppBar for mobile
                Container(
                  height: 56,
                  color: Color(0xFF00695C),
                  child: Row(
                    children: [
                      Builder(
                        builder: (context) => IconButton(
                          icon: Icon(Icons.menu, color: Colors.white),
                          onPressed: () => Scaffold.of(context).openDrawer(),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
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
                ),
                Expanded(child: mainContent),
              ],
            ),
    );
  }
}

class ResortList extends StatelessWidget {
  final List<Map<String, dynamic>> resorts;
  final String filterStatus;
  final ValueChanged<String?> onFilterChanged;
  final String searchText;
  final ValueChanged<String> onSearchChanged;

  const ResortList({
    super.key,
    required this.resorts,
    required this.filterStatus,
    required this.onFilterChanged,
    required this.searchText,
    required this.onSearchChanged,
  });

  Color getStatusColor(String status) {
    switch (status) {
      case 'Active':
        return Colors.green;
      case 'Pending':
        return Colors.orange;
      case 'Deactivated':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData getStatusIcon(String status) {
    switch (status) {
      case 'Active':
        return Icons.check_circle;
      case 'Pending':
        return Icons.hourglass_top;
      case 'Deactivated':
        return Icons.cancel;
      default:
        return Icons.help;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isPhone = MediaQuery.of(context).size.width < 600;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: isPhone ? 12 : 24, horizontal: isPhone ? 8 : 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: EdgeInsets.only(bottom: isPhone ? 12 : 24),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: isPhone ? 10 : 18, horizontal: isPhone ? 10 : 24),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Resort Listings',
                      style: TextStyle(
                        fontSize: isPhone ? 18 : 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal.shade900,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: isPhone ? 120 : 220,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search resorts...',
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: searchText.isNotEmpty
                            ? IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: () => onSearchChanged(''),
                                tooltip: 'Clear search',
                              )
                            : null,
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: onSearchChanged,
                      style: TextStyle(fontSize: isPhone ? 13 : 16),
                    ),
                  ),
                  SizedBox(width: isPhone ? 8 : 16),
                  DropdownButton<String>(
                    value: filterStatus,
                    items: ['All', 'Active', 'Pending', 'Deactivated']
                        .map((status) => DropdownMenuItem(
                              value: status,
                              child: Text(status, style: TextStyle(fontSize: isPhone ? 13 : 16)),
                            ))
                        .toList(),
                    onChanged: onFilterChanged,
                    style: TextStyle(fontSize: isPhone ? 13 : 16, color: Colors.teal.shade900),
                    underline: Container(height: 0),
                    dropdownColor: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          resorts.isEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: Center(
                    child: Text(
                      'No resorts found.',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                  ),
                )
              : ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: resorts.length,
                  separatorBuilder: (_, __) => SizedBox(height: isPhone ? 10 : 16),
                  itemBuilder: (context, index) {
                    final resort = resorts[index];
                    return _ResortCard(
                      resort: resort,
                      isPhone: isPhone,
                      statusColor: getStatusColor(resort['status']),
                      statusIcon: getStatusIcon(resort['status']),
                      onEdit: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EditResortPage(
                              resort: resort,
                              onSave: (updatedResort) {
                                // Find the real index in the main resorts list and update it
                                final mainState = context.findAncestorStateOfType<_ResortManagementPageState>();
                                if (mainState != null) {
                                  final realIndex = mainState.resorts.indexOf(resort);
                                  if (realIndex != -1) {
                                    // ignore: invalid_use_of_protected_member
                                    mainState.setState(() {
                                      mainState.resorts[realIndex] = updatedResort;
                                    });
                                  }
                                }
                              },
                            ),
                          ),
                        );
                        },
                    );
                  },
                ),
        ],
      ),
    );
  }
}

class _ResortCard extends StatelessWidget {
  final Map<String, dynamic> resort;
  final bool isPhone;
  final Color statusColor;
  final IconData statusIcon;
  final VoidCallback? onEdit;

  const _ResortCard({
    required this.resort,
    required this.isPhone,
    required this.statusColor,
    required this.statusIcon,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(isPhone ? 12 : 18),
      onTap: () {
        // Show resort info dialog or page
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(resort['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Barangay: ${resort['barangay']}'),
                Text('Visitors (Monthly): ${resort['visitors']}'),
                Text('Status: ${resort['status']}'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
              TextButton(
                onPressed: onEdit,
                child: const Text('Edit'),
              ),
            ],
          ),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(isPhone ? 12 : 18),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: isPhone ? 10 : 18, horizontal: isPhone ? 10 : 20),
          child: Row(
            children: [
              CircleAvatar(
                radius: isPhone ? 18 : 28,
                backgroundColor: Colors.teal.shade100,
                child: Icon(Icons.beach_access, color: Colors.teal.shade800, size: isPhone ? 22 : 32),
              ),
              SizedBox(width: isPhone ? 10 : 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      resort['name'],
                      style: TextStyle(
                        fontSize: isPhone ? 15 : 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal.shade900,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      resort['barangay'],
                      style: TextStyle(
                        fontSize: isPhone ? 12 : 15,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.edit, color: Colors.teal.shade700, size: isPhone ? 20 : 24),
                onPressed: onEdit,
                tooltip: 'Edit Resort',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditResortPage extends StatefulWidget {
  final Map<String, dynamic> resort;
  final ValueChanged<Map<String, dynamic>> onSave;

  const EditResortPage({required this.resort, required this.onSave, Key? key}) : super(key: key);

  @override
  State<EditResortPage> createState() => _EditResortPageState();
}

class _EditResortPageState extends State<EditResortPage> {
  late TextEditingController nameController;
  late TextEditingController barangayController;
  late TextEditingController visitorsController;
  String status = 'Active';

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.resort['name'] ?? '');
    barangayController = TextEditingController(text: widget.resort['barangay'] ?? '');
    visitorsController = TextEditingController(text: widget.resort['visitors']?.toString() ?? '');
    status = widget.resort['status'] ?? 'Active';
  }

  void _save() {
    final updatedResort = {
      ...widget.resort,
      'name': nameController.text,
      'barangay': barangayController.text,
      'visitors': int.tryParse(visitorsController.text) ?? 0,
      'status': status,
    };
    widget.onSave(updatedResort);
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Resort changes saved!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6FAF9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Edit Resort', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 420),
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Simulate image and upload button
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=800&q=80',
                    height: 140,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.upload, color: Colors.white),
                    label: const Text('Upload New Image'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4856C9),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      minimumSize: const Size.fromHeight(40),
                      textStyle: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Basic Information', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                      const SizedBox(height: 8),
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: 'Resort Name',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: barangayController,
                        decoration: InputDecoration(
                          labelText: 'Barangay',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: visitorsController,
                        decoration: InputDecoration(
                          labelText: 'Visitors (Monthly)',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 18),
                      const Text('Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile<String>(
                              value: 'Active',
                              groupValue: status,
                              title: const Text('Active'),
                              onChanged: (val) => setState(() => status = val!),
                              dense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<String>(
                              value: 'Pending',
                              groupValue: status,
                              title: const Text('Pending'),
                              onChanged: (val) => setState(() => status = val!),
                              dense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<String>(
                              value: 'Deactivated',
                              groupValue: status,
                              title: const Text('Deactivated'),
                              onChanged: (val) => setState(() => status = val!),
                              dense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ElevatedButton(
                    onPressed: _save,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4856C9),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      minimumSize: const Size.fromHeight(44),
                    ),
                    child: const Text('Save Changes', style: TextStyle(fontSize: 16)),
                  ),
                ),
                const SizedBox(height: 18),
              ],
            ),
          ),
        ),
      ),
    );
  }
}