// ignore_for_file: avoid_print

import 'package:tech_associate/data/models/compliant.dart';

class BarData {
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thurAmount;
  final double friAmount;
  final double satAmount;

  BarData({
    required this.sunAmount,
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thurAmount,
    required this.friAmount,
    required this.satAmount,
  });

  List<BarDataPoint> barData = [];

  void initBarData() {
    barData = [
      BarDataPoint(x: 0, y: sunAmount),
      BarDataPoint(x: 1, y: monAmount),
      BarDataPoint(x: 2, y: tueAmount),
      BarDataPoint(x: 3, y: wedAmount),
      BarDataPoint(x: 4, y: thurAmount),
      BarDataPoint(x: 5, y: friAmount),
      BarDataPoint(x: 6, y: satAmount),
    ];
  }

  static BarData fromCompliants(List<Compliant> compliants) {
    final now = DateTime.now();
    // Get the start of the current week (Sunday)
    final startOfWeek = DateTime(now.year, now.month, now.day - now.weekday);
    print('BarData - Start of week: $startOfWeek');
    
    // Initialize counts for each day
    final dailyCounts = List.filled(7, 0.0);
    
    for (var compliant in compliants) {
      final complaintDate = DateTime(compliant.createdAt.year, compliant.createdAt.month, compliant.createdAt.day);
      // Calculate the day index (0-6) based on the weekday
      final dayIndex = complaintDate.weekday % 7;
      print('BarData - Complaint date: $complaintDate, day index: $dayIndex');
      
      if (complaintDate.isAfter(startOfWeek) || complaintDate.isAtSameMomentAs(startOfWeek)) {
        dailyCounts[dayIndex]++;
        print('BarData - Incremented count for day $dayIndex: ${dailyCounts[dayIndex]}');
      }
    }

    print('BarData - Final daily counts: $dailyCounts');

    return BarData(
      sunAmount: dailyCounts[0],
      monAmount: dailyCounts[1],
      tueAmount: dailyCounts[2],
      wedAmount: dailyCounts[3],
      thurAmount: dailyCounts[4],
      friAmount: dailyCounts[5],
      satAmount: dailyCounts[6],
    );
  }
}

class BarDataPoint {
  final int x;
  final double y;

  BarDataPoint({required this.x, required this.y});
}