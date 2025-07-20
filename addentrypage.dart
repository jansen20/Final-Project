import 'package:flutter/material.dart';

class AddEntryPage extends StatefulWidget {
  const AddEntryPage({Key? key}) : super(key: key);

  @override
  State<AddEntryPage> createState() => _AddEntryPageState();
}

class _AddEntryPageState extends State<AddEntryPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _resortController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _selectedMethod;
  String? _selectedStatus;
  String? _selectedCategory;

  final List<String> _methods = ['Cash', 'Credit Card', 'GCash', 'Other'];
  final List<String> _statuses = ['Paid', 'Pending', 'Refunded'];
  final List<String> _categories = [
    'Solid Waste',
    'Water Usage',
    'Carbon Emissions',
    'Wildlife Impact',
    'Other',
  ];

  void _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      _dateController.text = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final newEntry = {
        'id': 'TXN${DateTime.now().millisecondsSinceEpoch}', // Simple unique ID
        'date': _dateController.text,
        'name': _nameController.text,
        'resort': _resortController.text,
        'amount': '₱${_amountController.text}',
        'method': _selectedMethod ?? '',
        'status': _selectedStatus ?? 'Paid',
        'category': _selectedCategory ?? '',
        'description': _descriptionController.text,
      };
      Navigator.pop(context, newEntry);
    }
  }

  void _reset() {
    _formKey.currentState?.reset();
    _dateController.clear();
    _amountController.clear();
    _nameController.clear();
    _resortController.clear();
    _descriptionController.clear();
    setState(() {
      _selectedMethod = null;
      _selectedStatus = null;
      _selectedCategory = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6FAF9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Add New Entry', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Date of Entry
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Date of Entry', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _dateController,
                        readOnly: true,
                        onTap: _pickDate,
                        decoration: InputDecoration(
                          hintText: 'Select the date fee was incurred.',
                          prefixIcon: const Icon(Icons.calendar_today),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        validator: (v) => v == null || v.isEmpty ? 'Please select a date.' : null,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Select the date the fee was incurred.',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
              // Tourist Name
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Tourist Name', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          hintText: 'Enter tourist name',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        validator: (v) => v == null || v.isEmpty ? 'Please enter a name.' : null,
                      ),
                    ],
                  ),
                ),
              ),
              // Resort
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Resort', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _resortController,
                        decoration: InputDecoration(
                          hintText: 'Enter resort name',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        validator: (v) => v == null || v.isEmpty ? 'Please enter a resort.' : null,
                      ),
                    ],
                  ),
                ),
              ),
              // Fee Amount
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Fee Amount', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _amountController,
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          prefixText: '₱ ',
                          hintText: 'e.g., 125.50',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        validator: (v) => v == null || v.isEmpty ? 'Please enter an amount.' : null,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Enter the total amount of the environmental fee.',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
              // Payment Method
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Payment Method', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: _selectedMethod,
                        items: _methods
                            .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                            .toList(),
                        onChanged: (val) => setState(() => _selectedMethod = val),
                        decoration: InputDecoration(
                          hintText: 'Select payment method',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        validator: (v) => v == null || v.isEmpty ? 'Please select a method.' : null,
                      ),
                    ],
                  ),
                ),
              ),
              // Status
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Status', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: _selectedStatus,
                        items: _statuses
                            .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                            .toList(),
                        onChanged: (val) => setState(() => _selectedStatus = val),
                        decoration: InputDecoration(
                          hintText: 'Select status',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        validator: (v) => v == null || v.isEmpty ? 'Please select a status.' : null,
                      ),
                    ],
                  ),
                ),
              ),
              // Category
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Category', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: _selectedCategory,
                        items: _categories
                            .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                            .toList(),
                        onChanged: (val) => setState(() => _selectedCategory = val),
                        decoration: InputDecoration(
                          hintText: 'Select a category',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        validator: (v) => v == null || v.isEmpty ? 'Please select a category.' : null,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Choose the category that best describes this fee.',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
              // Description
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Description', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _descriptionController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: 'e.g., Q3 2023 carbon emissions charge for factory operations.',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Add any relevant notes or details about the fee.',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Review all details before confirming your environmental fee entry.',
                style: TextStyle(fontSize: 13, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _submit,
                icon: const Icon(Icons.check_circle, color: Colors.white),
                label: const Text('Submit Fee Entry'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4856C9),
                  minimumSize: const Size.fromHeight(44),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  textStyle: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: _reset,
                child: const Text('Reset Form'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(44),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}