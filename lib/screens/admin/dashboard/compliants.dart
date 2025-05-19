// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:tech_associate/bloc/compliant/compliant_bloc.dart';
import 'package:tech_associate/bloc/compliant/compliant_event.dart';
import 'package:tech_associate/bloc/compliant/compliant_state.dart';
import 'package:tech_associate/data/models/compliant.dart';
import 'package:tech_associate/widgets/app_bar.dart';
import 'package:tech_associate/screens/admin/dashboard/complaint_details.dart';

class Compliants extends StatefulWidget {
  const Compliants({super.key});

  @override
  State<Compliants> createState() => _CompliantsState();
}

class _CompliantsState extends State<Compliants> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load complaints when the screen is initialized
    context.read<CompliantBloc>().add(LoadCompliants());
  }

  void _navigateToDetails(Compliant complaint) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ComplaintDetails(complaint: complaint),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _isSearching ? _buildSearchAppBar() : _buildNormalAppBar(),
      body: _isSearching ? _buildSearchResults() : _buildComplaintsList(),
    );
  }

  PreferredSizeWidget _buildSearchAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(IconlyLight.arrow_left_circle),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Container(
        height: 40,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextField(
          controller: _searchController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Search complaints...',
            hintStyle: TextStyle(color: Theme.of(context).hintColor),
            prefixIcon: const Icon(IconlyLight.search, size: 20),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
          ),
          onChanged: (value) {
            setState(() {});
          },
        ),
      ),
      actions: [
        IconButton(
          onPressed: _toggleSearch,
          icon: const Icon(IconlyLight.close_square, size: 22),
        ),
      ],
    );
  }

  PreferredSizeWidget _buildNormalAppBar() {
    return AppBarComponent(
      icon: InkWell(
        onTap: () => Navigator.of(context).pop(),
        child: const Icon(IconlyLight.arrow_left_circle),
      ),
      title: 'Compliants',
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: _toggleSearch,
              icon: const Icon(IconlyLight.search, size: 22),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(IconlyLight.filter_2, size: 22),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSearchResults() {
    return BlocBuilder<CompliantBloc, CompliantState>(
      builder: (context, state) {
        if (state is CompliantLoaded) {
          final searchResults = state.compliants.where((complaint) =>
              complaint.title.toLowerCase().contains(_searchController.text.toLowerCase()) ||
              complaint.description.toLowerCase().contains(_searchController.text.toLowerCase())).toList();

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: searchResults.length,
            itemBuilder: (context, index) {
              final complaint = searchResults[index];
              return _buildComplaintItem(complaint);
            },
          );
        }
        return const Center(child: Text('No complaints found'));
      },
    );
  }

  Widget _buildComplaintsList() {
    return BlocBuilder<CompliantBloc, CompliantState>(
      builder: (context, state) {
        if (state is CompliantLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if(state is CompliantInitial){
          return const Center(
            child: CircularProgressIndicator(),
          );          
        }
        else if (state is CompliantLoaded || state is CompliantSuccess) {
          final complaints = state is CompliantLoaded 
              ? state.compliants 
              : (state as CompliantSuccess).updatedCompliant != null 
                  ? [state.updatedCompliant!]
                  : [];
                  
          if (complaints.isEmpty) {
            return const Center(
              child: Text('No complaints found'),
            );
          }
          
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: complaints.length,
            itemBuilder: (context, index) {
              final complaint = complaints[index];
              return _buildComplaintItem(complaint);
            },
          );
        } else if (state is CompliantError) {
          return Center(
            child: Text(state.message),
          );
        }
        return const Center(
          child: Text('No complaints found'),
        );
      },
    );
  }

  Widget _buildComplaintItem(Compliant complaint) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => _navigateToDetails(complaint),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: complaint.status.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      complaint.status.displayName,
                      style: TextStyle(
                        color: complaint.status.color,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: complaint.priority.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.flag,
                          size: 16,
                          color: complaint.priority.color,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          complaint.priority.displayName,
                          style: TextStyle(
                            color: complaint.priority.color,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                complaint.title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                complaint.description,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Icon(
                    IconlyLight.time_circle,
                    size: 16,
                    color: Theme.of(context).hintColor,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    complaint.getRelativeTimeString(),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
