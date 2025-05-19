import 'package:flutter/material.dart';
import 'package:tech_associate/widgets/input_text_field.dart' show InputTextField;
import 'package:tech_associate/widgets/forms/category_selector.dart';
import 'package:tech_associate/data/models/category.dart';

class ConstraintForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final String? selectedCategoryId;
  final Function(Category) onCategorySelected;
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController telephoneController;
  final TextEditingController descriptionController;
  final TextEditingController titleController;

  const ConstraintForm({
    super.key,
    required this.formKey,
    required this.selectedCategoryId,
    required this.onCategorySelected,
    required this.fullNameController,
    required this.emailController,
    required this.telephoneController,
    required this.descriptionController,
    required this.titleController
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [                 
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text('Title', style: Theme.of(context).textTheme.displayMedium),
              ),
              const SizedBox(height: 4),
              InputTextField(
                controller: titleController,
                labelText: 'title of your complaint',
                keyboardType: TextInputType.name,
                hintText: 'e.g The road is broken',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the title';
                  }
                  return null;
                },
              ),
            ],
          ),
          const SizedBox(height: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text('Choose Category', style: Theme.of(context).textTheme.displayMedium),
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: CategorySelector(
                  selectedCategoryId: selectedCategoryId,
                  onCategorySelected: onCategorySelected,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text('Full Names', style: Theme.of(context).textTheme.displayMedium),
              ),
              const SizedBox(height: 4),
              InputTextField(
                controller: fullNameController,
                labelText: 'your names',
                keyboardType: TextInputType.name,
                hintText: 'e.g john',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null;
                },
              ),
            ],
          ),
          const SizedBox(height: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text('Email Address', style: Theme.of(context).textTheme.displayMedium),
              ),
              const SizedBox(height: 4),
              InputTextField(
                controller: emailController,
                labelText: 'your email address',
                keyboardType: TextInputType.emailAddress,
                hintText: 'e.g john@gmail.com',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
            ],
          ),
          const SizedBox(height: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text('Telephone Number', style: Theme.of(context).textTheme.displayMedium),
              ),
              const SizedBox(height: 4),
              InputTextField(
                controller: telephoneController,
                labelText: 'tel no',
                keyboardType: TextInputType.phone,
                hintText: 'e.g 0797788',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your telephone number';
                  }
                  return null;
                },
              ),
            ],
          ),
          const SizedBox(height: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text('Description', style: Theme.of(context).textTheme.displayMedium),
              ),
              const SizedBox(height: 4),
              InputTextField(
                controller: descriptionController,
                labelText: 'fill the description of your complaint',
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                hintText: 'Describe your constraint...',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please describe your constraint';
                  }
                  return null;
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}