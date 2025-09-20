// lib/features/home/widgets/properties_horizontal_list.dart
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../property/screens/property_details_screen.dart';

class PropertiesHorizontalList extends StatelessWidget {
  const PropertiesHorizontalList({super.key});

  @override
  Widget build(BuildContext context) {
    final items = const [
      _PropertyCardModel(
        id: 'P-1001',
        name: 'Lake View Apartment',
        address: 'Road 12, Banani',
        status: 'Handover: Nov 2025',
      ),
      _PropertyCardModel(
        id: 'P-1002',
        name: 'Green Residency',
        address: 'Sector 4, Uttara',
        status: 'Handover: Jan 2026',
      ),
      _PropertyCardModel(
        id: 'P-1003',
        name: 'City Breeze',
        address: 'Dhanmondi',
        status: 'Handover: Mar 2026',
      ),
    ];

    return SizedBox(
      height: 152,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, i) => _PropertyCard(item: items[i]),
      ),
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
    final scheme = Theme.of(context).colorScheme;
    final t = Theme.of(context).textTheme;

    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) =>
                PropertyDetailsScreen(propertyId: item.id, title: item.name),
          ),
        );
      },
      child: Ink(
        width: 260,
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: scheme.outlineVariant),
          boxShadow: [
            BoxShadow(
              color: scheme.shadow.withOpacity(.05),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // top row
            Row(
              children: [
                Container(
                  height: 34,
                  width: 34,
                  decoration: BoxDecoration(
                    color: scheme.primary.withOpacity(.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Iconsax.home_25, color: scheme.primary, size: 18),
                ),
                const SizedBox(width: 10),
                Text(item.id, style: t.labelMedium),
                const Spacer(),
                // status pill
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: scheme.secondary.withOpacity(.12),
                    borderRadius: BorderRadius.circular(99),
                    border: Border.all(
                      color: scheme.secondary.withOpacity(.22),
                    ),
                  ),
                  child: Text(
                    'Active',
                    style: t.labelSmall?.copyWith(color: scheme.secondary),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              item.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: t.titleSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 2),
            Text(
              item.address,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: t.bodySmall?.copyWith(
                color: scheme.onSurface.withOpacity(.7),
              ),
            ),
            const SizedBox(height: 2),
            Text(item.status, style: t.labelSmall),
          ],
        ),
      ),
    );
  }
}
