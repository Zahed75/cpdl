// lib/features/home/widgets/my_properties_section.dart
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
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
          separatorBuilder: (_, __) => const SizedBox(height: 12),
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
    final scheme = Theme.of(context).colorScheme;
    final t = Theme.of(context).textTheme;

    return Material(
      color: scheme.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: scheme.outlineVariant),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) =>
                  PropertyDetailsScreen(propertyId: item.id, title: item.name),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top image banner (Airbnb-ish). Replace with real image later.
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Container(
                height: 140,
                color: scheme.surfaceVariant, // placeholder surface
                alignment: Alignment.center,
                child: Icon(
                  Iconsax.building_4,
                  size: 40,
                  color: scheme.onSurface.withOpacity(.35),
                ),
              ),
            ),

            // Text content
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Small stacked id + status pill
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: scheme.primary.withOpacity(.10),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          item.id,
                          style: t.labelSmall?.copyWith(
                            color: scheme.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
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
                          style: t.labelSmall?.copyWith(
                            color: scheme.secondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 12),

                  // Main details (flex to avoid overflow)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: t.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.address,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: t.bodySmall?.copyWith(
                            color: scheme.onSurface.withOpacity(.75),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(
                              Iconsax.calendar_1,
                              size: 16,
                              color: scheme.onSurface.withOpacity(.7),
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                item.status,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: t.labelMedium?.copyWith(
                                  color: scheme.onSurface.withOpacity(.7),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 8),
                  Icon(
                    Iconsax.arrow_right_3,
                    size: 20,
                    color: scheme.onSurface.withOpacity(.55),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
