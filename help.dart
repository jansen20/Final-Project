import 'package:flutter/material.dart';

void main() {
  runApp(const HelpCenterApp());
}

class HelpCenterApp extends StatelessWidget {
  const HelpCenterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resort Manager - Help',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
      home: const HelpCenterScreen(),
    );
  }
}

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  final Map<int, String> faqAnswers = {
    0: "You can update amenities in the Resort Settings > Amenities tab.",
    1: "Visit the Analytics Dashboard under Reports > Visitor Trends.",
    2: "Go to Calendar > Block Dates to close availability.",
    3: "Navigate to Admin Panel > User Management.",
    4: "Use the 'Forgot Password' option or contact admin support.",
    5: "Yes! Multiple photos can be uploaded from the Media section.",
    6: "Head to Pricing > Seasonal Rates to configure offers.",
    7: "Check Safety > Guest Emergency Protocols under Handbook.",
    8: "Use the Feedback button in the footer to submit your thoughts.",
    9: "Export options are available in Analytics > Export Data.",
  };

  final List<IconData> faqIcons = [
    Icons.spa, // amenities
    Icons.show_chart, // analytics
    Icons.event_busy, // closed dates
    Icons.group, // staff
    Icons.lock, // login
    Icons.photo_library, // photos
    Icons.local_offer, // pricing
    Icons.phone_in_talk, // emergency
    Icons.feedback, // feedback
    Icons.file_download, // export
  ];

  // Add controllers for the dialog fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _issueController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _issueController.dispose();
    super.dispose();
  }

  void _showSubmitRequestDialog() {
    showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            bool isButtonEnabled =
                _emailController.text.trim().isNotEmpty && _issueController.text.trim().isNotEmpty;

            void _updateButtonState() {
              setState(() {});
            }

            // Attach listeners only once
            _emailController.removeListener(_updateButtonState);
            _issueController.removeListener(_updateButtonState);
            _emailController.addListener(_updateButtonState);
            _issueController.addListener(_updateButtonState);

            final mq = MediaQuery.of(context);
            final maxDialogWidth = mq.size.width < 400 ? mq.size.width * 0.95 : 400.0;
            final maxDialogHeight = mq.size.height * 0.8;

            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              title: const Text("Submit a Request"),
              content: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: maxDialogWidth,
                  maxHeight: maxDialogHeight,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(labelText: "Your Email"),
                      ),
                      TextField(
                        controller: _issueController,
                        decoration: const InputDecoration(labelText: "Describe your issue"),
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    _emailController.clear();
                    _issueController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: isButtonEnabled
                      ? () {
                          String email = _emailController.text.trim();
                          String issue = _issueController.text.trim();
                          _emailController.clear();
                          _issueController.clear();
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Request submitted!")),
                          );
                        }
                      : null,
                  child: const Text("Send"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _simulateCall() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("Call Support"),
        content: const Text("Please call us at +63 912 345 6789."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFe0f7fa), Color.fromARGB(255, 255, 255, 255), Color.fromARGB(255, 251, 255, 255)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth >= 800;

                if (isWide) {
                  // DESKTOP/TABLET LAYOUT (side by side)
                  return Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildIntroSection(),
                              const SizedBox(height: 16),
                              _buildFaqAccordion(),
                            ],
                          ),
                        ),
                      ),
                      const VerticalDivider(width: 1),
                      Expanded(flex: 2, child: _buildRightPanel()),
                    ],
                  );
                } else {
                  // MOBILE LAYOUT (stacked vertically)
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildIntroSection(),
                        const SizedBox(height: 16),
                        _buildFaqAccordion(),
                        const SizedBox(height: 16),
                        _buildRightPanel(),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIntroSection() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          colors: [Color(0xFF43cea2), Color(0xFF185a9d)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.teal.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Row(
        children: const [
          Icon(Icons.beach_access, color: Colors.white, size: 40),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Need help? We've got you.",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Pacifico'),
                ),
                SizedBox(height: 4),
                Text(
                  "Find answers to common questions and get support for managing your resort.",
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFaqAccordion() {
    final faqs = [
      "How do I update resort amenities and services?",
      "Where can I view detailed visitor analytics and trends?",
      "What if my resort will be closed on specific dates?",
      "How do I add or remove staff accounts from the system?",
      "What steps should I take if I am troubleshooting login issues?",
      "Can I upload more than one photo?",
      "How do I manage seasonal pricing and promotional offers?",
      "What are the emergency contact protocols for guests?",
      "How can I provide feedback on the dashboard experience?",
      "Is there a way to export visitor data for external analysis?",
    ];

    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ExpansionPanelList.radio(
          expandedHeaderPadding: const EdgeInsets.symmetric(vertical: 6),
          initialOpenPanelValue: 0,
          children: faqs
              .asMap()
              .entries
              .map((entry) => ExpansionPanelRadio(
                    value: entry.key,
                    headerBuilder: (context, isExpanded) => ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.teal[100],
                        child: Icon(faqIcons[entry.key], color: Colors.teal[800]),
                      ),
                      title: Text(
                        entry.value,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    body: Container(
                      decoration: BoxDecoration(
                        color: Colors.teal[50],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        faqAnswers[entry.key] ?? "Answer not found.",
                        style: const TextStyle(color: Colors.black87),
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildRightPanel() {
    final List<Map<String, dynamic>> infoCards = [
      {
        'title': 'Getting Started',
        'desc': 'Learn the basics of setting up your resort.',
        'color': Colors.green[100],
        'icon': Icons.flag,
      },
      {
        'title': 'Troubleshooting',
        'desc': 'Solutions for common issues and errors.',
        'color': Colors.blue[100],
        'icon': Icons.build,
      },
      {
        'title': 'Analytics & Reports',
        'desc': 'Understand visitor trends and performance.',
        'color': Colors.purple[100],
        'icon': Icons.bar_chart,
      },
      {
        'title': 'Resort Information',
        'desc': 'Manage your resort’s amenities and pricing.',
        'color': Colors.orange[100],
        'icon': Icons.info,
      },
    ];

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ...infoCards.map((card) => Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        (card['color'] as Color).withOpacity(0.8),
                        Colors.white,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.teal.withOpacity(0.07),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(18),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(card['icon'], color: Colors.teal[700]),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(card['title'],
                                style: const TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text(card['desc']),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
            const SizedBox(height: 16),
            Card(
              color: Colors.white,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: Color(0xFFb2ebf2), width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const Text("Still Need Help?",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    const SizedBox(height: 8),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 12,
                      runSpacing: 8,
                      children: [
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: _showSubmitRequestDialog,
                          icon: const Icon(Icons.send),
                          label: const Text("Submit a Request"),
                        ),
                        OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.teal),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: _simulateCall,
                          icon: const Icon(Icons.phone, color: Colors.teal),
                          label: const Text("Call Us", style: TextStyle(color: Colors.teal)),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

