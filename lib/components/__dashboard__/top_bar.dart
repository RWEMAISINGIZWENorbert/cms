import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return   Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text:
                            '${DateTime.now().hour < 12 ? "good morning" : "good afternoon"} ,\n',
                        style: Theme.of(context).textTheme.displaySmall),
                    TextSpan(
                        text: 'Rwema',
                        style: GoogleFonts.poppins(
                            color: Theme.of(context).hintColor,
                            fontSize: 26,
                            fontWeight: FontWeight.w500
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
  }
}