import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AnalyticsPieChart extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  const AnalyticsPieChart({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    // Filter out data with zero values
    final validData = data.where((item) => item['value'] > 0).toList();
    
    if (validData.isEmpty) {
      return Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.pie_chart,
                size: 48,
                color: Theme.of(context).hintColor.withValues(alpha: 0.5),
              ),
              const SizedBox(height: 16),
              Text(
                'No data available',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).hintColor,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Pie Chart - Smaller size
          SizedBox(
            height: 120,
            child: PieChart(
              PieChartData(
                sectionsSpace: 1,
                centerSpaceRadius: 25,
                sections: validData.map((item) {
                  final total = validData.fold<double>(0, (sum, d) => sum + d['value']);
                  final percentage = (item['value'] / total) * 100;
                  
                  return PieChartSectionData(
                    color: item['color'],
                    value: item['value'],
                    title: '${percentage.toStringAsFixed(0)}%',
                    radius: 45,
                    titleStyle: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 8),
          
          // Compact Legend
          Wrap(
            spacing: 6,
            runSpacing: 4,
            children: validData.map((item) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: item['color'],
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${item['label']}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).hintColor,
                      fontSize: 10,
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
} 