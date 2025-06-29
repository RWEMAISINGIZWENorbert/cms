// ignore_for_file: unrelated_type_equality_checks, unnecessary_null_comparison, avoid_print
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class SelectMethodOption extends StatelessWidget {
  final String label;
  final ValueChanged<String?>? onSelect;
  final List<String> options;
  final String? initialValue;
  final bool isEditMode;

  const SelectMethodOption({
    super.key, 
    required this.label, 
    required this.onSelect, 
    required this.options,
    this.initialValue,
    this.isEditMode = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      child: ShadTheme(
         data: ShadThemeData(
          colorScheme: ShadColorScheme(
            background: isDarkMode ? Colors.white : Colors.black,
            cardForeground: isDarkMode ? Colors.white : Colors.black,
            card: isDarkMode ? Colors.white : Colors.black,
            popover: isDarkMode ? Colors.black : Colors.white,
            popoverForeground: isDarkMode ? Colors.white : Colors.black,
            primaryForeground: isDarkMode ? Colors.white : Colors.black,
            foreground: isDarkMode ? Colors.white : Colors.black,
            muted: isDarkMode ? Colors.white : Colors.black,
            mutedForeground: isDarkMode ? Colors.white : Colors.black,
            primary: isDarkMode ? Colors.amberAccent : Colors.green,
            secondary: isDarkMode ? Colors.white : Colors.black,
            secondaryForeground: isDarkMode ? Colors.white : Colors.black,
            selection: isDarkMode ? Colors.white : Colors.black,
            accent: isDarkMode ? Colors.amberAccent : Colors.green,
            accentForeground: isDarkMode ? Colors.white : Colors.black,
            border: isDarkMode ? const Color.fromARGB(255, 61, 61, 61) : const Color.fromARGB(255, 200, 200, 200),
            destructive: isDarkMode ? Colors.white : Colors.black,
            destructiveForeground: isDarkMode ? Colors.white : Colors.black,
            input: isDarkMode ? const Color.fromARGB(255, 49, 49, 49) : const Color.fromARGB(255, 240, 240, 240),
            ring: isDarkMode ? Colors.white : Colors.black,
          ),
          brightness: isDarkMode ? Brightness.dark : Brightness.light,
        ),
        child: ShadSelectFormField<String>(
          onSaved: ((e) => print("The value $e")),
          onChanged: onSelect,
          id: '$label method',
          initialValue: isEditMode ? initialValue : null,
          options: options
              .map((m) => ShadOption(value: m, child: Text(m)))
              .toList(),
          selectedOptionBuilder: (context, value) => value == null
              ? Text('Select the $label method')
              : Text(value),
          placeholder: Text('Select the $label method'),
          validator: (v) {
            if (v == null) {
              return 'Please select the $label to display';
            }
            return null;
          },
        ),
      ),
    );
  }
}