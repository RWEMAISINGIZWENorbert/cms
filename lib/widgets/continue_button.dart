
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContinueButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  const ContinueButton({
    super.key, 
    required this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return
      Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13),
      child: 
      ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
                 backgroundColor: Theme.of(context).primaryColor,
                 elevation: 0,
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(14)
                  )
                 ),
                  child: Center(
                     child: Text(
                      label, style: GoogleFonts.poppins(
                       color: Colors.white,
                       fontSize: 18,
                       fontWeight: FontWeight.w400
                     ),
                    ),
                  ),
          ),
    );
  }
}