import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:tech_associate/bloc/compliant/compliant_bloc.dart';
import 'package:tech_associate/bloc/compliant/compliant_event.dart';
import 'package:tech_associate/bloc/compliant/compliant_state.dart';
import 'package:tech_associate/widgets/app_bar.dart';
import 'package:tech_associate/widgets/continue_button.dart';
import 'package:tech_associate/widgets/input_text_field.dart';

class TrackStatus extends StatelessWidget {
  const TrackStatus({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController ticketController = TextEditingController();
    final double screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Scaffold(
        appBar: AppBarComponent(
          icon: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(IconlyLight.arrow_left_circle),
          ),
          title: 'Track your compliant',
        ),
        body: BlocBuilder<CompliantBloc, CompliantState>(
          builder: (context, state) {
            return SizedBox(
              height: screenHeight * 0.7,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        'Ticket Id',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                    const SizedBox(height: 4),
                    InputTextField(
                      labelText: "Ticket Id",
                      hintText: "Enter your ticket id",
                      keyboardType: TextInputType.number,
                      controller: ticketController,
                      onChanged: (value) => {},
                    ),
                    const SizedBox(height: 20),
                    ContinueButton(
                      onPressed: () {
                        context.read<CompliantBloc>().add(
                          TrackCompliant(ticketId: ticketController.text),
                        );
                      },
                      label: 'Submit',
                    ),
                    const SizedBox(height: 30),
                    if (state is CompliantTracked && state.compliant != null)
                      Center(
                        child: Container(
                          width: 350,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.compliant!.title,
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const SizedBox(height: 12),
                              Text("Status: ${state.compliant!.status.displayName}"),
                              Text("Ticket ID: ${state.compliant!.id}"),
                              const SizedBox(height: 8),
                              Text("Description: ${state.compliant!.description}"),
                              const SizedBox(height: 8),
                              Text("Submitted by: ${state.compliant!.submittedBy}"),
                            ],
                          ),
                        ),
                      ),
                    if (state is CompliantTracked && state.error != null)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            state.error!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
