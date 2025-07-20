import 'package:flutter/material.dart';
import 'ResortManagementPage.dart' as resort; // SidebarMenu assumed here
import 'additinerarypage.dart';

class ItinerariesPage extends StatefulWidget {
  const ItinerariesPage({Key? key}) : super(key: key);

  @override
  State<ItinerariesPage> createState() => _ItinerariesPageState();
}

class _ItinerariesPageState extends State<ItinerariesPage> {
  final List<Map<String, dynamic>> itineraries = []; // Store added itineraries

  // Add these variables for dropdowns and options
  String selectedResort = 'All';
  String selectedStatus = 'All';
  final List<String> resortOptions = ['All', 'Gerthel Beach', 'Malabrigo Lighthouse', 'Tulay na Bato'];
  final List<String> statusOptions = ['All', 'Active', 'Completed', 'Cancelled'];

  @override
  Widget build(BuildContext context) {
    final isMobileScreen = MediaQuery.of(context).size.width < 900;

    // Move routes here so it's accessible
    final List<String> routes = [
      '/dashboard',
      '/visitortracking',
      '/resortmanagement',
      '/environmentalfees',
      '/itineraries',
      '/analytics',
      '/settings',
    ];

    void handleSidebarSelect(BuildContext context, int index) async {
      if (isMobileScreen) {
        // Try to pop the drawer if possible, but don't crash if not
        Navigator.of(context).maybePop();
        // Wait for the drawer to close before navigating
        Future.delayed(const Duration(milliseconds: 250), () {
          if (index >= 0 && index < routes.length) {
            if (ModalRoute.of(context)?.settings.name != routes[index]) {
              Navigator.pushReplacementNamed(context, routes[index]);
            }
          }
        });
      } else {
        if (index >= 0 && index < routes.length) {
          if (ModalRoute.of(context)?.settings.name != routes[index]) {
            Navigator.pushReplacementNamed(context, routes[index]);
          }
        }
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF6FAF9),
      drawer: isMobileScreen
          ? Drawer(
              child: resort.SidebarMenu(
                selectedIndex: 4,
                onSelect: (int index) => handleSidebarSelect(context, index),
              ),
            )
          : null,
      appBar: isMobileScreen
          ? AppBar(
              backgroundColor: const Color(0xFF00695C),
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.white),
              title: const Text(
                "Itineraries",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            )
          : null,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isMobileScreen)
              resort.SidebarMenu(
                selectedIndex: 4,
                onSelect: (int index) => handleSidebarSelect(context, index),
              ),
            // Wrap the main Column in Expanded for both desktop and mobile
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: isMobileScreen ? 10 : 18,
                      left: isMobileScreen ? 8 : 32,
                      right: isMobileScreen ? 8 : 32,
                      bottom: isMobileScreen ? 6 : 12,
                    ),
                    child: Text(
                      "Lobo Tourism Management Itineraries",
                      style: TextStyle(
                        fontSize: isMobileScreen ? 17 : 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.teal.shade900,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        vertical: isMobileScreen ? 8 : 32,
                        horizontal: isMobileScreen ? 0 : 32,
                      ),
                      child: Center(
                        child: Container(
                          // Only constrain width on desktop
                          constraints: isMobileScreen
                              ? null
                              : const BoxConstraints(maxWidth: 1200),
                          padding: EdgeInsets.all(isMobileScreen ? 4 : 32),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 12,
                                offset: Offset(0, 4),
                              )
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Summary cards
                              isMobileScreen
                                  ? Column(
                                      children: [
                                        _SummaryCard(
                                          icon: Icons.list_alt,
                                          value: '120',
                                          label: 'Total Itineraries',
                                          subLabel: 'Up by 10% from last month',
                                          color: Colors.teal,
                                        ),
                                        const SizedBox(height: 8),
                                        _SummaryCard(
                                          icon: Icons.check_circle,
                                          value: '85',
                                          label: 'Completed',
                                          subLabel: '70% completion rate',
                                          color: Colors.green,
                                        ),
                                        const SizedBox(height: 8),
                                        _SummaryCard(
                                          icon: Icons.schedule,
                                          value: '25',
                                          label: 'Active',
                                          subLabel: 'Ongoing this week',
                                          color: Colors.orange,
                                        ),
                                        const SizedBox(height: 8),
                                        _SummaryCard(
                                          icon: Icons.cancel,
                                          value: '10',
                                          label: 'Cancelled',
                                          subLabel: 'Down by 5%',
                                          color: Colors.red,
                                        ),
                                      ],
                                    )
                                  : Row(
                                      children: [
                                        Expanded(
                                          child: _SummaryCard(
                                            icon: Icons.list_alt,
                                            value: '120',
                                            label: 'Total Itineraries',
                                            subLabel: 'Up by 10% from last month',
                                            color: Colors.teal,
                                          ),
                                        ),
                                        const SizedBox(width: 18),
                                        Expanded(
                                          child: _SummaryCard(
                                            icon: Icons.check_circle,
                                            value: '85',
                                            label: 'Completed',
                                            subLabel: '70% completion rate',
                                            color: Colors.green,
                                          ),
                                        ),
                                        const SizedBox(width: 18),
                                        Expanded(
                                          child: _SummaryCard(
                                            icon: Icons.schedule,
                                            value: '25',
                                            label: 'Active',
                                            subLabel: 'Ongoing this week',
                                            color: Colors.orange,
                                          ),
                                        ),
                                        const SizedBox(width: 18),
                                        Expanded(
                                          child: _SummaryCard(
                                            icon: Icons.cancel,
                                            value: '10',
                                            label: 'Cancelled',
                                            subLabel: 'Down by 5%',
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                              const SizedBox(height: 20),
                              
                              const SizedBox(height: 10),
                              // Remove the DataTable section as per the suggestion
                              const SizedBox(height: 24),
                              Divider(thickness: 1.2, color: Colors.tealAccent, height: 32),
                              const SizedBox(height: 24),
                              // Other Itineraries of Lobo
                              Text(
                                'Other Itineraries of Lobo',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal.shade900,
                                ),
                              ),
                              const SizedBox(height: 18),
                              // Filter chips row
                              Row(
                                children: [
                                  ChoiceChip(
                                    label: Text('Recent'),
                                    selected: true,
                                    onSelected: (_) {},
                                  ),
                                  const SizedBox(width: 8),
                                  ChoiceChip(
                                    label: Text('All'),
                                    selected: false,
                                    onSelected: (_) {},
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              // Category chips row
                              Wrap(
                                spacing: 10,
                                children: [
                                  FilterChip(
                                    label: Text('All'),
                                    selected: true,
                                    onSelected: (_) {},
                                    selectedColor: Colors.teal,
                                    labelStyle: TextStyle(color: Colors.white),
                                  ),
                                  FilterChip(
                                    label: Text('Historical'),
                                    selected: false,
                                    onSelected: (_) {},
                                  ),
                                  FilterChip(
                                    label: Text('Nature'),
                                    selected: false,
                                    onSelected: (_) {},
                                  ),
                                  FilterChip(
                                    label: Text('Beach'),
                                    selected: false,
                                    onSelected: (_) {},
                                  ),
                                ],
                              ),
                              const SizedBox(height: 18),
                              // Cards grid and Add New Itinerary card
                              if (isMobileScreen)
                                ...[
                                  // Cards grid (single column)
                                  _ItineraryCard(
                                    imageUrl: 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=400&q=80',
                                    title: 'Gerthel Beach',
                                    location: 'Malabrigo',
                                    duration: 'Half-day',
                                    tag: 'Beach',
                                    tagColor: Colors.amber,
                                    onDelete: () {},
                                    onEdit: () {},
                                  ),
                                  const SizedBox(height: 18),
                                  // Add New Itinerary Card
                                  Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      side: BorderSide(
                                        color: Colors.teal.withOpacity(0.35),
                                        width: 2,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                    elevation: 0,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 18),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.add_circle_outline, color: Colors.teal.shade700, size: 38),
                                          const SizedBox(height: 10),
                                          Text(
                                            "Add New Itinerary",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: Colors.teal.shade900,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          const SizedBox(height: 12),
                                          Text(
                                            "Effortlessly add new attractions and experiences to your Lobo itineraries.",
                                            style: TextStyle(color: Colors.grey[700], fontSize: 15),
                                            textAlign: TextAlign.center,
                                          ),
                                          const SizedBox(height: 18),
                                          ElevatedButton(
                                            onPressed: () async {
                                              final newItinerary = await Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => const AddItineraryPage()),
                                              );
                                              if (newItinerary != null && newItinerary is Map<String, dynamic>) {
                                                setState(() {
                                                  itineraries.add(newItinerary);
                                                });
                                              }
                                            },
                                            child: const Text('Add Item'),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.teal,
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ]
                              else
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Cards grid
                                    Expanded(
                                      flex: 3,
                                      child: SizedBox(
                                        height: 220,
                                        child: LayoutBuilder(
                                          builder: (context, constraints) {
                                            final isMobile = constraints.maxWidth < 700;
                                            return GridView.count(
                                              crossAxisCount: isMobile ? 1 : 3,
                                              crossAxisSpacing: 18,
                                              mainAxisSpacing: 18,
                                              physics: const NeverScrollableScrollPhysics(),
                                              childAspectRatio: 1.25,
                                              children: [
                                                _ItineraryCard(
                                                  imageUrl: 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=400&q=80',
                                                  title: 'Gerthel Beach',
                                                  location: 'Malabrigo',
                                                  duration: 'Half-day',
                                                  tag: 'Beach',
                                                  tagColor: Colors.amber,
                                                  onDelete: () {},
                                                  onEdit: () {},
                                                ),
                                                _ItineraryCard(
                                                  imageUrl: 'https://images.unsplash.com/photo-1464983953574-0892a716854b?auto=format&fit=crop&w=400&q=80',
                                                  title: 'Malabrigo Lighthouse',
                                                  location: 'Malabrigo',
                                                  duration: '2-3 hours',
                                                  tag: 'Historical',
                                                  tagColor: Colors.blue,
                                                  onDelete: () {},
                                                  onEdit: () {},
                                                ),
                                                _ItineraryCard(
                                                  imageUrl: 'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=400&q=80',
                                                  title: 'Tulay na Bato',
                                                  location: 'Lobo Proper',
                                                  duration: '1-2 hours',
                                                  tag: 'Nature',
                                                  tagColor: Colors.pink,
                                                  onDelete: () {},
                                                  onEdit: () {},
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 24),
                                    // Add New Itinerary Card
                                    Expanded(
                                      flex: 1,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16),
                                          side: BorderSide(
                                            color: Colors.teal.withOpacity(0.35),
                                            width: 2,
                                            style: BorderStyle.solid,
                                          ),
                                        ),
                                        elevation: 0,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 18),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(Icons.add_circle_outline, color: Colors.teal.shade700, size: 38),
                                              const SizedBox(height: 10),
                                              Text(
                                                "Add New Itinerary",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: Colors.teal.shade900,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              const SizedBox(height: 12),
                                              Text(
                                                "Effortlessly add new attractions and experiences to your Lobo itineraries.",
                                                style: TextStyle(color: Colors.grey[700], fontSize: 15),
                                                textAlign: TextAlign.center,
                                              ),
                                              const SizedBox(height: 18),
                                              ElevatedButton(
                                                onPressed: () async {
                                                  final newItinerary = await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(builder: (context) => const AddItineraryPage()),
                                                  );
                                                  if (newItinerary != null && newItinerary is Map<String, dynamic>) {
                                                    setState(() {
                                                      itineraries.add(newItinerary);
                                                    });
                                                  }
                                                },
                                                child: const Text('Add Item'),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.teal,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Below your cards/grid, display the itineraries list:
                  if (itineraries.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Container(
                        height: 120, // Smaller height for the scrollable area
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Itinerary Logs',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.teal,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const SizedBox(height: 8),
                              ...itineraries.asMap().entries.map((entry) {
                                final idx = entry.key;
                                final itinerary = entry.value;
                                return Card(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                                  color: const Color(0xFFF3F7F6),
                                  elevation: 1,
                                  margin: const EdgeInsets.symmetric(vertical: 4),
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                    isThreeLine: true,
                                    title: Text(
                                      itinerary['name'] ?? '',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.only(top: 1),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            itinerary['description'] ?? '',
                                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                                          ),
                                          if (itinerary['summary'] != null && itinerary['summary'].isNotEmpty)
                                            Padding(
                                              padding: const EdgeInsets.only(top: 4),
                                              child: Wrap(
                                                spacing: 6,
                                                children: List.generate(
                                                  itinerary['summary'].length,
                                                  (i) => Chip(
                                                    label: Text(
                                                      itinerary['summary'][i]['name'] ?? '',
                                                      style: const TextStyle(fontSize: 11),
                                                    ),
                                                    backgroundColor: Colors.teal.shade50,
                                                    visualDensity: VisualDensity.compact,
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    trailing: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${itinerary['startDate']} - ${itinerary['endDate']}',
                                          style: const TextStyle(fontSize: 11, color: Colors.teal),
                                        ),
                                        const SizedBox(height: 4),
                                        IconButton(
                                          icon: const Icon(Icons.delete, color: Colors.redAccent, size: 16), // Smaller icon
                                          tooltip: 'Delete',
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (ctx) => AlertDialog(
                                                title: const Text('Delete Itinerary'),
                                                content: const Text('Are you sure you want to delete this itinerary?'),
                                                actions: [
                                                  TextButton(
                                                    child: const Text('Cancel'),
                                                    onPressed: () => Navigator.of(ctx).pop(),
                                                  ),
                                                  TextButton(
                                                    child: const Text('Delete', style: TextStyle(color: Colors.red)),
                                                    onPressed: () {
                                                      setState(() {
                                                        itineraries.removeAt(idx);
                                                      });
                                                      Navigator.of(ctx).pop();
                                                    },
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
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
      ),
    );
  }
  
  // Removed incorrect override of setState
}

// Reusable summary card widget
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
    final isMobileScreen = MediaQuery.of(context).size.width < 900;
    final cardWidth = isMobileScreen
        ? MediaQuery.of(context).size.width * 0.95
        : double.infinity;

    return Center(
      child: SizedBox(
        width: cardWidth,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 18.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: color.withOpacity(0.15),
                  child: Icon(icon, color: color, size: 28),
                  radius: 24,
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color)),
                      const SizedBox(height: 4),
                      Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[800])),
                      const SizedBox(height: 4),
                      Text(subLabel, style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                    ],
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

// Itinerary card for "Other Itineraries of Lobo" section
class _ItineraryCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String location;
  final String duration;
  final String tag;
  final Color tagColor;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const _ItineraryCard({
    required this.imageUrl,
    required this.title,
    required this.location,
    required this.duration,
    required this.tag,
    required this.tagColor,
    required this.onDelete,
    required this.onEdit,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      child: SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                imageUrl,
                height: 75,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 1),
                        decoration: BoxDecoration(
                          color: tagColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          tag,
                          style: TextStyle(
                            color: tagColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(location, style: TextStyle(color: Colors.grey[700], fontSize: 11)),
                  const SizedBox(height: 1),
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 12, color: Colors.grey),
                      const SizedBox(width: 3),
                      Text(duration, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, size: 15),
                        onPressed: onEdit,
                        tooltip: 'Edit',
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, size: 15),
                        onPressed: onDelete,
                        tooltip: 'Delete',
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                      ),
                    ],
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