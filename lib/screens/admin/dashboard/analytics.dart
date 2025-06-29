import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:tech_associate/bloc/compliant/compliant_bloc.dart';
import 'package:tech_associate/bloc/compliant/compliant_state.dart';
import 'package:tech_associate/data/models/compliant.dart';
import 'package:tech_associate/widgets/app_bar.dart';
import 'package:tech_associate/widgets/graphs/analytics_pie_chart.dart';
import 'package:tech_associate/widgets/graphs/analytics_bar_chart.dart';

class Analytics extends StatelessWidget {
  const Analytics({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const  AppBarComponent(
        title: 'Analytics',
        icon:  Icon(IconlyLight.arrow_left_circle),
      ),
      body: BlocBuilder<CompliantBloc, CompliantState>(
        builder: (context, state) {
          if (state is CompliantLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (state is CompliantLoaded) {
            final complaints = state.compliants;
            
            // Calculate metrics
            final totalComplaints = complaints.length;
            final resolvedComplaints = complaints.where((c) => c.status == CompliantStatus.resolved).length;
            final pendingComplaints = complaints.where((c) => c.status == CompliantStatus.open).length;
            final inProgressComplaints = complaints.where((c) => c.status == CompliantStatus.inProgress).length;
            final rejectedComplaints = complaints.where((c) => c.status == CompliantStatus.rejected).length;
            
            // Calculate priority distribution
            final highPriority = complaints.where((c) => c.priority == CompliantPriority.high).length;
            final mediumPriority = complaints.where((c) => c.priority == CompliantPriority.normal).length;
            final lowPriority = complaints.where((c) => c.priority == CompliantPriority.low).length;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Summary Cards
                  Row(
                    children: [
                      Expanded(
                        child: _buildMetricCard(
                          context,
                          title: 'Total',
                          value: totalComplaints.toString(),
                          icon: Icons.warning_amber_rounded,
                          color: Colors.orange,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildMetricCard(
                          context,
                          title: 'Resolved',
                          value: resolvedComplaints.toString(),
                          icon: Icons.check_circle_outline,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildMetricCard(
                          context,
                          title: 'Pending',
                          value: pendingComplaints.toString(),
                          icon: Icons.pending_actions,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildMetricCard(
                          context,
                          title: 'In Progress',
                          value: inProgressComplaints.toString(),
                          icon: Icons.engineering,
                          color: Colors.purple,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Status Distribution
                  Text(
                    'Status Distribution',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 200,
                    child: AnalyticsPieChart(
                      data: [
                        {'label': 'Resolved', 'value': resolvedComplaints.toDouble(), 'color': Colors.green},
                        {'label': 'Pending', 'value': pendingComplaints.toDouble(), 'color': Colors.blue},
                        {'label': 'In Progress', 'value': inProgressComplaints.toDouble(), 'color': Colors.orange},
                        {'label': 'Rejected', 'value': rejectedComplaints.toDouble(), 'color': Colors.red},
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Priority Distribution
                  Text(
                    'Priority Distribution',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 200,
                    child: AnalyticsBarChart(
                      data: [
                        {'label': 'High', 'value': highPriority.toDouble(), 'color': Colors.red},
                        {'label': 'Medium', 'value': mediumPriority.toDouble(), 'color': Colors.orange},
                        {'label': 'Low', 'value': lowPriority.toDouble(), 'color': Colors.green},
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Resolution Time Analysis
                  Text(
                    'Resolution Time Analysis',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildResolutionTimeCard(context, complaints),
                ],
              ),
            );
          }

          return const Center(child: Text('No data available'));
        },
      ),
    );
  }

  Widget _buildMetricCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(icon, color: color, size: 16),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Theme.of(context).hintColor,
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildResolutionTimeCard(BuildContext context, List<dynamic> complaints) {
    // Calculate average resolution time for resolved complaints
    final resolvedComplaints = complaints.where((c) => c.status == CompliantStatus.resolved).toList();
    double avgResolutionTime = 0;
    
    // if (resolvedComplaints.isNotEmpty) {
    //   final totalHours = resolvedComplaints.fold<double>(
    //     0,
    //     (sum, complaint) => sum + complaint.resolutionTime.inHours,
    //   );
    //   avgResolutionTime = totalHours / resolvedComplaints.length;
    // }

    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Average Resolution Time',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${avgResolutionTime.toStringAsFixed(1)} hours',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Based on ${resolvedComplaints.length} resolved complaints',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).hintColor,
            ),
          ),
        ],
      ),
    );
  }
}