// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardBox extends StatelessWidget {
  final String name;
  final double totalAmount; 
  const CardBox({super.key, required this.name, required this.totalAmount});

  @override
  Widget build(BuildContext context) {
     return SizedBox(
      // width: screenWidth <= 450 ? screenWidth / 1.6 : screenHeight / 4,
      // height: screenHeight <= 714 ? 178.5 : screenHeight / 4,
      width: 250,
      height: 210,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: GoogleFonts.poppins(
                    color: Theme.of(context).hintColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const Spacer(),
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: totalAmount.toStringAsFixed(0),
                    style: GoogleFonts.poppins(
                      // color: name.toLowerCase().contains('profit') || name.toLowerCase().contains('loss')
                      //     ? (totalAmount >= 0 ? Colors.green : Colors.red)
                      //     : Theme.of(context).hintColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: "",
                    style: GoogleFonts.poppins(
                      color: Theme.of(context).hintColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}