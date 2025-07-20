import 'package:flutter/material.dart';
import 'package:lobo_tourism_management/othersettingspage.dart';
import 'dashboard_page.dart' as dashboard;
import 'visitortracking.dart';
import 'ResortManagementPage.dart' as resort_mgmt;
import 'EnvironmentalFeesPage.dart';
import 'ItinerariesPage.dart';
import 'AnalyticsPage.dart';
import 'settingspage.dart';
import 'AddResortPage.dart' as add_resort;
import 'PendingResortPage.dart';
import 'EditResortPage.dart';
import 'addentrypage.dart';
import 'additinerarypage.dart' as add_itinerary;
import 'changepasswordpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

class ThemeController {
  static final ThemeController _instance = ThemeController._internal();
  final ValueNotifier<bool> isDarkMode = ValueNotifier<bool>(false);

  factory ThemeController() => _instance;

  ThemeController._internal();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const LoboTourismApp());
}

class LoboTourismApp extends StatelessWidget {
  const LoboTourismApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: ThemeController().isDarkMode,
      builder: (context, isDark, _) {
        return MaterialApp(
          title: 'Lobo Tourism Management',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: isDark ? Brightness.dark : Brightness.light,
            primarySwatch: Colors.teal,
            scaffoldBackgroundColor: isDark ? Colors.grey[900] : const Color(0xFFF6FBFA),
            cardColor: isDark ? Colors.grey[850] : Colors.white,
            appBarTheme: AppBarTheme(
              backgroundColor: isDark ? Colors.teal.shade900 : Colors.teal.shade800,
              foregroundColor: Colors.white,
            ),
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
            useMaterial3: true,
            inputDecorationTheme: const InputDecorationTheme(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              filled: true,
              fillColor: Color(0xFFF7F9FA),
              labelStyle: TextStyle(color: Colors.teal, fontSize: 13),
              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
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
                foregroundColor: Colors.teal,
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
            '/login': (context) => const LoginPage(),
            '/dashboard': (context) => const dashboard.DashboardPage(),
            '/visitortracking': (context) => VisitorsTrackingPage(),
            '/resortmanagement': (context) => resort_mgmt.ResortManagementPage(),
            '/environmentalfees': (context) => EnvironmentalFeesPage(),
            '/itineraries': (context) => ItinerariesPage(),
            '/analytics': (context) => AnalyticsPage(),
            '/settings': (context) => const SettingsPage(),
            '/addresort': (context) => add_resort.AddResortPage(),
            '/pendingresorts': (context) => const PendingResortPage(pendingResorts: [],),
            '/editresort': (context) => const EditResortPage(resort: {}),
            '/addentry': (context) => const AddEntryPage(),
            '/additinerary': (context) => const add_itinerary.AddItineraryPage(),
            '/changepassword': (context) => const ChangePasswordPage(),
            '/othersettings': (context) => const OtherSettingsPage(),
          },
        );
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

  Widget _buildSocialButton(String text, IconData icon, Color color, Color textColor) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 20, color: color),
      label: Text(text, style: TextStyle(color: textColor, fontWeight: FontWeight.w600, fontSize: 14)),
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(40),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        side: BorderSide(color: color, width: 1.2),
        foregroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
    );
  }

  void _handleSignIn() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (isSignIn) {
        // Sign in logic
        try {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );
          Navigator.pushReplacementNamed(context, '/dashboard');
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Sign in failed: $e')),
          );
        }
      } else {
        // Sign up logic
        try {
          UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );
          // Save user info to Firestore
          await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
            'email': _emailController.text.trim(),
            'createdAt': FieldValue.serverTimestamp(),
          });
          Navigator.pushReplacementNamed(context, '/dashboard');
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Sign up failed: $e')),
          );
        }
      }
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
                padding: const EdgeInsets.all(24),
                margin: const EdgeInsets.symmetric(horizontal: 16),
                width: 370,
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha((0.98 * 255).toInt()),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.teal.withAlpha((0.10 * 255).toInt()),
                      blurRadius: 24,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Logo or Illustration
                      CircleAvatar(
                        radius: 36,
                        backgroundColor: Colors.teal.shade100,
                        child: Icon(Icons.travel_explore, color: Colors.teal.shade700, size: 38),
                      ),
                      const SizedBox(height: 18),
                      Text(
                        isSignIn ? "Welcome Back!" : "Create Account",
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                          color: Colors.teal,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        isSignIn
                            ? "Sign in to your Tourism Admin Dashboard"
                            : "Sign up to manage and explore Lobo Tourism.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 18),
                      // Toggle
                      Container(
                        margin: const EdgeInsets.only(top: 18, bottom: 18),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF7F7F7),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  setState(() => isSignIn = true);
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: isSignIn ? Colors.teal : Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                ),
                                child: Text(
                                  "Sign In",
                                  style: TextStyle(
                                    color: isSignIn ? Colors.white : Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  setState(() => isSignIn = false);
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: !isSignIn ? Colors.teal : Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                ),
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    color: !isSignIn ? Colors.white : Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          hintText: 'admin@example.com',
                          prefixIcon: Icon(Icons.email_outlined, size: 20),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(fontSize: 14),
                        validator: _validateEmail,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.lock_outline, size: 20),
                          suffixIcon: IconButton(
                            icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                        style: const TextStyle(fontSize: 14),
                        validator: _validatePassword,
                      ),
                      if (!isSignIn) ...[
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: _obscureConfirmPassword,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            prefixIcon: const Icon(Icons.lock_outline, size: 20),
                            suffixIcon: IconButton(
                              icon: Icon(_obscureConfirmPassword ? Icons.visibility_off : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  _obscureConfirmPassword = !_obscureConfirmPassword;
                                });
                              },
                            ),
                          ),
                          style: const TextStyle(fontSize: 14),
                          validator: _validateConfirmPassword,
                        ),
                      ],
                      const SizedBox(height: 8),
                      if (isSignIn)
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text("Forgot password?", style: TextStyle(fontSize: 12)),
                          ),
                        ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: _handleSignIn,
                          icon: Icon(isSignIn ? Icons.login : Icons.person_add_alt_1, size: 20),
                          label: Text(isSignIn ? "Sign In" : "Sign Up", style: const TextStyle(fontSize: 15)),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      Row(
                        children: [
                          Expanded(child: Divider(color: Colors.grey.shade400, thickness: 1)),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text("OR", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                          ),
                          Expanded(child: Divider(color: Colors.grey.shade400, thickness: 1)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildSocialButton(
                        "Continue with Google",
                        Icons.g_mobiledata,
                        const Color(0xFFEA4335),
                        Colors.black,
                      ),

                      const SizedBox(height: 8),
                      _buildSocialButton(
                        "Continue with Apple",
                        Icons.apple,
                        Colors.black,
                        Colors.black,
                      ),
                      const SizedBox(height: 16),
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
                        style: TextStyle(fontSize: 11),
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