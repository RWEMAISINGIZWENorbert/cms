import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_associate/bloc/compliant/compliant_bloc.dart';
import 'package:tech_associate/bloc/compliant/compliant_state.dart';
import 'package:tech_associate/components/__dashboard__/summary_card.dart';
import 'package:tech_associate/components/__dashboard__/top_bar.dart';
import 'package:tech_associate/data/models/compliant.dart';
import 'package:tech_associate/widgets/graphs/bar_graph.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompliantBloc, CompliantState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Container(
            color: Theme.of(context).cardColor,
            margin: const EdgeInsets.only(top: 4, left: 8, right: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TopBar(),
                const SizedBox(height: 35),
                const SummaryCard(),
                const SizedBox(height: 12),
                Text('Compliants trends', style: Theme.of(context).textTheme.displayMedium),
                const SizedBox(height: 250, child: MyBarGraph()),
                const SizedBox(height: 24),
                Text('Recent Activities', style: Theme.of(context).textTheme.displayMedium),
                const SizedBox(height: 12),
                _buildRecentActivities(context, state),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRecentActivities(BuildContext context, CompliantState state) {
    if (state is CompliantLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is CompliantLoaded) {
      final compliants = state.compliants;
      
      // Debug: Print complaint data
      print('Total complaints loaded: ${compliants.length}');
      for (var complaint in compliants.take(3)) {
        print('Complaint: ${complaint.title} - Status: ${complaint.status} - Created: ${complaint.createdAt}');
      }
      
      // Get the most recent activities
      final activities = _getRecentActivities(compliants);
      
      // Debug: Print activities
      print('Generated activities: ${activities.length}');
      for (var activity in activities) {
        print('Activity: ${activity['title']} - ${activity['time']}');
      }
      
      if (activities.isEmpty) {
        return Center(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              // color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.history,
                  size: 48,
                  color: Theme.of(context).hintColor.withOpacity(0.5),
                ),
                const SizedBox(height: 16),
                Text(
                  'No recent activities',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: Theme.of(context).hintColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Total complaints: ${compliants.length}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).hintColor,
                  ),
                ),
              ],
            ),
          ),
        );
      }

      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: activities.length,
        itemBuilder: (context, index) {
          final activity = activities[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            color: Theme.of(context).scaffoldBackgroundColor,
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

    // Default empty state
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          // color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(
              Icons.history,
              size: 48,
              color: Theme.of(context).hintColor.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'No activities available',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).hintColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getRecentActivities(List<Compliant> compliants) {
    final activities = <Map<String, dynamic>>[];
    
    if (compliants.isEmpty) {
      return activities;
    }
    
    // Sort complaints by creation date (most recent first)
    final sortedComplaints = List<Compliant>.from(compliants)
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    // Get the most recent complaint for each status type
    final openComplaints = sortedComplaints.where((c) => c.status == CompliantStatus.open).toList();
    final resolvedComplaints = sortedComplaints.where((c) => c.status == CompliantStatus.resolved).toList();
    final rejectedComplaints = sortedComplaints.where((c) => c.status == CompliantStatus.rejected).toList();
    final inProgressComplaints = sortedComplaints.where((c) => c.status == CompliantStatus.inProgress).toList();

    // Add activities based on actual data
    if (openComplaints.isNotEmpty) {
      final lastFilled = openComplaints.first;
      activities.add({
        'title': 'New Complaint Filed',
        'description': '${lastFilled.submittedBy} submitted: ${lastFilled.title}',
        'time': _getTimeAgo(lastFilled.createdAt),
        'icon': Icons.warning_amber_rounded,
        'color': Colors.orange,
      });
    }

    if (resolvedComplaints.isNotEmpty) {
      final lastResolved = resolvedComplaints.first;
      activities.add({
        'title': 'Complaint Resolved',
        'description': '${lastResolved.title} has been resolved',
        'time': _getTimeAgo(lastResolved.createdAt),
        'icon': Icons.check_circle_outline,
        'color': Colors.green,
      });
    }

    if (rejectedComplaints.isNotEmpty) {
      final lastRejected = rejectedComplaints.first;
      activities.add({
        'title': 'Complaint Rejected',
        'description': '${lastRejected.title} was rejected',
        'time': _getTimeAgo(lastRejected.createdAt),
        'icon': Icons.cancel_outlined,
        'color': Colors.red,
      });
    }

    if (inProgressComplaints.isNotEmpty) {
      final lastInProgress = inProgressComplaints.first;
      activities.add({
        'title': 'Complaint In Progress',
        'description': '${lastInProgress.title} is being processed',
        'time': _getTimeAgo(lastInProgress.createdAt),
        'icon': Icons.engineering,
        'color': Colors.blue,
      });
    }

    // Sort activities by time (most recent first) and take only the first 4
    activities.sort((a, b) => _parseTimeAgo(b['time']).compareTo(_parseTimeAgo(a['time'])));
    return activities.take(4).toList();
  }

  String _getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
    } else {
      return 'Just now';
    }
  }

  DateTime _parseTimeAgo(String timeAgo) {
    final now = DateTime.now();
    if (timeAgo.contains('day')) {
      final days = int.tryParse(timeAgo.split(' ')[0]) ?? 0;
      return now.subtract(Duration(days: days));
    } else if (timeAgo.contains('hour')) {
      final hours = int.tryParse(timeAgo.split(' ')[0]) ?? 0;
      return now.subtract(Duration(hours: hours));
    } else if (timeAgo.contains('minute')) {
      final minutes = int.tryParse(timeAgo.split(' ')[0]) ?? 0;
      return now.subtract(Duration(minutes: minutes));
    } else {
      return now;
    }
  }
}