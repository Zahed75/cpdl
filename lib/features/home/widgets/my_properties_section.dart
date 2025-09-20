// lib/features/home/widgets/my_properties_section.dart
import 'package:flutter/material.dart';
import '../../property/screens/property_details_screen.dart';

class MyPropertiesSection extends StatelessWidget {
  const MyPropertiesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;

    // demo data
    final items = [
      const _PropertyCardModel(
        id: 'P-1001',
        name: 'Lake View Apartment',
        address: 'Road 12, Banani, Dhaka',
        status: 'Handover: Nov 2025',
      ),
      const _PropertyCardModel(
        id: 'P-1002',
        name: 'Green Residency',
        address: 'Sector 4, Uttara, Dhaka',
        status: 'Handover: Jan 2026',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'My Properties',
          style: t.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12),
        ListView.separated(
          itemCount: items.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (_, i) => _PropertyCard(item: items[i]),
        ),
      ],
    );
  }
}

class _PropertyCardModel {
  final String id;
  final String name;
  final String address;
  final String status;
  const _PropertyCardModel({
    required this.id,
    required this.name,
    required this.address,
    required this.status,
  });
}

class _PropertyCard extends StatelessWidget {
  const _PropertyCard({required this.item});
  final _PropertyCardModel item;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;

    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) =>
                  PropertyDetailsScreen(propertyId: item.id, title: item.name),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                height: 56,
                width: 56,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.apartment, size: 28),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: t.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(item.address, style: t.bodySmall),
                    const SizedBox(height: 4),
                    Text(
                      item.status,
                      style: t.labelMedium?.copyWith(
                        color: t.labelMedium?.color?.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios_rounded, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
