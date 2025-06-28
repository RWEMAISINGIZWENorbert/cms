// ignore_for_file: deprecated_member_use, avoid_print

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_associate/bloc/compliant/compliant_bloc.dart';
import 'package:tech_associate/bloc/compliant/compliant_state.dart';
import 'package:tech_associate/data/graphs/bar_data.dart';

class MyBarGraph extends StatelessWidget {
  const MyBarGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompliantBloc, CompliantState>(
      builder: (context, state) {
        if (state is CompliantLoaded) {
          final compliants = state.compliants;          
          // Debug prints
          print('Total complaints: ${compliants.length}');
          
          // Check if there's any data for the current week
          final now = DateTime.now();
          // Get the start of the current week (Sunday)
          final startOfWeek = DateTime(now.year, now.month, now.day - now.weekday);
          print('Start of week: $startOfWeek');
          print('Current time: $now');
          
          final hasData = compliants.any((c) {
            final complaintDate = DateTime(c.createdAt.year, c.createdAt.month, c.createdAt.day);
            final isInCurrentWeek = complaintDate.isAfter(startOfWeek) || complaintDate.isAtSameMomentAs(startOfWeek);
            print('Complaint created at: ${c.createdAt}, isInCurrentWeek: $isInCurrentWeek');
            return isInCurrentWeek;
          });
          
          print('Has data for current week: $hasData');

          if (!hasData) {
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
                      Icons.bar_chart,
                      size: 48,
                      color: Theme.of(context).hintColor.withValues(alpha: 0.5),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No data available for this week',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          BarData myBarData = BarData.fromCompliants(compliants);
          myBarData.initBarData();
          
          // Debug prints for bar data
          print('Bar data points:');
          for (var point in myBarData.barData) {
            print('x: ${point.x}, y: ${point.y}');
          }

          final maxY = myBarData.barData.map((e) => e.y).reduce((a, b) => a > b ? a : b) + 5;
          print('Max Y value: $maxY');

          return BarChart(
            BarChartData(
              maxY: maxY,
              minY: 0,
              borderData: FlBorderData(show: false),
              gridData: const FlGridData(show: false),
              titlesData: FlTitlesData(
                show: true,
                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) => getBottomTiles(value, meta, context),
                  ),
                )
              ),
              barGroups: myBarData.barData.map(
                (data) => BarChartGroupData(
                  x: data.x,
                  barRods: [
                    BarChartRodData(
                      toY: data.y,
                      color: Theme.of(context).primaryColor.withOpacity(0.8),
                      width: 22,
                      borderRadius: BorderRadius.circular(5)
                    )
                  ]
                )
              ).toList(),
            ),
          );
        }else if (state is CompliantLoading){
           return const Center(child: CircularProgressIndicator());
        }else if(state is CompliantsEmpty){
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
                 crossAxisAlignment: CrossAxisAlignment.center,
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Icon(
                     Icons.inbox_outlined,
                     size: 48,
                     color: Theme.of(context).hintColor.withValues(alpha: 0.5),
                   ),
                   const SizedBox(height: 16),
                   Text(
                     'No complaints data available',
                     style: Theme.of(context).textTheme.displayMedium?.copyWith(
                       color: Theme.of(context).hintColor,
                     ),
                   ),
                 ],
               ),
             ),
           );
        }
        
        // Show loading state
        return  Center(
          child: Text("$state"),
        );
      },
    );
  }
}

Widget getBottomTiles(double value, TitleMeta meta, BuildContext context) {
  final style = TextStyle(
    color: Theme.of(context).hintColor,
    fontWeight: FontWeight.bold,
  );

  Widget text;
  switch(value.toInt()) {
    case 0: 
      text = Text('Sun', style: style);
      break;
    case 1: 
      text = Text('Mon', style: style);
      break;
    case 2: 
      text = Text('Tue', style: style);
      break;
    case 3: 
      text = Text('Wed', style: style);
      break;
    case 4: 
      text = Text('Thu', style: style);
      break;
    case 5: 
      text = Text('Fri', style: style);
      break;
    case 6: 
      text = Text('Sat', style: style);
      break;
    default: 
      text = const Text('');
      break;
  }

  return SideTitleWidget(
    meta: meta,
    child: text,
  );
}