import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_associate/bloc/compliant/compliant_bloc.dart';
import 'package:tech_associate/bloc/compliant/compliant_state.dart';
import 'package:tech_associate/data/models/compliant.dart';
import 'package:tech_associate/widgets/card_box.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard({super.key});

  double _getCountByStatus(List<Compliant> compliants, CompliantStatus status) {
    return compliants.where((c) => c.status == status).length.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: BlocBuilder<CompliantBloc, CompliantState>(
        builder: (context, state) {
          if (state is CompliantLoaded) {
            final compliants = state.compliants;
            return ListView(
         scrollDirection: Axis.horizontal,
         children: [
                CardBox(
                  name: 'Open',
                  totalAmount: _getCountByStatus(compliants, CompliantStatus.open),
                ),
                CardBox(
                  name: 'In Progress',
                  totalAmount: _getCountByStatus(compliants, CompliantStatus.inProgress),
                ),
                CardBox(
                  name: 'Resolved',
                  totalAmount: _getCountByStatus(compliants, CompliantStatus.resolved),
                ),
                CardBox(
                  name: 'Rejected',
                  totalAmount: _getCountByStatus(compliants, CompliantStatus.rejected),
                ),
              ],
            );
          }
          // Show loading state or default values
          return ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              CardBox(name: 'Open', totalAmount: 0.0),
              CardBox(name: 'In Progress', totalAmount: 0.0),
              CardBox(name: 'Resolved', totalAmount: 0.0),
              CardBox(name: 'Rejected', totalAmount: 0.0),
         ],
          );
        },
      ),
    );
  }
}