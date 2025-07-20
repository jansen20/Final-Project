import 'package:flutter/material.dart';

class AddItineraryPage extends StatefulWidget {
  const AddItineraryPage({Key? key}) : super(key: key);

  @override
  State<AddItineraryPage> createState() => _AddItineraryPageState();
}

class _AddItineraryPageState extends State<AddItineraryPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  final List<Map<String, String>> beaches = [
    {
      'name': 'Malabrigo Beach',
      'location': 'Lobo, Batangas',
      'desc': 'Famous for its unique pebble shore and scenic cliffs.',
      'tags': 'Clear ClassWater, Scenic Cliffs, Relaxing',
      'image': 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=400&q=80',
    },
    {
      'name': 'Olo-Olo Beach',
      'location': 'Lobo, Batangas',
      'desc': 'A secluded white sand beach, perfect for sunsets.',
      'tags': 'Palm Trees, Less Crowded',
      'image': 'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=400&q=80',
    },
  ];

  final List<Map<String, String>> activities = [
    {
      'name': 'Snorkeling Adventure',
      'duration': '2 hours',
      'desc': 'Explore vibrant coral reefs and diverse marine life.',
      'rating': '4.8',
    },
    {
      'name': 'Fish Watching Tour',
      'duration': '3 hours',
      'desc': 'Witness playful dolphins in their habitat.',
      'rating': '4.5',
    },
  ];

  final List<Map<String, String>> summary = [];

  DateTime? _startDate;
  DateTime? _endDate;
  
  get itineraries => null;

  Future<void> _pickDate(TextEditingController controller, bool isStart) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isStart ? (_startDate ?? DateTime.now()) : (_endDate ?? DateTime.now()),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
          controller.text = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
        } else {
          _endDate = picked;
          controller.text = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
        }
      });
    }
  }

  void _addToSummary(Map<String, String> item) {
    setState(() {
      summary.add(item);
    });
  }

  void _removeFromSummary(int index) {
    setState(() {
      summary.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Itinerary'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: const Color(0xFFF6FAF9),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Itinerary Details
              const Text('Itinerary Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Itinerary Name',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _descController,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _startDateController,
                      readOnly: true,
                      onTap: () => _pickDate(_startDateController, true),
                      decoration: const InputDecoration(
                        labelText: 'Start Date',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      controller: _endDateController,
                      readOnly: true,
                      onTap: () => _pickDate(_endDateController, false),
                      decoration: const InputDecoration(
                        labelText: 'End Date',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              // Choose Your Beaches
              const Text('Choose Your Beaches', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 8),
              Row(
                children: beaches.map((beach) {
                  return Expanded(
                    child: Card(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                beach['image']!,
                                height: 80,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(beach['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                            Text(beach['location']!, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                            const SizedBox(height: 4),
                            Text(beach['desc']!, style: const TextStyle(fontSize: 12)),
                            const SizedBox(height: 4),
                            Text(beach['tags']!, style: const TextStyle(fontSize: 11, color: Colors.teal)),
                            const SizedBox(height: 6),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () => _addToSummary({
                                  'name': beach['name']!,
                                  'desc': beach['desc']!,
                                }),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF4856C9),
                                  minimumSize: const Size(0, 32),
                                ),
                                child: const Text('Add to Itinerary', style: TextStyle(fontSize: 13)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 18),
              // Plan Activities
              const Text('Plan Activities', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 8),
              Row(
                children: activities.map((activity) {
                  return Expanded(
                    child: Card(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              activity['name'] == 'Snorkeling Adventure'
                                  ? Icons.anchor
                                  : Icons.visibility,
                              color: const Color(0xFF4856C9),
                              size: 32,
                            ),
                            const SizedBox(height: 8),
                            Text(activity['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                            Text(activity['duration']!, style: const TextStyle(fontSize: 12, color: Color.fromARGB(255, 158, 158, 158))),
                            const SizedBox(height: 4),
                            Text(activity['desc']!, style: const TextStyle(fontSize: 12)),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.star, color: Colors.amber, size: 16),
                                Text(activity['rating']!, style: const TextStyle(fontSize: 12)),
                              ],
                            ),
                            const SizedBox(height: 6),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () => _addToSummary({
                                  'name': activity['name']!,
                                  'desc': activity['desc']!,
                                }),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF4856C9),
                                  minimumSize: const Size(0, 32),
                                ),
                                child: const Text('Add Activity', style: TextStyle(fontSize: 13)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 18),
              // Itinerary Summary
              const Text('Itinerary Summary', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 8),
              ...summary.asMap().entries.map((entry) {
                final idx = entry.key;
                final item = entry.value;
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: ListTile(
                    leading: const Icon(Icons.place, color: Color(0xFF4856C9)),
                    title: Text(item['name'] ?? ''),
                    subtitle: Text(item['desc'] ?? ''),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _removeFromSummary(idx),
                    ),
                  ),
                );
              }),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text('Add Itinerary'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final newItinerary = {
                        'name': _nameController.text,
                        'description': _descController.text,
                        'startDate': _startDateController.text,
                        'endDate': _endDateController.text,
                        'summary': List<Map<String, String>>.from(summary),
                      };
                      Navigator.pop(context, newItinerary); // Return to ItinerariesPage with new itinerary
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4856C9),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}