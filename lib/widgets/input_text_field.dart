import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final int? maxLines;

  const InputTextField({
    super.key,
    required this.labelText,
    required this.hintText,
    this.obscureText = false,
    this.controller,
    this.keyboardType,
    this.focusNode,
    this.validator,
    this.onChanged,
    this.maxLines
  });

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);

    return Focus(
      focusNode: focusNode,
      child: Builder(
        builder: (context) {
          final hasFocus = Focus.of(context).hasFocus;
          return MouseRegion(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: hasFocus
                      ? Colors.grey
                      : Theme.of(context).secondaryHeaderColor,
                  width: hasFocus ? 3.0 : 1.5,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: TextFormField(
                  focusNode: focusNode,
                  controller: controller,
                  keyboardType: keyboardType,
                  obscureText: obscureText,
                  maxLines: obscureText ? 1 : (maxLines ?? 1),
                  validator: validator,
                  onChanged: onChanged,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    // labelText: labelText,
                    hintText: hintText,
                    // hoverColor: colorScheme.primary.withOpacity(0.1),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}