import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_associate/bloc/auth/auth_bloc.dart';
import 'package:tech_associate/widgets/continue_button.dart';
import 'package:tech_associate/widgets/input_text_field.dart';
import 'package:tech_associate/widgets/forms/department_selector.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String? _selectedDepartmentId;
  String _selectedDepartment = '';

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement sign up logic
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      'Full Name',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                  const SizedBox(height: 4),
                  InputTextField(
                    controller: _fullNameController,
                    labelText: 'your full name',
                    keyboardType: TextInputType.name,
                    hintText: 'e.g John Doe',
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
                    child: Text(
                      'Email',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                  const SizedBox(height: 4),
                  InputTextField(
                    controller: _emailController,
                    labelText: 'your email address',
                    keyboardType: TextInputType.emailAddress,
                    hintText: 'e.g john@example.com',
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
                    child: Text(
                      'Department',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: DepartmentSelector(
                      selectedDepartmentId: _selectedDepartmentId,
                      onDepartmentSelected: (department) {
                        setState(() {
                          _selectedDepartmentId = department.id;
                          _selectedDepartment = department.name;
                        });
                      },
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
                    child: Text(
                      'Password',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                  const SizedBox(height: 4),
                  InputTextField(
                    controller: _passwordController,
                    labelText: 'your password',
                    obscureText: true,
                    hintText: 'Enter your password',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
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
                    child: Text(
                      'Confirm Password',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                  const SizedBox(height: 4),
                  InputTextField(
                    controller: _confirmPasswordController,
                    labelText: 'confirm your password',
                    obscureText: true,
                    hintText: 'Confirm your password',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                ],
              ),
              const SizedBox(height: 30),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if(state is AuthSuccessState){
                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.sucessMsg)));
                     Navigator.pushNamed(context, '/signIn');
                  }else if(state is AuthFailState){
                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.failMsg)));
                  }
                },
                builder: (context, state) {
                  if(state is AuthLoadingState){
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: (){},
                   style: ElevatedButton.styleFrom(
                 backgroundColor: Theme.of(context).primaryColor,
                 elevation: 0,
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(14)
                  )
                 ),
                  child: const Center(
                     child: CircularProgressIndicator()
                  ),
               ),
                  );
                  }
                  return SizedBox(
                    width: double.infinity,
                    child: ContinueButton(
                      onPressed: () {
                         context.read<AuthBloc>().add(
                          SignUpEvent(
                            email: _emailController.text, 
                            userName: _fullNameController.text, 
                            department: _selectedDepartment, 
                            telephone: 079336736736, 
                            password: _passwordController.text, 
                            cPassword: _confirmPasswordController.text
                            ));
                      },
                      label: "create account",
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Don't have account ?",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/signIn');
                    },
                    child: Text(
                      'login here',
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
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
