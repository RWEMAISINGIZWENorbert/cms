// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_associate/bloc/compliant/compliant_bloc.dart';
import 'package:tech_associate/bloc/compliant/compliant_event.dart';
import 'package:tech_associate/bloc/compliant/compliant_state.dart';
import 'package:tech_associate/components/forms/constraint_form.dart';
import 'package:tech_associate/widgets/action_button.dart';
import 'package:tech_associate/widgets/continue_button.dart';
import 'package:tech_associate/data/models/category.dart';
import 'package:tech_associate/cubit/theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  Category? _selectedCategory;
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _telephoneController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _titleController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _telephoneController.dispose();
    _descriptionController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate() && _selectedCategory != null) {
      const location = 'Kigali, Rwanda';
      print(" Selected category ${_selectedCategory!.name}");
      context.read<CompliantBloc>().add(
        AddCompliant(
          title: _titleController.text,
          description: _descriptionController.text,
          category: _selectedCategory!.name,
          location: location,
          submittedBy: _fullNameController.text,
          telephoneNumber: _telephoneController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = isDark ? Colors.white : Colors.black;
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          // Theme Toggle Button
          BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeMode) {
              return IconButton(
                onPressed: () {
                  final currentTheme = context.read<ThemeCubit>().state;
                  final newTheme = currentTheme == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
                  context.read<ThemeCubit>().updateTheme(newTheme);
                },
                icon: Icon(
                  themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
                  color: color,
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8.0),
            child: ActionButton(
              onTap: () {
                Navigator.pushNamed(context, '/signIn');
              },
            ),
          )
        ],
      ),
      body: BlocListener<CompliantBloc, CompliantState>(
        listener: (context, state) {
          if (state is CompliantSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            // Clear form after successful submission
            _formKey.currentState?.reset();
            _selectedCategory = null;
            _fullNameController.clear();
            _emailController.clear();
            _telephoneController.clear();
            _descriptionController.clear();
          } else if (state is CompliantError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    'Add new compliant',
                    style: Theme.of(context)
                    .textTheme.titleSmall!.copyWith(
                       color: color
                      ),
                  ),
                ),
                const SizedBox(height: 5),
                ConstraintForm(
                  formKey: _formKey,
                  selectedCategoryId: _selectedCategory?.id,
                  onCategorySelected: (value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                  fullNameController: _fullNameController,
                  emailController: _emailController,
                  telephoneController: _telephoneController,
                  descriptionController: _descriptionController,
                  titleController: _titleController,
                ),
                const SizedBox(height: 30),
               Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                    onPressed: (){
                       Navigator.pushNamed(context, '/trackStatus');
                    },
                    child: Text(
                      'Track compliant', 
                      style: Theme.of(context).textTheme
                      .labelSmall!.copyWith(color: Theme.of(context).primaryColor),
                      ) 
                    )
                    ],
                ),
                BlocBuilder<CompliantBloc, CompliantState>(
                  builder: (context, state) {
                    return ContinueButton(
                      label: 'Submit',
                      onPressed: state is CompliantLoading ? () {} : _handleSubmit,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}