import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Add this import

class AddResortPage extends StatefulWidget {
  @override
  State<AddResortPage> createState() => _AddResortPageState();
}

class _AddResortPageState extends State<AddResortPage> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _amenities = [
    'Free Wifi', 'Parking', 'Spa Services', 'Air Conditioning',
    'Fitness Center', 'Restaurant', 'Swimming Pool', 'Pet Friendly'
  ];
  final Set<String> _selectedAmenities = {};
  List<XFile>? _images; // Store selected images

  // Define the resorts list to store added resorts
  final List<Map<String, dynamic>> resorts = [];

  final _nameController = TextEditingController();
  final _barangayController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade700,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/resortmanagement',
              (route) => false,
            );
          },
        ),
        title: Text('Add Resort', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(icon: Icon(Icons.notifications_none, color: Colors.white), onPressed: () {}),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: CircleAvatar(
              backgroundColor: Colors.teal.shade200,
              child: Text('RL', style: TextStyle(color: Colors.teal.shade900)),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.teal.shade50,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            // Resort Information
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              margin: const EdgeInsets.only(bottom: 18),
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.info_outline, color: Colors.teal.shade400),
                          const SizedBox(width: 8),
                          Text('Resort Information', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text('Provide essential details about your resort.', style: TextStyle(color: Colors.grey[700], fontSize: 15)),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Resort Name',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        ),
                        validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Address Line 1',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'City',
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'State/Province',
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Zip/Postal Code',
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Country',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Contact Phone',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Contact Email',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Visitors (Monthly)',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Amenities
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              margin: const EdgeInsets.only(bottom: 18),
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.check_circle_outline, color: Colors.teal.shade400),
                        const SizedBox(width: 8),
                        Text('Amenities', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text('Select the amenities available at your resort.', style: TextStyle(color: Colors.grey[700], fontSize: 15)),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: _amenities.map((amenity) {
                        final selected = _selectedAmenities.contains(amenity);
                        return FilterChip(
                          label: Text(amenity, style: TextStyle(fontWeight: FontWeight.w500)),
                          selected: selected,
                          selectedColor: Colors.teal.shade100,
                          checkmarkColor: Colors.teal.shade700,
                          backgroundColor: Colors.grey.shade100,
                          onSelected: (val) {
                            setState(() {
                              if (val) {
                                _selectedAmenities.add(amenity);
                              } else {
                                _selectedAmenities.remove(amenity);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
            // Add Resort Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal.shade700,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 2,
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newResort = {
                      'name': _nameController.text,
                      'barangay': _barangayController.text,
                      'visitors': 0,
                      'status': 'Pending',
                      'amenities': _selectedAmenities.toList(),
                      'images': _images?.map((img) => img.path).toList() ?? [],
                    };
                    Navigator.pop(context, newResort); // Return new resort to previous page
                  }
                },
                child: Text('Add Resort', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}