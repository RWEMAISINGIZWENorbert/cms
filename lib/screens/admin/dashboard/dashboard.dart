import 'package:flutter/material.dart';
import 'package:tech_associate/components/__dashboard__/summary_card.dart';
import 'package:tech_associate/components/__dashboard__/top_bar.dart';
import 'package:tech_associate/widgets/graphs/bar_graph.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
        child: Container(
           margin: const EdgeInsets.only(top: 4, left: 8, right: 8),
           child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               const TopBar(),
               const SizedBox(height: 35,),
                // Text('complaint', style: Theme.of(context).textTheme.displaySmall,),
               const SummaryCard(),
               const SizedBox(height: 12),
               Text('Compliants trends', style: Theme.of(context).textTheme.displayMedium),
               const SizedBox(height: 250, child: MyBarGraph()),
               const SizedBox(height: 24),
               Text('Recent Activities', style: Theme.of(context).textTheme.displayMedium),
               const SizedBox(height: 12),
               _buildRecentActivities(context),
            ], 
           ),
        ),
    );
  }

  Widget _buildRecentActivities(BuildContext context) {
    final activities = [
      {
        'title': 'New Complaint Filed',
        'description': 'John Doe submitted a new complaint about network issues',
        'time': '2 hours ago',
        'icon': Icons.warning_amber_rounded,
        'color': Colors.orange,
      },
      {
        'title': 'Complaint Resolved',
        'description': 'Network connectivity issue resolved for Building A',
        'time': '4 hours ago',
        'icon': Icons.check_circle_outline,
        'color': Colors.green,
      },
      {
        'title': 'New Technician Assigned',
        'description': 'Sarah Smith assigned to handle maintenance request',
        'time': '5 hours ago',
        'icon': Icons.person_add_outlined,
        'color': Colors.blue,
      },
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: activities.length,
      itemBuilder: (context, index) {
        final activity = activities[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: activity['color'] as Color,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                activity['icon'] as IconData,
                color: Colors.white,
                size: 24,
              ),
            ),
            title: Text(
              activity['title'] as String,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  activity['description'] as String,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  activity['time'] as String,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).hintColor,
                  ),
                ),
              ],
            ),
            isThreeLine: true,
          ),
        );
      },
    );
  }
}