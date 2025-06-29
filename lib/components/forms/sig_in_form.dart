import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_associate/bloc/auth/auth_bloc.dart';
import 'package:tech_associate/bloc/compliant/compliant_bloc.dart';
import 'package:tech_associate/bloc/compliant/compliant_event.dart';
import 'package:tech_associate/widgets/continue_button.dart';
import 'package:tech_associate/widgets/input_text_field.dart';
import 'package:tech_associate/widgets/simple_text.dart';

class SigInForm extends StatelessWidget {
  const SigInForm({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SimpleText(label: 'email adress'),
          InputTextField(
            labelText: "Email",
            hintText: "Enter your email",
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
            onChanged: (value) => {},
          ),
          const SizedBox(height: 16),
          const SimpleText(label: 'password'),
          InputTextField(
            labelText: "password",
            hintText: "Enter your secret password",
            keyboardType: TextInputType.text,
            obscureText: true,
            controller: passwordController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
            onChanged: (value) => {},
          ),
          const SizedBox(height: 35),
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccessState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.sucessMsg))
                );
                context.read<CompliantBloc>().add(LoadCompliants());
                Navigator.pushNamed(context, '/mainScreen');
              } else if (state is AuthFailState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.failMsg))
                );
              }
            },
            builder: (context, state) {
              if (state is AuthLoadingState) {
                return ElevatedButton(
                  onPressed: () {},
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
                );
              }
              return ContinueButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    context.read<AuthBloc>().add(
                      SignInEvent(
                        emailAdress: emailController.text,
                        password: passwordController.text
                      )
                    );
                  }
                },
                label: "Log in",
              );
            },
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Don't have account ?",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/signUp');
                  },
                  child: Text(
                    'create account  here',
                    style: Theme.of(
                      context,
                    ).textTheme.displaySmall!.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}