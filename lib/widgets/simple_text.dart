import 'package:flutter/material.dart';

class SimpleText extends StatelessWidget {
  final String label; 
  const SimpleText({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 6), 
      child: Text(label, style: Theme.of(context).textTheme.displayMedium,)
      );
  }
}