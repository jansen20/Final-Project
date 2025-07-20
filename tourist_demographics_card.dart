import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TouristDemographicsCard extends StatelessWidget {
  final List<Map<String, dynamic>> _demographics = const [
    {'label': 'Male', 'value': 54, 'color': Colors.blue},
    {'label': 'Female', 'value': 46, 'color': Colors.pink},
  ];

  const TouristDemographicsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Tourist Demographics",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 120,
              child: Row(
                children: [
                  Expanded(
                    child: PieChart(
                      PieChartData(
                        sections: _demographics
                            .map((d) => PieChartSectionData(
                                  color: d['color'],
                                  value: (d['value'] as int).toDouble(),
                                  title: '${d['value']}%',
                                  radius: 40,
                                  titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                                ))
                            .toList(),
                        sectionsSpace: 2,
                        centerSpaceRadius: 24,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _demographics
                        .map((d) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                              child: Row(
                                children: [
                                  Container(width: 16, height: 16, color: d['color'], margin: const EdgeInsets.only(right: 8)),
                                  Text('${d['label']} (${d['value']}%)', style: const TextStyle(fontSize: 13)),
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
