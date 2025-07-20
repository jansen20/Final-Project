import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditResortPage extends StatefulWidget {
  final Map<String, dynamic>? resort;
  final void Function(Map<String, dynamic>)? onSave;

  const EditResortPage({Key? key, this.resort, this.onSave}) : super(key: key);

  @override
  State<EditResortPage> createState() => _EditResortPageState();
}

class _EditResortPageState extends State<EditResortPage> {
  late TextEditingController nameController;
  late TextEditingController barangayController;
  late TextEditingController visitorsController;
  String status = 'Active';

  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.resort?['name'] ?? '');
    barangayController = TextEditingController(text: widget.resort?['barangay'] ?? '');
    visitorsController = TextEditingController(text: widget.resort?['visitors']?.toString() ?? '');
    status = widget.resort?['status'] ?? 'Active';
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    barangayController.dispose();
    visitorsController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    final updatedResort = {
      ...?widget.resort,
      'name': nameController.text,
      'barangay': barangayController.text,
      'visitors': int.tryParse(visitorsController.text) ?? 0,
      'status': status,
    };
    if (widget.onSave != null) widget.onSave!(updatedResort);
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Resort changes saved!')),
    );
  }

  void _deactivateResort() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Resort deactivated!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6FAF9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Edit Resort', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/resortmanagement');
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 420),
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Show selected image or default
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: _selectedImage != null
                      ? Image.file(
                          _selectedImage!,
                          height: 140,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
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
                    onPressed: _pickImage,
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
                          labelText: 'Max Visitors',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 18),
                      const Text('Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: status,
                        items: [
                          'Active',
                          'Inactive',
                        ].map((stat) => DropdownMenuItem(value: stat, child: Text(stat))).toList(),
                        onChanged: (val) => setState(() => status = val ?? 'Active'),
                        decoration: InputDecoration(
                          labelText: 'Resort Status',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ElevatedButton(
                    onPressed: _deactivateResort,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      minimumSize: const Size.fromHeight(44),
                    ),
                    child: const Text('Deactivate Resort', style: TextStyle(fontSize: 16)),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ElevatedButton(
                    onPressed: _saveChanges,
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Resort',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sync),
            label: 'Pending',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: 'Edit Resort',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/addresort');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/pendingresort');
          }
        },
      ),
    );
  }
}