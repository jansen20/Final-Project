import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() => runApp(DashboardApp());

class DashboardApp extends StatelessWidget {
  const DashboardApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resort Analytics Dashboard',
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: Colors.teal,
          secondary: Colors.teal.shade200,
          surface: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.white,
        cardColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.teal),
          titleTextStyle: TextStyle(
            color: Colors.teal,
            fontWeight: FontWeight.bold,
            fontSize: 22,
            fontFamily: 'Segoe UI',
            letterSpacing: 1.2,
          ),
        ),
        useMaterial3: true,
      ),
      home: const AnalyticsDashboardScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AnalyticsDashboardScreen extends StatelessWidget {
  const AnalyticsDashboardScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWide = size.width >= 700;
    final isPhone = size.width < 500;

    Widget sidebar = Drawer(
      child: Container(
        color: Colors.teal,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.teal.shade700),
              child: Center(
                child: Text(
                  'RESORT MENU',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.dashboard, color: Colors.white),
              title: Text('Dashboard', style: TextStyle(color: Colors.white)),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.analytics, color: Colors.white),
              title: Text('Analytics', style: TextStyle(color: Colors.white)),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.white),
              title: Text('Settings', style: TextStyle(color: Colors.white)),
              onTap: () {},
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        iconTheme: IconThemeData(color: Colors.teal),
        title: const Text("Analytics Dashboard"),
        titleTextStyle: TextStyle(
          color: Colors.teal,
          fontWeight: FontWeight.bold,
          fontSize: isPhone ? 20 : 26,
          fontFamily: 'Segoe UI',
          letterSpacing: 1.2,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.file_download),
            color: Colors.teal,
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text("Export"),
                  content: const Text("Exporting analytics data..."),
                  actions: [
                    TextButton(
                      child: const Text("OK"),
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                ),
              );
            },
            tooltip: "Export Data",
          ),
        ],
      ),
      drawer: isWide ? sidebar : null,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(isPhone ? 6 : 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: isPhone ? 8 : 16),
              _buildSummaryCards(isWide, isPhone),
              SizedBox(height: isPhone ? 8 : 16),
              _buildMainCharts(isWide, isPhone),
              SizedBox(height: isPhone ? 8 : 16),
              _buildLowerSections(isWide, isPhone),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCards(bool isWide, bool isPhone) {
    final cards = [
      _statCard("Total Bookings", "4,567", "+12%", Icons.beach_access, Color(0xFF0ED2F7), isPhone),
      _statCard("Total Revenue", "₱345,678", "+15%", Icons.emoji_events, Color(0xFFFFB347), isPhone),
      _statCard("Daily Rate", "₱180", "-3%", Icons.hotel, Color(0xFF43E97B), isPhone),
      _statCard("Satisfaction", "4.7/5", "84% of 8K reviews", Icons.sunny, Color(0xFFFF6E7F), isPhone),
    ];

    return isWide && !isPhone
        ? Row(
            children: cards
                .map((c) => Expanded(child: Padding(padding: const EdgeInsets.all(8), child: c)))
                .toList(),
          )
        : Column(
            children: cards
                .map((c) => Padding(padding: EdgeInsets.symmetric(vertical: isPhone ? 4 : 8), child: c))
                .toList(),
          );
  }

  Widget _statCard(String title, String value, String subtitle, IconData icon, Color color, bool isPhone) {
    return Card(
      elevation: 6,
      shadowColor: Colors.teal.withValues(alpha: 0.18),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(isPhone ? 12 : 18)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(isPhone ? 12 : 18),
          color: Colors.white,
          border: Border.all(color: Colors.teal.withValues(alpha: 0.10)),
        ),
        padding: EdgeInsets.all(isPhone ? 10 : 18),
        child: Row(children: [
          CircleAvatar(
            backgroundColor: Colors.teal.withValues(alpha: 0.18),
            child: Icon(icon, color: Colors.teal, size: isPhone ? 22 : 32),
            radius: isPhone ? 18 : 28,
          ),
          SizedBox(width: isPhone ? 8 : 16),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: isPhone ? 12 : 16, fontFamily: 'Segoe UI', color: Colors.teal)),
              Text(value, style: TextStyle(fontSize: isPhone ? 18 : 26, fontWeight: FontWeight.w700, fontFamily: 'Segoe UI', color: Colors.black)),
              Text(subtitle, style: TextStyle(color: Colors.teal.shade300, fontSize: isPhone ? 10 : 13, fontFamily: 'Segoe UI')),
            ]),
          )
        ]),
      ),
    );
  }

  Widget _buildMainCharts(bool isWide, bool isPhone) {
    final chart1 = _lineChartCard("Visitor Trends Over Time", isPhone);
    final chart2 = _pieChartCard("Occupancy Breakdown", isPhone);

    return isWide && !isPhone
        ? Row(children: [Expanded(child: chart1), const SizedBox(width: 16), Expanded(child: chart2)])
        : Column(children: [chart1, const SizedBox(height: 15), chart2]);
  }

  Widget _lineChartCard(String title, bool isPhone) {
    return Card(
      elevation: 4,
      shadowColor: Colors.teal.withValues(alpha: 0.18),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(isPhone ? 10 : 16)),
      child: Padding(
        padding: EdgeInsets.all(isPhone ? 10 : 18),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: isPhone ? 14 : 18, fontFamily: 'Segoe UI', color: Colors.teal)),
          const SizedBox(height: 8),
          SizedBox(height: isPhone ? 140 : 220, child: LineChartWidget(isPhone: isPhone)),
          const SizedBox(height: 8),
          // Legend
          Row(
            children: [
              Container(width: 18, height: 8, color: Colors.teal),
              const SizedBox(width: 6),
              Text("Visitors", style: TextStyle(fontSize: isPhone ? 11 : 13, color: Colors.teal)),
              const Spacer(),
              // Latest value indicator
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.teal.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text("Jun: 680", style: TextStyle(fontWeight: FontWeight.bold, fontSize: isPhone ? 11 : 13, color: Colors.teal)),
              ),
            ],
          ),
        ]),
      ),
    );
  }

  Widget _pieChartCard(String title, bool isPhone) {
    return Card(
      elevation: 4,
      shadowColor: Colors.teal.withValues(alpha: 0.18),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(isPhone ? 10 : 16),
      ),
      child: Padding(
        padding: EdgeInsets.all(isPhone ? 10 : 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: isPhone ? 14 : 18,
                fontFamily: 'Segoe UI',
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: SizedBox(
                height: isPhone ? 140 : 220,
                child: PieChartWidget(isPhone: isPhone),
              ),
            ),
            const SizedBox(height: 10),
            const Divider(height: 1, color: Colors.teal),
            const SizedBox(height: 8),
            Center(
              child: Wrap(
                spacing: isPhone ? 10 : 16,
                runSpacing: 6,
                alignment: WrapAlignment.center,
                children: [
                  _pieLegendDot("Deluxe", Colors.teal, "45%", isPhone),
                  _pieLegendDot("Suite", Color(0xFFFFB347), "28%", isPhone),
                  _pieLegendDot("Standard", Color(0xFF43E97B), "17%", isPhone),
                  _pieLegendDot("Others", Colors.grey, "10%", isPhone),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _pieLegendDot(String label, Color color, String value, bool isPhone) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: isPhone ? 10 : 14,
          height: isPhone ? 10 : 14,
          margin: const EdgeInsets.only(right: 6),
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        Text(
          "$label ",
          style: TextStyle(
            fontSize: isPhone ? 11 : 14,
            color: Colors.black,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isPhone ? 11 : 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildLowerSections(bool isWide, bool isPhone) {
    final section1 = _placeholderCard("Revenue Breakdown", isPhone);
    final section2 = _placeholderCard("Guest Demographics", isPhone);
    final section4 = _placeholderCard("Booking Channel Performance", isPhone);

    return isWide && !isPhone
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: section1),
              const SizedBox(width: 16),
              Expanded(child: section2),
              const SizedBox(width: 16),
              Expanded(child: section4),
            ],
          )
        : Column(children: [
            section1,
            SizedBox(height: isPhone ? 8 : 16),
            section2,
            SizedBox(height: isPhone ? 8 : 16),
            section4,
          ]);
  }

  Widget _placeholderCard(String title, bool isPhone) {
    // Choose an icon and chart based on the title
    IconData icon;
    Color iconColor;
    Widget? chartWidget;
    if (title.contains('Revenue')) {
      icon = Icons.attach_money;
      iconColor = Colors.teal;
      chartWidget = MiniRevenueBarChart(isPhone: isPhone);
    } else if (title.contains('Demographics')) {
      icon = Icons.people;
      iconColor = Color(0xFFFFB347);
      chartWidget = MiniDemographicsBarChart(isPhone: isPhone);
    } else if (title.contains('Booking')) {
      icon = Icons.map;
      iconColor = Colors.teal;
      chartWidget = MiniBookingChannelBarChart(isPhone: isPhone);
    } else {
      icon = Icons.beach_access;
      iconColor = Color(0xFFFF6E7F);
      chartWidget = null;
    }
    return SizedBox(
      height: isPhone ? 250 : 180,
      child: Card(
        elevation: 9,
        shadowColor: iconColor.withValues(alpha: 0.18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(isPhone ? 12 : 22)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(isPhone ? 12 : 22),
            color: Colors.white,
            border: Border.all(color: iconColor.withValues(alpha: 0.10)),
          ),
          child: Stack(
            children: [
              // Faded tourism icon in the background
              if (!isPhone)
                Positioned(
                  right: 12,
                  bottom: 8,
                  child: Opacity(
                    opacity: 0.13,
                    child: Icon(
                      icon,
                      size: 100,
                      color: iconColor,
                    ),
                  ),
                ),
              Padding(
                padding: EdgeInsets.all(isPhone ? 10 : 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: isPhone ? 13 : 16,
                        fontFamily: 'Segoe UI',
                        color: iconColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Center(
                        child: chartWidget ?? Text(
                          "Chart Placeholder",
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: isPhone ? 13 : 10,
                            fontFamily: 'Segoe UI',
                            fontStyle: FontStyle.italic,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------- Charts ---------------- //

class LineChartWidget extends StatelessWidget {
  final bool isPhone;
  const LineChartWidget({super.key, required this.isPhone});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final double chartHeight = (width * 0.35).clamp(120, 260);
    final double dotRadius = (width * 0.012).clamp(4, 10);
    final double barWidth = (width * 0.012).clamp(3, 7);
    final double axisFont = (width * 0.025).clamp(9, 16);
    return SizedBox(
      height: chartHeight,
      child: LineChart(
        LineChartData(
          backgroundColor: const Color(0xFFF0F9FF),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            getDrawingHorizontalLine: (value) => FlLine(
              color: Colors.teal.withValues(alpha: 0.08),
              strokeWidth: 1,
            ),
            getDrawingVerticalLine: (value) => FlLine(
              color: Colors.teal.withValues(alpha: 0.08),
              strokeWidth: 1,
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: Colors.teal.withValues(alpha: 0.2), width: 2),
          ),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true, reservedSize: 40, getTitlesWidget: (value, meta) => Text(value.toInt().toString(), style: TextStyle(fontSize: axisFont))),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 32,
                getTitlesWidget: (value, meta) {
                  const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
                  if (value >= 1 && value <= 6) {
                    return Text(months[value.toInt() - 1], style: TextStyle(fontSize: axisFont, fontWeight: FontWeight.bold));
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
          minX: 1,
          maxX: 6,
          minY: 200,
          maxY: 700,
          lineBarsData: [
            LineChartBarData(
              isCurved: true,
              gradient: LinearGradient(
                colors: [Color(0xFF0ED2F7), Color(0xFF43E97B)],
              ),
              barWidth: barWidth,
              spots: [
                FlSpot(1, 320), // Jan
                FlSpot(2, 400), // Feb
                FlSpot(3, 370), // Mar
                FlSpot(4, 600), // Apr
                FlSpot(5, 540), // May
                FlSpot(6, 680), // Jun
              ],
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, bar, index) => FlDotCirclePainter(
                  radius: dotRadius,
                  color: Colors.white,
                  strokeColor: Colors.teal,
                  strokeWidth: 3,
                ),
              ),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [Color(0xFF0ED2F7).withValues(alpha: 0.3), Color(0xFF43E97B).withValues(alpha: 0.05)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              showingIndicators: [0, 1, 2, 3, 4, 5],
            ),
          ],
          showingTooltipIndicators: [
            ShowingTooltipIndicators([
              LineBarSpot(
                LineChartBarData(
                  isCurved: true,
                  spots: [
                    FlSpot(1, 320),
                    FlSpot(2, 400),
                    FlSpot(3, 370),
                    FlSpot(4, 600),
                    FlSpot(5, 540),
                    FlSpot(6, 680),
                  ],
                ),
                0,
                FlSpot(1, 320),
              ),
            ]),
          ],
          lineTouchData: LineTouchData(
            enabled: true,
            touchTooltipData: LineTouchTooltipData(
              tooltipBgColor: Colors.teal.withValues(alpha: 0.8),
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map((spot) {
                  return LineTooltipItem(
                    '${spot.y.toInt()} visitors',
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: axisFont),
                  );
                }).toList();
              },
            ),
          ),
        ),
      ),
    );
  }
}

class PieChartWidget extends StatelessWidget {
  final bool isPhone;
  const PieChartWidget({super.key, required this.isPhone});

  @override
  Widget build(BuildContext context) {
    // Even smaller sizes for phone
    final double chartHeight = isPhone ? 70 : 220;
    final double centerSpace = isPhone ? 18 : 48;
    final double baseRadius = isPhone ? 18 : 54;
    final double bigRadius = isPhone ? 22 : 62;
    final double labelFont = isPhone ? 6 : 8;
    
    return SizedBox(
      height: chartHeight,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              sections: [
                PieChartSectionData(
                  value: 45,
                  title: isPhone ? '' : 'Deluxe\n45%',
                  color: Color(0xFF0ED2F7),
                  radius: bigRadius,
                  titleStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: labelFont, color: const Color.fromARGB(255, 0, 0, 0), fontFamily: 'Segoe UI')
                ),
                PieChartSectionData(
                  value: 28,
                  title: isPhone ? '' : 'Suite\n28%',
                  color: Color(0xFFFFB347),
                  radius: baseRadius,
                  titleStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: labelFont, color: const Color.fromARGB(255, 0, 0, 0), fontFamily: 'Segoe UI'),
                ),
                PieChartSectionData(
                  value: 17,
                  title: isPhone ? '' : 'Standard\n17%',
                  color: Color(0xFF43E97B),
                  radius: baseRadius - (isPhone ? 4 : 6),
                  titleStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: labelFont, color: const Color.fromARGB(255, 0, 0, 0), fontFamily: 'Segoe UI'),
                ),
                PieChartSectionData(
                  value: 10,
                  title: isPhone ? '' : 'Others\n10%',
                  color: Colors.grey,
                  radius: baseRadius - (isPhone ? 8 : 10),
                  titleStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: labelFont, color: const Color.fromARGB(255, 5, 5, 5), fontFamily: 'Segoe UI'),
                ),
              ],
              sectionsSpace: isPhone ? 2 : 4,
              centerSpaceRadius: centerSpace,
            ),
          ),
          Center(
            child: Icon(Icons.beach_access, color: Color(0xFF0ED2F7), size: isPhone ? 12 : 40),
          ),
        ],
      ),
    );
  }
}

// --- Mini Dummy Charts for Placeholders ---

class MiniRevenueBarChart extends StatelessWidget {
  final bool isPhone;
  const MiniRevenueBarChart({super.key, required this.isPhone});
  
  @override
  Widget build(BuildContext context) {
    final months = ['January', 'February', 'March', 'April', 'May', 'June'];
    final values = [12000, 16000, 30000, 25000, 18000, 10000];
    final maxVal = 40000;
    final double chartHeight = isPhone ? 90 : 110;
    final double barMaxHeight = isPhone ? 32 : 60;
    final double barWidth = isPhone ? 8 : 18;
    final double valueFont = isPhone ? 9 : 13;
    final double labelFont = isPhone ? 8 : 12;
    return SizedBox(
      height: chartHeight,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: isPhone ? 8 : 20, vertical: isPhone ? 8 : 10),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(months.length, (i) {
              final barHeight = barMaxHeight * (values[i] / maxVal);
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Value
                  Text(
                    values[i].toStringAsFixed(0),
                    style: TextStyle(
                      fontSize: valueFont,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromARGB(255, 2, 62, 5),
                    ),
                  ),
                  SizedBox(height: isPhone ? 1 : 2),
                  // Bar
                  Container(
                    width: barWidth,
                    height: barHeight,
                    decoration: BoxDecoration(
                      color: Colors.greenAccent.shade400,
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.greenAccent.withValues(alpha: 0.2),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: isPhone ? 2 : 4),
                  // Month label
                  Text(
                    months[i],
                    style: TextStyle(
                      fontSize: labelFont,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}

class MiniDemographicsBarChart extends StatelessWidget {
  final bool isPhone;
  const MiniDemographicsBarChart({super.key, required this.isPhone});

  @override
  Widget build(BuildContext context) {
    final data = [
      {'label': '18-25', 'value': 40.0, 'color': const Color(0xFF0ED2F7)},
      {'label': '26-35', 'value': 30.0, 'color': const Color(0xFFFFB347)},
      {'label': '36-50', 'value': 20.0, 'color': const Color(0xFF43E97B)},
      {'label': '51+',   'value': 10.0, 'color': Colors.grey},
    ];

    final maxVal = data.map((d) => d['value'] as double).reduce((a, b) => a > b ? a : b);

    // Responsive settings
    final double chartHeight = isPhone ? 120 : 140;
    final double barMaxHeight = isPhone ? 50 : 70;
    final double barWidth = isPhone ? 14 : 22;
    final double valueFont = isPhone ? 11 : 14;
    final double labelFont = isPhone ? 10 : 13;

    return SizedBox(
      height: chartHeight + 40,
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(
            height: chartHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(data.length, (i) {
                final barHeight = barMaxHeight * (data[i]['value'] as double) / maxVal;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '${(data[i]['value'] as double).toStringAsFixed(0)}%',
                      style: TextStyle(
                        fontSize: valueFont,
                        fontWeight: FontWeight.bold,
                        color: data[i]['color'] as Color,
                      ),
                    ),
                    SizedBox(height: 4),
                    Container(
                      width: barWidth,
                      height: barHeight,
                      decoration: BoxDecoration(
                        color: data[i]['color'] as Color,
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: [
                          BoxShadow(
                            color: (data[i]['color'] as Color).withValues(alpha: 0.2),
                            blurRadius: 4,
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      data[i]['label'] as String,
                      style: TextStyle(
                        fontSize: labelFont,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Age',
            style: TextStyle(
              fontSize: isPhone ? 13 : 15,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class MiniBookingChannelBarChart extends StatelessWidget {
  final bool isPhone;
  const MiniBookingChannelBarChart({super.key, required this.isPhone});

  @override
  Widget build(BuildContext context) {
    final channels = ["Walk-in", "Online"];
    final values = [45.0, 10.0];
    final colors = [Color(0xFF0ED2F7), Color(0xFFFFB347)];
    final maxVal = 60.0;
    final width = MediaQuery.of(context).size.width;
    
    // Responsive scaling with strict fit
    final double chartHeight = isPhone ? 120 : (width * 0.13).clamp(40, 100);
    double percentFont = isPhone ? 18 : (width * 0.018).clamp(7, 16);
    double labelFont = isPhone ? 14 : (width * 0.015).clamp(6, 14);
    final double barWidth = isPhone ? 18 : (width * 0.025).clamp(8, 22);
    final double spacingAbove = isPhone ? 2 : 4;
    final double spacingBelow = isPhone ? 4 : 8;
    
    // Calculate available bar height so everything fits
    double barMaxHeight = chartHeight - (percentFont + labelFont + spacingAbove + spacingBelow);
    
    // If barMaxHeight is too small, shrink fonts
    if (barMaxHeight < 20) {
      percentFont = percentFont * 0.8;
      labelFont = labelFont * 0.8;
      barMaxHeight = chartHeight - (percentFont + labelFont + spacingAbove + spacingBelow);
    }
    if (barMaxHeight < 10) {
      percentFont = percentFont * 0.7;
      labelFont = labelFont * 0.7;
      barMaxHeight = chartHeight - (percentFont + labelFont + spacingAbove + spacingBelow);
    }
    barMaxHeight = barMaxHeight.clamp(8, 80);
    
    return SizedBox(
      height: isPhone ? 150 : chartHeight + labelFont * 2,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: isPhone ? 8 : 12),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(channels.length, (i) {
              final barHeight = barMaxHeight * (values[i] / maxVal);
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${values[i].toStringAsFixed(0)}%',
                    style: TextStyle(
                      fontSize: percentFont,
                      fontWeight: FontWeight.bold,
                      color: colors[i],
                    ),
                  ),
                  SizedBox(height: spacingAbove),
                  Container(
                    width: barWidth,
                    height: barHeight,
                    decoration: BoxDecoration(
                      color: colors[i],
                      borderRadius: BorderRadius.circular(barWidth / 2.5),
                      boxShadow: [
                        BoxShadow(
                          color: colors[i].withValues(alpha: 0.18),
                          blurRadius: 4,
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: spacingBelow),
                  Text(
                    channels[i],
                    style: TextStyle(
                      fontSize: labelFont,
                      color: Colors.black54,
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}