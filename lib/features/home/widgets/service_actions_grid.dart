// lib/features/home/widgets/service_actions_grid.dart
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ServiceActionsGrid extends StatelessWidget {
  const ServiceActionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final items = const [
      _ServiceItem('Amenities', Iconsax.home),
      _ServiceItem('New Request', Iconsax.additem),
      _ServiceItem('Home care+', Iconsax.brush_1),
      _ServiceItem('Maintenance', Iconsax.setting_2),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 112,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (_, i) => _ServiceTile(item: items[i], textStyle: t),
    );
  }
}

class _ServiceItem {
  final String title;
  final IconData icon;
  const _ServiceItem(this.title, this.icon);
}

class _ServiceTile extends StatelessWidget {
  const _ServiceTile({required this.item, required this.textStyle});
  final _ServiceItem item;
  final TextTheme textStyle;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Material(
      color: scheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: scheme.outlineVariant),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {
          // TODO: navigate to actual feature
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('${item.title} tapped')));
        },
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // brand chip
              Container(
                height: 34,
                width: 34,
                decoration: BoxDecoration(
                  color: scheme.primary.withOpacity(.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(item.icon, size: 20, color: scheme.primary),
              ),
              const Spacer(),
              Text(
                item.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textStyle.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
