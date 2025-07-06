// import 'package:flutter/material.dart';
// import 'package:iconly/iconly.dart';
// import 'package:tech_associate/data/models/compliant.dart';
// import 'package:tech_associate/widgets/app_bar.dart';

// class ComplaintDetails extends StatelessWidget {
//   final Compliant complaint;

//   const ComplaintDetails({
//     super.key,
//     required this.complaint,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBarComponent(
//         icon: InkWell(
//           onTap: () => Navigator.of(context).pop(),
//           child: const Icon(IconlyLight.arrow_left_circle),
//         ),
//         title: 'Complaint Details',
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildInfoCard(
//               context,
//               title: 'Title',
//               content: complaint.title,
//               icon: IconlyLight.document,
//             ),
//             const SizedBox(height: 16),
//             _buildInfoCard(
//               context,
//               title: 'Description',
//               content: complaint.description,
//               icon: IconlyLight.paper,
//             ),
//             const SizedBox(height: 16),
//             _buildInfoCard(
//               context,
//               title: 'Status',
//               content: complaint.status.name,
//               icon: IconlyLight.work,
//             ),
//             const SizedBox(height: 16),
//             _buildInfoCard(
//               context,
//               title: 'Priority',
//               content: complaint.priority.name,
//               icon: IconlyLight.work,
//             ),
//             const SizedBox(height: 16),
//             _buildInfoCard(
//               context,
//               title: 'Location',
//               content: complaint.location,
//               icon: IconlyLight.location,
//             ),
//             const SizedBox(height: 16),
//             _buildInfoCard(
//               context,
//               title: 'Submitted By',
//               content: complaint.submittedBy,
//               icon: IconlyLight.user,
//             ),
//             const SizedBox(height: 16),
//             _buildInfoCard(
//               context,
//               title: 'Telephone',
//               content: complaint.telephoneNumber,
//               icon: IconlyLight.call,
//             ),
//             const SizedBox(height: 16),
//             _buildInfoCard(
//               context,
//               title: 'Created At',
//               content: complaint.createdAt.toString(),
//               icon: IconlyLight.calendar,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoCard(
//     BuildContext context, {
//     required String title,
//     required String content,
//     required IconData icon,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Theme.of(context).cardColor,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Icon(icon, size: 20),
//               const SizedBox(width: 8),
//               Text(
//                 title,
//                 style: Theme.of(context).textTheme.titleSmall,
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           Text(
//             content,
//             style: Theme.of(context).textTheme.bodyMedium,
//           ),
//         ],
//       ),
//     );
//   }
// }

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:tech_associate/bloc/compliant/compliant_bloc.dart';
import 'package:tech_associate/bloc/compliant/compliant_event.dart';
import 'package:tech_associate/bloc/compliant/compliant_state.dart';
import 'package:tech_associate/data/models/compliant.dart';
import 'package:tech_associate/widgets/app_bar.dart';

class ComplaintDetails extends StatelessWidget {
  final Compliant complaint;

  const ComplaintDetails({
    super.key,
    required this.complaint,
  });

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return const Color.fromRGBO(255, 152, 0, 1);
      case 'in progress':
        return Colors.blue;
      case 'resolved':
        return Colors.green;
      case 'closed':
        return Colors.grey;
      default:
        return Colors.blue;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.green;
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompliantBloc, CompliantState>(
      builder: (context, state) {
        // Get the updated complaint from the state if available
        final updatedComplaint = state is CompliantLoaded 
            ? state.compliants.firstWhere((c) => c.id == complaint.id, orElse: () => complaint)
            : state is CompliantSuccess && state.updatedCompliant?.id == complaint.id
                ? state.updatedCompliant!
                : complaint;

        // Show success message when state is CompliantSuccess
        // if (state is CompliantSuccess) {
        //   WidgetsBinding.instance.addPostFrameCallback((_) {
        //     ScaffoldMessenger.of(context).showSnackBar(
        //       SnackBar(
        //         content: Text(state.message),
        //         backgroundColor: Colors.green,
        //         duration: const Duration(seconds: 2),
        //       ),
        //     );
        //   });
        // }
        if(state is CompliantLoading){
            return const Center(
              child: CircularProgressIndicator(),
            );
        }

        return Scaffold(
          backgroundColor: Theme.of(context).cardColor,
          appBar: AppBarComponent(
            icon: InkWell(
              onTap: () {
                context.read<CompliantBloc>().add(LoadCompliants());
                Navigator.of(context).pop();
              },
              child: const Icon(IconlyLight.arrow_left_circle),
            ),
            title: 'Complaint Details',
            actions: [
              IconButton(
                onPressed: () {
                  // Add edit functionality
                },
                icon: const Icon(IconlyLight.edit, size: 22),
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Status and Priority Section
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: _getStatusColor(updatedComplaint.status.name).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        updatedComplaint.status.name,
                        style: TextStyle(
                          color: _getStatusColor(updatedComplaint.status.name),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: _getPriorityColor(updatedComplaint.priority.name).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.flag,
                            size: 16,
                            color: _getPriorityColor(updatedComplaint.priority.name),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            updatedComplaint.priority.name,
                            style: TextStyle(
                              color: _getPriorityColor(updatedComplaint.priority.name),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Title Section
                Text(
                  'Title',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Theme.of(context).hintColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  updatedComplaint.title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),

                // Description Section
                Text(
                  'Description',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Theme.of(context).hintColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  updatedComplaint.description,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 24),

                // Location Section
                Text(
                  'Location',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Theme.of(context).hintColor,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      IconlyLight.location,
                      size: 20,
                      color: Theme.of(context).hintColor,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      updatedComplaint.location,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Contact Information Section
                Text(
                  'Contact Information',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Theme.of(context).hintColor,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      IconlyLight.user,
                      size: 20,
                      color: Theme.of(context).hintColor,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      updatedComplaint.submittedBy,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      IconlyLight.call,
                      size: 20,
                      color: Theme.of(context).hintColor,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      updatedComplaint.telephoneNumber,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Time Section
                Text(
                  'Reported',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Theme.of(context).hintColor,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      IconlyLight.time_circle,
                      size: 20,
                      color: Theme.of(context).hintColor,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      updatedComplaint.createdAt.toString(),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          _showConfirmationDialog(
                            context,
                            title: 'Mark as Solved',
                            description: 'Are you sure you want to mark this complaint as solved?',
                            onConfirm: () {
                              context.read<CompliantBloc>().add(
                                UpdateCompliant(
                                  updatedComplaint.copyWith(
                                    status: CompliantStatus.resolved,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          backgroundColor: Colors.green.withOpacity(0.1),
                          foregroundColor: Colors.green,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(color: Colors.green.withOpacity(0.5)),
                          ),
                        ),
                        child: const Text(
                          'Mark as Solved',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          _showConfirmationDialog(
                            context,
                            title: 'Reject',
                            description: 'Are you sure you want to reject this complaint?',
                            onConfirm: () {
                              context.read<CompliantBloc>().add(
                                UpdateCompliant(
                                  updatedComplaint.copyWith(
                                    status: CompliantStatus.rejected
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          backgroundColor: Colors.red.withOpacity(0.1),
                          foregroundColor: Colors.red,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(color: Colors.red.withOpacity(0.5)),
                          ),
                        ),
                        child: const Text(
                          'Reject',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showConfirmationDialog(
    BuildContext context, {
    required String title,
    required String description,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(description),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel', style: TextStyle(color: Colors.red),),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onConfirm();
              },
              child: Text('Confirm', style: TextStyle(color: Theme.of(context).primaryColor),),
            ),
          ],
        );
      },
    );
  }
}