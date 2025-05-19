import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final VoidCallback onTap;
  const ActionButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
       return   GestureDetector(
                  onTap: onTap,
                  child: Container(
                    width: 85,
                    height: 37,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.green[600],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'staff Login',
                       style: Theme.of(context).textTheme.displaySmall!.copyWith(color: Colors.white),
                      // style: GoogleFonts.poppins(
                      //   color: Colors.white,
                      //   fontWeight: FontWeight.w500,
                      //   fontSize: 18,
                      // ),
                    )
                  )
             );   
  }
}