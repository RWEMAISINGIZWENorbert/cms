
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData  lightTheme = ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.grey[200],
        primaryColor: Colors.green[700],
        highlightColor: Colors.grey[300],
        secondaryHeaderColor: Colors.grey[700],
        cardColor: const Color.fromRGBO(255, 255, 255, 1),
        hintColor: Colors.black87,
        iconTheme: IconThemeData(
          size: 28,
          fill: 1.0,
          color: Colors.black87
        ),
        textTheme: TextTheme(
          titleLarge: GoogleFonts.poppins(
            color: Colors.green[700],
            // fontSize: 18,
            fontSize: 36,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.24
          ),
          titleSmall: GoogleFonts.poppins(
            // color: Theme.of(context).primaryColor, // it returns the default peimary color hence an issue
            color: Colors.green[700],
            // fontSize: 9,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.24
          ),
          titleMedium: GoogleFonts.poppins(
            color: const Color.fromARGB(255, 0, 0, 0),
            fontSize: 18,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.24
          ),
         displayMedium: GoogleFonts.poppins(
            color: Colors.grey[900],
            fontSize: 16,
            fontWeight: FontWeight.w400
            ),
          displaySmall: GoogleFonts.poppins(
            color: Colors.grey[800],
            fontSize: 12,
            fontWeight: FontWeight.w400,
            decoration: TextDecoration.none
            ),
            labelSmall: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 13,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.none,
              letterSpacing: 0.2, // Improves clarity
              height: 1.2, // Increases readability
            ),
            labelMedium: GoogleFonts.poppins(
              color: Colors.black,
              // fontSize: 7,
              fontSize: 14,
              fontWeight: FontWeight.w600
            ),
          )

      );

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black45,
  primaryColor: Colors.green[700],
  // primaryColor: Colors.amber[700],
  textTheme: TextTheme(
              titleLarge: GoogleFonts.poppins(
            color: Colors.green[700],
            // fontSize: 18,
            fontSize: 36,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.24
          ),
            titleSmall: GoogleFonts.poppins(
            // color: Theme.of(context).primaryColor, // it returns the default peimary color hence an issue
            color: Colors.green[700],
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.24
          ),   
            titleMedium: GoogleFonts.poppins(
            color: Colors.grey[200],
            fontSize: 18,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.24
          ),
           displayMedium: GoogleFonts.poppins(
            color: Colors.grey[300],
            fontSize: 16,
            fontWeight: FontWeight.w400
            ),
             displaySmall: GoogleFonts.poppins(
            color: Colors.grey[400],
            fontSize: 12,
            fontWeight: FontWeight.w400,
            decoration: TextDecoration.none
            ),

  )
);