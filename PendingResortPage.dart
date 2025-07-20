import 'package:flutter/material.dart';

class PendingResortPage extends StatefulWidget {
  final List<Map<String, dynamic>> pendingResorts;
  final void Function(Map<String, dynamic>)? onApprove;
  final void Function(Map<String, dynamic>)? onReject;

  const PendingResortPage({
    Key? key,
    required this.pendingResorts,
    this.onApprove,
    this.onReject,
  }) : super(key: key);

  @override
  State<PendingResortPage> createState() => _PendingResortPageState();
}

class _PendingResortPageState extends State<PendingResortPage> {
  int? expandedIndex;

  void _showDetails(Map<String, dynamic> resort) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(resort['name'] ?? 'Resort Details'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (resort['images'] != null && resort['images'].isNotEmpty)
                Image.asset(resort['images'][0], height: 180, fit: BoxFit.cover),
              const SizedBox(height: 10),
              Text('Location: ${resort['location'] ?? resort['barangay'] ?? ''}'),
              const SizedBox(height: 5),
              Text('Description: ${resort['description'] ?? 'No description'}'),
              const SizedBox(height: 5),
              Text('Submitted: ${resort['submitted'] ?? ''}'),
              const SizedBox(height: 5),
              Text('Amenities: ${resort['amenities']?.join(', ') ?? 'None'}'),
              // Add more fields as needed
            ],
          ),
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

  void _approveResort(Map<String, dynamic> resort) {
    if (widget.onApprove != null) widget.onApprove!(resort);
    setState(() {
      widget.pendingResorts.remove(resort); // Remove from pending list
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${resort['name']} approved!')),
    );
  }

  void _rejectResort(Map<String, dynamic> resort) {
    if (widget.onReject != null) widget.onReject!(resort);
    setState(() {
      widget.pendingResorts.remove(resort); // Remove from pending list
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${resort['name']} rejected!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 700;
    return Scaffold(
      backgroundColor: const Color(0xFFF6FAF9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Pending Resorts', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: CircleAvatar(
              backgroundColor: Colors.grey[300],
              child: Text('RM', style: TextStyle(color: Colors.black)),
            ),
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: widget.pendingResorts.isEmpty
          ? Center(
              child: Text(
                'No pending resorts.',
                style: TextStyle(fontSize: 18, color: Colors.grey[600]),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
              itemCount: widget.pendingResorts.length,
              itemBuilder: (context, index) {
                final resort = widget.pendingResorts[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 22),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 3,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        resort['images'] != null && resort['images'].isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  resort['images'][0],
                                  height: isWide ? 180 : 120,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Container(
                                height: isWide ? 180 : 120,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(Icons.image, size: 40, color: Colors.grey),
                              ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              'Submitted: ${resort['submitted'] ?? ''}',
                              style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                              decoration: BoxDecoration(
                                color: Colors.red.shade100,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'New Submission',
                                style: TextStyle(
                                  color: Colors.red.shade700,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          resort['name'] ?? '',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                        ),
                        Text(
                          resort['location'] ?? resort['barangay'] ?? '',
                          style: TextStyle(color: Colors.grey[700], fontSize: 14),
                        ),
                        if (resort['description'] != null) ...[
                          const SizedBox(height: 7),
                          Text(
                            resort['description'],
                            style: const TextStyle(fontSize: 14, color: Colors.black87),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () => _approveResort(resort),
                                icon: const Icon(Icons.check, color: Colors.white, size: 20),
                                label: const Text('Approve', style: TextStyle(fontSize: 16)),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue.shade700,
                                  minimumSize: const Size(0, 44),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () => _rejectResort(resort),
                                icon: const Icon(Icons.close, color: Colors.white, size: 20),
                                label: const Text('Reject', style: TextStyle(fontSize: 16)),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red.shade700,
                                  minimumSize: const Size(0, 44),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            IconButton(
                              icon: Icon(Icons.visibility_outlined, color: Colors.grey[700], size: 26),
                              onPressed: () => _showDetails(resort),
                              tooltip: 'View Details',
                            ),
                          ],
                        ),
                        // Expand/collapse for more info
                        if (expandedIndex == index)
                          Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (resort['amenities'] != null)
                                  Text('Amenities: ${resort['amenities'].join(', ')}'),
                                // Add more expandable info here
                              ],
                            ),
                          ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                expandedIndex = expandedIndex == index ? null : index;
                              });
                            },
                            child: Text(
                              expandedIndex == index ? 'Show Less' : 'Show More',
                              style: TextStyle(color: Colors.blue.shade700),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Resort',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sync),
            label: 'Pending',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/addresort');
          }
        },
      ),
    );
  }
}