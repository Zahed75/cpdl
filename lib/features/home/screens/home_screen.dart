// lib/features/home/screens/home_screen.dart
import 'package:cpdl/common_ui/widgets/appBar/appbar.dart';
import 'package:flutter/material.dart';

import 'package:cpdl/features/home/widgets/properties_horizontal_list.dart';
import '../widgets/service_actions_grid.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const pad = EdgeInsets.symmetric(horizontal: 16);

    return Scaffold(
      // Brand app bar (teal). Subtitle shows the username.
      appBar: const UPrimaryAppBar(
        title: 'Welcome to CPDL',
        subtitle: 'Zahed Hasan',
      ),

      body: ListView(
        padding: const EdgeInsets.only(top: 16, bottom: 24),
        children: [
          // My Properties
          Padding(
            padding: pad,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'My Properties',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                TextButton(onPressed: () {}, child: const Text('View all')),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const PropertiesHorizontalList(),

          const SizedBox(height: 22),

          // Service
          Padding(
            padding: pad,
            child: Text(
              'Service',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(height: 12),
          const Padding(padding: pad, child: ServiceActionsGrid()),
        ],
      ),
    );
  }
}
