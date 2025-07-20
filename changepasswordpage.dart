import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  String currentPassword = '';
  String newPassword = '';
  String confirmPassword = '';

  bool showCurrentPassword = false;
  bool showNewPassword = false;
  bool showConfirmPassword = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade800,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/settings');
          },
        ),
        title: const Text(
          'Change Password',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFF6FBFA),
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 500),
          padding: EdgeInsets.all(isMobile ? 12 : 32),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: isMobile ? 18 : 32, horizontal: isMobile ? 12 : 32),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Update Password",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      obscureText: !showCurrentPassword,
                      decoration: InputDecoration(
                        labelText: "Current Password",
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            showCurrentPassword ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              showCurrentPassword = !showCurrentPassword;
                            });
                          },
                        ),
                      ),
                      validator: (value) => value == null || value.isEmpty ? "Enter your current password" : null,
                      onSaved: (value) => currentPassword = value ?? "",
                    ),
                    const SizedBox(height: 18),
                    TextFormField(
                      obscureText: !showNewPassword,
                      decoration: InputDecoration(
                        labelText: "New Password",
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            showNewPassword ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              showNewPassword = !showNewPassword;
                            });
                          },
                        ),
                      ),
                      validator: (value) => value == null || value.isEmpty ? "Enter a new password" : null,
                      onSaved: (value) => newPassword = value ?? "",
                    ),
                    const SizedBox(height: 18),
                    TextFormField(
                      obscureText: !showConfirmPassword,
                      decoration: InputDecoration(
                        labelText: "Confirm New Password",
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            showConfirmPassword ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              showConfirmPassword = !showConfirmPassword;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Confirm your new password";
                        }
                        if (value != newPassword) {
                          return "Passwords do not match";
                        }
                        return null;
                      },
                      onSaved: (value) => confirmPassword = value ?? "",
                    ),
                    const SizedBox(height: 28),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal.shade800,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            _formKey.currentState?.save();
                            // Add your password change logic here
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Password updated!')),
                            );
                            Navigator.pushReplacementNamed(context, '/settings');
                          }
                        },
                        child: const Text("Save Changes", style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}