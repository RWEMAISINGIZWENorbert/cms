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
   return ShadTheme(
       data: ShadThemeData(
        colorScheme: const ShadColorScheme(
          background: Colors.white,
          cardForeground: Colors.white,
          card: Colors.white,
          popover: Colors.black,
          popoverForeground: Colors.white,
          primaryForeground: Colors.white,
          foreground: Colors.white,
          muted: Colors.white,
          mutedForeground: Colors.white,
          primary:  ThemeMode.light == true ? Colors.amberAccent : Colors.green,
          secondary: Colors.white,
          secondaryForeground: Colors.white,
          selection: Colors.white,
          accent: ThemeMode.light == true ? Colors.amberAccent : Colors.green,
          accentForeground: Colors.white,
          border: Color.fromARGB(255, 61, 61, 61),
          destructive: Colors.white,
          destructiveForeground: Colors.white,
          input: Color.fromARGB(255, 49, 49, 49),
          ring: Colors.white,
        ),
        brightness: Brightness.dark,
      ),
      child: ShadSelectFormField<String>(
        onSaved: ((e) => print("The value $e")),
        onChanged: onSelect,
        id: '$label method',
        minWidth: 350,
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
    );
  }
}