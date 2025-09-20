// lib/features/property/screens/property_details_screen.dart
import 'package:flutter/material.dart';

class PropertyDetailsScreen extends StatelessWidget {
  const PropertyDetailsScreen({
    super.key,
    required this.propertyId,
    required this.title,
  });

  final String propertyId;
  final String title;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Property ID: $propertyId', style: t.titleMedium),
            const SizedBox(height: 12),
            Text('More details coming soon...', style: t.bodyMedium),
          ],
        ),
      ),
    );
  }
}
