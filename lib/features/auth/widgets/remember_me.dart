// lib/features/authentication/screens/login/widgets/remember_me.dart
import 'package:flutter/material.dart';

class URememberMeCheckbox extends StatelessWidget {
  const URememberMeCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: value, onChanged: onChanged),
        const Text('Remember Me'),
      ],
    );
  }
}
