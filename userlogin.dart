import 'package:flutter/material.dart';
import 'package:tourist_page/Visitlog.dart' hide HelpCenterScreen; // VisitLogScreen
import 'Itinerary.dart'; // ItineraryScreen
import 'helpcenter.dart' hide HelpCenterScreen; // Import HelpCenterScreen
import 'package:tourist_page/home.dart'; // Correct import for DashboardPage

void main() {
  runApp(const LoboTourismApp());
}

class LoboTourismApp extends StatelessWidget {
  const LoboTourismApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lobo Tourism Management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF00897B)),
        useMaterial3: true,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          filled: true,
          fillColor: Color(0xFFF7F9FA),
          labelStyle: TextStyle(color: Color(0xFF00897B), fontSize: 13),
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF00897B),
            foregroundColor: Colors.white,
            minimumSize: const Size.fromHeight(36),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Color(0xFF00897B),
            textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            minimumSize: Size(0, 0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/visitlog': (context) => VisitLogScreen(),
        '/itinerary': (context) => const ItineraryScreen(),
        '/helpcenter': (context) => const HelpCenterScreen(),
      },
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isSignIn = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Widget _buildSocialButton(String text, IconData icon, Color color) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 18, color: color),
      label: Text(text, style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 13)),
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(32),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        side: BorderSide(color: color, width: 1.2),
        foregroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
    );
  }

  void _handleSignIn() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }
String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) return 'Enter a valid email';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) return 'Confirm your password';
    if (value != _passwordController.text) return 'Passwords do not match';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withAlpha((0.92 * 255).toInt()),
                  Colors.teal.withAlpha((0.08 * 255).toInt()),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.symmetric(horizontal: 12),
                width: 340,
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha((0.98 * 255).toInt()),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.teal.withAlpha((0.10 * 255).toInt()),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.teal.shade100,
                        child: Icon(Icons.travel_explore, color: Colors.teal.shade700, size: 26),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        isSignIn ? "Welcome Back!" : "Create Account",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Colors.teal,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        isSignIn
                            ? "Enter your credentials to access the Tourism Admin Dashboard."
                            : "Sign up to manage and explore Lobo Tourism.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.teal.withAlpha((0.07 * 255).toInt()),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
child: TextButton(
                                onPressed: () {
                                  setState(() => isSignIn = true);
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: isSignIn ? Colors.teal : Colors.transparent,
                                  foregroundColor: isSignIn ? Colors.white : Colors.teal,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      bottomLeft: Radius.circular(8),
                                    ),
                                  ),
                                ),
                                child: const Text("Sign In", style: TextStyle(fontSize: 13)),
                              ),
                            ),
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  setState(() => isSignIn = false);
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: !isSignIn ? Colors.teal : Colors.transparent,
                                  foregroundColor: !isSignIn ? Colors.white : Colors.teal,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(8),
                                      bottomRight: Radius.circular(8),
                                    ),
                                  ),
                                ),
                                child: const Text("Sign Up", style: TextStyle(fontSize: 13)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          hintText: 'admin@example.com',
                          prefixIcon: Icon(Icons.email_outlined, size: 18),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(fontSize: 13),
                        validator: _validateEmail,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.lock_outline, size: 18),
                          suffixIcon: IconButton(
                            icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                        style: const TextStyle(fontSize: 13),
                        validator: _validatePassword,
                      ),
                      if (!isSignIn) ...[
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: _obscureConfirmPassword,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
prefixIcon: const Icon(Icons.lock_outline, size: 18),
                            suffixIcon: IconButton(
                              icon: Icon(_obscureConfirmPassword ? Icons.visibility_off : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  _obscureConfirmPassword = !_obscureConfirmPassword;
                                });
                              },
                            ),
                          ),
                          style: const TextStyle(fontSize: 13),
                          validator: _validateConfirmPassword,
                        ),
                      ],
                      const SizedBox(height: 6),
                      if (isSignIn)
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text("Forgot password?", style: TextStyle(fontSize: 11)),
                          ),
                        ),
                      const SizedBox(height: 8),
                      ElevatedButton.icon(
                        onPressed: _handleSignIn,
                        icon: Icon(isSignIn ? Icons.login : Icons.person_add_alt_1, size: 18),
                        label: Text(isSignIn ? "Sign In" : "Sign Up"),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(child: Divider(color: Colors.grey.shade400, thickness: 1)),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6.0),
                            child: Text("OR", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                          ),
                          Expanded(child: Divider(color: Colors.grey.shade400, thickness: 1)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _buildSocialButton("Continue with Google", Icons.g_mobiledata, const Color.fromARGB(255, 240, 162, 162)),
                      const SizedBox(height: 6),
                      _buildSocialButton("Continue with Facebook", Icons.facebook, const Color.fromARGB(255, 162, 194, 245)),
                      const SizedBox(height: 6),
                      _buildSocialButton("Continue with Apple", Icons.apple, const Color.fromARGB(255, 59, 58, 58)),
                      const SizedBox(height: 12),
                      const Text.rich(
                        TextSpan(
                          text: "By continuing, you agree to the updated and\n",
                          children: [
                            TextSpan(
                              text: "Terms of Service",
                              style: TextStyle(color: Colors.teal, decoration: TextDecoration.underline),
                            ),
                            TextSpan(text: "  "),
                            TextSpan(
                              text: "Privacy Policy",
                              style: TextStyle(color: Colors.teal, decoration: TextDecoration.underline),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 10),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFF008943),
            ),
            accountName: const Text('Welcome, Traveler!'),
            accountEmail: const Text('tourist@email.com'),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 38, color: Color(0xFF008943)),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('Visit Log'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/visitlog');
            },
          ),
          ListTile(
            leading: const Icon(Icons.map),
            title: const Text('Itinerary'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/itinerary');
            },
          ),
          ListTile(
            leading: const Icon(Icons.help_center),
            title: const Text('Help Center'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/helpcenter');
            },
          ),
          const Spacer(),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Log Out', style: TextStyle(color: Colors.red)),
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
            },
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}