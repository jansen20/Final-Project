import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;


void main() {
  runApp(MaterialApp(
    home: ManageResortInfoScreen(),
    theme: ThemeData(
      primarySwatch: Colors.teal,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.teal),
        titleTextStyle: TextStyle(
          color: Colors.teal,
          fontWeight: FontWeight.bold,
          fontSize: 28,
          fontFamily: 'Pacifico',
        ),
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.teal,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.teal),
        ),
        labelStyle: TextStyle(color: Colors.teal[800]),
      ),
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.teal).copyWith(
        secondary: Colors.tealAccent,
        background: Colors.white,
      ),
    ),
  ));
}



class ManageResortInfoScreen extends StatefulWidget {                                                   ////// //RESORT INFO/////////////                        
  _ManageResortInfoScreenState createState() => _ManageResortInfoScreenState();
}

class _ManageResortInfoScreenState extends State<ManageResortInfoScreen> {
  final Set<String> selectedAmenities = {};

  List<Map<String, dynamic>> roomTypes = [
    {'type': 'Standard King Room', 'price': '250', 'capacity': '2'},
    {'type': 'Deluxe Ocean View', 'price': '380', 'capacity': '2'},
    {'type': 'Family Suite', 'price': '450', 'capacity': '4'},
    {'type': 'Executive Penthouse', 'price': '800', 'capacity': '2'},
  ];

  // Add missing fields for policy settings
  String selectedCheckIn = "2:00 PM";
  String selectedCheckOut = "11:00 AM";
  bool isPetPolicyEnabled = false;
  TextEditingController cancellationController = TextEditingController();

  // Media management state
  List<XFile> _mediaFiles = [];
final ImagePicker _picker = ImagePicker();
  int? _selectedPreviewIndex; // <-- Add this line
  List<Uint8List?> _mediaBytes = []; // For web image previews

  Future<void> _pickImages() async {
    final List<XFile>? pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      if (kIsWeb) {
        // Read all bytes before calling setState
        final List<Uint8List> newBytes = [];
        for (var file in pickedFiles) {
          final bytes = await file.readAsBytes();
          newBytes.add(bytes);
        }
        setState(() {
          _mediaFiles.addAll(pickedFiles);
          _mediaBytes.addAll(newBytes);
        });
      } else {
        setState(() {
          _mediaFiles.addAll(pickedFiles);
        });
      }
    }
  }

  void _removeImage(int index) {
    setState(() {
      _mediaFiles.removeAt(index);
      if (kIsWeb && index < _mediaBytes.length) {
        _mediaBytes.removeAt(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWide = screenWidth > 700;

    return Scaffold(
  appBar: AppBar(
    title: const Text("Manage Resort Information"),
    titleTextStyle: const TextStyle(
      color: Colors.teal,
      fontWeight: FontWeight.bold,
      fontSize: 28,
      fontFamily: 'Pacifico', // Playful font, ensure it's available or fallback
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
        children: [
          _sectionHeader(context, Icons.info, "General Information"),
          _generalInfoSection(context, isWide),
          const SizedBox(height: 16),
          Divider(thickness: 2, color: Colors.teal[100]),
          isWide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: Column(
                      children: [
                        _sectionHeader(context, Icons.pool, "Amenities & Services"),
                        _amenitiesSection(context),
                      ],
                    )),
                    const SizedBox(width: 16),
                    Expanded(child: Column(
                      children: [
                        _sectionHeader(context, Icons.hotel, "Pricing & Room Types"),
                        _roomPricingSection(context),
                      ],
                    )),
                  ],
                )
              : Column(
                  children: [
                    _sectionHeader(context, Icons.pool, "Amenities & Services"),
                    _amenitiesSection(context),
                    const SizedBox(height: 16),
                    _sectionHeader(context, Icons.hotel, "Pricing & Room Types"),
                    _roomPricingSection(context),
                  ],
                ),
          const SizedBox(height: 16),
          Divider(thickness: 2, color: Colors.teal[100]),
          _sectionHeader(context, Icons.policy, "Policy Settings"),
          _policySettingsSection(context, isWide),
          const SizedBox(height: 16),
          Divider(thickness: 2, color: Colors.teal[100]),
          _sectionHeader(context, Icons.photo_library, "Media Management"),
          _mediaManagementSection(context),
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
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.teal[800],
              fontFamily: 'Pacifico', // Playful font for headers
            ),
          ),
        ],
      ),
    );
  }

  Widget _generalInfoSection(BuildContext context, bool isWide) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      color: Colors.white.withOpacity(0.95),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "General Information",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            isWide
                ? Row(
                    children: [
                      Expanded(child: _textField("Resort Name")),
                      const SizedBox(width: 16),
                      Expanded(child: _textField("Resort Address")),
                    ],
                  )
                : Column(
                    children: [
                      _textField("Resort Name"),
                      const SizedBox(height: 10),
                      _textField("Resort Address"),
                    ],
                  ),
            const SizedBox(height: 10),
            _textField("Resort Description", maxLines: 3),
            const SizedBox(height: 10),
            isWide
                ? Row(
                    children: [
                      Expanded(child: _textField("Contact Email")),
                      const SizedBox(width: 16),
                      Expanded(child: _textField("Contact Phone")),
                      const SizedBox(width: 16),
                      Expanded(child: _textField("Website URL")),
                    ],
                  )
                : Column(
                    children: [
                      _textField("Contact Email"),
                      const SizedBox(height: 10),
                      _textField("Contact Phone"),
                      const SizedBox(height: 10),
                      _textField("Website URL"),
                    ],
                  ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text("Save Info"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[700],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  // TODO: Implement your save logic here
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Resort information saved")),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _amenitiesSection(BuildContext context) {
    final amenities = [
      'Swimming Pool', 'Fitness Center', 'Free Wi-Fi', 'Restaurants & Bar',
      'Spa & Wellness', 'Conference Rooms', 'Kids Club', 'Beach Access',
      'Pet Friendly', 'Parking', 'Shuttle Service', 'Room Service',
    ];

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      color: Colors.white.withOpacity(0.95),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: amenities.map((item) {
                final isSelected = selectedAmenities.contains(item);
                return FilterChip(
                  label: Text(item, style: TextStyle(fontWeight: FontWeight.w600)),
                  selected: isSelected,
                  backgroundColor: Colors.teal[50],
                  selectedColor: Colors.teal[300],
                  checkmarkColor: Colors.white,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        selectedAmenities.add(item);
                      } else {
                        selectedAmenities.remove(item);
                      }
                    });
                  },
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            Text(
              'Selected:  ${selectedAmenities.join(', ')}',
              style: TextStyle(color: Colors.teal[700], fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  Widget _roomPricingSection(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      color: Colors.white.withOpacity(0.95),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Pricing & Room Types",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold)),
            ...roomTypes.asMap().entries.map((entry) {
              final index = entry.key;
              final room = entry.value;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(room['type'], style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Text("₱${room['price']}"),
                        SizedBox(width: 10),
                        Text("Capacity: ${room['capacity']}"),
                        Spacer(),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              roomTypes.removeAt(index);
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[700],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () async {
                  final newRoom = await _showAddRoomDialog(context);
                  if (newRoom != null) {
                    setState(() {
                      roomTypes.add(newRoom);
                    });
                  }
                },
                icon: Icon(Icons.add),
                label: Text("Add New Room Type"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Map<String, dynamic>?> _showAddRoomDialog(BuildContext context) async {
    final typeController = TextEditingController();
    final priceController = TextEditingController();
    final capacityController = TextEditingController();

    return showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Room Type'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: typeController, decoration: InputDecoration(labelText: 'Room Type')),
            TextField(controller: priceController, decoration: InputDecoration(labelText: 'Price')),
            TextField(controller: capacityController, decoration: InputDecoration(labelText: 'Capacity')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              final type = typeController.text.trim();
              final price = priceController.text.trim();
              final capacity = capacityController.text.trim();
              if (type.isNotEmpty && price.isNotEmpty && capacity.isNotEmpty) {
                Navigator.pop(context, {
                  'type': type,
                  'price': price,
                  'capacity': capacity,
                });
              }
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }

  Widget _policySettingsSection(BuildContext context, bool isWide) {
  final checkInOptions = [" ","2:00 PM", "3:00 PM", "4:00 PM"];
  final checkOutOptions = [" ","10:00 AM", "11:00 AM", "12:00 PM"];

  return Card(
    elevation: 8,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
    color: Colors.white.withOpacity(0.95),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Policy Settings",
            style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          // Dropdowns: wide or stacked
          isWide
              ? Row(
                  children: [
                    Expanded(
                      child: _buildDropdown(
                        "Standard Check-In Time",
                        selectedCheckIn,
                        checkInOptions,
                        (value) => setState(() => selectedCheckIn = value),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildDropdown(
                        "Standard Check-Out Time",
                        selectedCheckOut,
                        checkOutOptions,
                        (value) => setState(() => selectedCheckOut = value),
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    _buildDropdown(
                      "Standard Check-In Time",
                      selectedCheckIn,
                      checkInOptions,
                      (value) => setState(() => selectedCheckIn = value),
                    ),
                    const SizedBox(height: 10),
                    _buildDropdown(
                      "Standard Check-Out Time",
                      selectedCheckOut,
                      checkOutOptions,
                      (value) => setState(() => selectedCheckOut = value),
                    ),
                  ],
                ),

          const SizedBox(height: 10),

          // Cancellation Policy field
          TextFormField(
            controller: cancellationController,
            maxLines: 2,
            decoration: const InputDecoration(
              labelText: "Cancellation Policy",
              
            ),
          ),

          const SizedBox(height: 10),

          // Pet Policy toggle
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Enable Pet Policy"),
              Switch(
                value: isPetPolicyEnabled,
                onChanged: (value) {
                  setState(() {
                    isPetPolicyEnabled = value;
                  });
                },
                activeColor: const Color.fromARGB(255, 5, 81, 76),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Save button
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.save),
              label: const Text("Save Settings"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal[700],
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Saved:\n"
                      "Check-In: $selectedCheckIn\n"
                      "Check-Out: $selectedCheckOut\n"
                      "Pet Policy: ${isPetPolicyEnabled ? 'Enabled' : 'Disabled'}\n"
                      "Cancellation: ${cancellationController.text}",
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
}



 Widget _mediaManagementSection(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      color: Colors.white.withOpacity(0.95),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Media Management",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            GestureDetector(
              onTap: _pickImages,
              child: Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                    child: Text("Drag & drop image or Click to Upload\nBrowse files",
                        textAlign: TextAlign.center)),
              ),
            ),
            SizedBox(height: 10),
            // Preview section
            if (_selectedPreviewIndex != null && _selectedPreviewIndex! < _mediaFiles.length)
              Column(
                children: [
                  Text("Preview", style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child:
                      kIsWeb
                        ? (_mediaBytes.length > _selectedPreviewIndex!
                            ? Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.teal.withOpacity(0.2),
                                      blurRadius: 12,
                                      offset: Offset(0, 6),
                                    ),
                                  ],
                                ),
                                child: Image.memory(
                                  _mediaBytes[_selectedPreviewIndex!]!,
                                  width: double.infinity,
                                  height: 200,
                                  fit: BoxFit.contain,
                                ),
                              )
                            : SizedBox.shrink())
                        : Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.teal.withOpacity(0.2),
                                  blurRadius: 12,
                                  offset: Offset(0, 6),
                                ),
                              ],
                            ),
                            child: Image.file(
                              File(_mediaFiles[_selectedPreviewIndex!].path),
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.contain,
                            ),
                          ),
                  ),
                  SizedBox(height: 8),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _selectedPreviewIndex = null;
                      });
                    },
                    child: Text("Unpreview"),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                for (int i = 0; i < _mediaFiles.length; i++)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedPreviewIndex = i;
                      });
                    },
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child:
                            kIsWeb
                              ? (_mediaBytes.length > i
                                  ? Container(
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.teal.withOpacity(0.15),
                                            blurRadius: 8,
                                            offset: Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: Image.memory(
                                        _mediaBytes[i]!,
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : SizedBox(width: 80, height: 80))
                              : Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.teal.withOpacity(0.15),
                                        blurRadius: 8,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Image.file(
                                    File(_mediaFiles[i].path),
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () => _removeImage(i),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.close, color: Colors.white, size: 18),
                            ),
                          ),
                        ),
                        if (_selectedPreviewIndex == i)
                          Positioned(
                            bottom: 0,
                            left: 0,
                            child: Icon(Icons.visibility, color: Colors.teal, size: 20),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: OutlinedButton.icon(
                icon: Icon(Icons.photo_library),
                label: Text("Manage Gallery"),
                onPressed: _pickImages, // Now clicking this button opens image picker
              ),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                icon: Icon(Icons.cloud_upload),
                label: Text("Submit Images"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[700],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  // TODO: Replace with actual upload logic if needed
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Images submitted! (${_mediaFiles.length} images)")),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
           
  Widget _textField(String label, {String? hint, int maxLines = 1}) {
    return TextFormField(
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
      ),
    );
  }

  Widget _dropdownField(String label, String value) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(labelText: label),
      items: [DropdownMenuItem(value: value, child: Text(value))],
      onChanged: (_) {},
    );
  }

  Widget _buildDropdown(
    String label,
    String selectedValue,
    List<String> options,
    ValueChanged<String> onChanged,
  ) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      decoration: InputDecoration(labelText: label),
      items: options.map((option) {
        return DropdownMenuItem(
          value: option,
          child: Text(option),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) {
          onChanged(value);
        }
      },
    );
  }
} 