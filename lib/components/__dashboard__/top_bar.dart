import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:tech_associate/bloc/auth/auth_bloc.dart';
// import 'package:tech_associate/bloc/auth/auth_state.dart';

class TopBar extends StatefulWidget {
  const TopBar({super.key});

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  @override
  void initState() {
    super.initState();
    // Trigger LoadCurrentUserData when the component is first created
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthBloc>().add(LoadCurrentUserData());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        String userName = 'User'; // Default name
        
        if (state is UserDataLoaded) {
          userName = state.name;
        }
        
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(children: [
                TextSpan(
                    text:
                        '${DateTime.now().hour < 12 ? "good morning" : "good afternoon"} ,\n',
                    style: Theme.of(context).textTheme.displaySmall),
                TextSpan(
                    text: userName,
                    style: GoogleFonts.poppins(
                        color: Theme.of(context).hintColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w400
                        ))
              ]),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  backgroundColor: Theme.of(context).cardColor,
                  child: InkWell(
                    onTap: () => Navigator.pushNamed(context, '/notifications'),
                    child: Icon(
                      IconlyLight.notification,
                      size: 24,
                      fill: 1.0,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                ),
                VerticalDivider(
                  color: Theme.of(context).cardColor,
                  indent: 10,
                  endIndent: 10,
                  thickness: 0.1,
                ),
              ],
            )
          ],
        );
      },
    );
  }
}