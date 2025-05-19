
import 'package:flutter/material.dart';

class CreateBtn extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const CreateBtn({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ElevatedButton(
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
                      label, 
                      style: Theme.of(context).textTheme.displaySmall
                      !.copyWith(
                        color: Colors.white,
                        ),
                    ),
                  ),
          ),
    );
  }
}