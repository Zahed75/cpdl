// lib/features/home/widgets/service_actions_grid.dart
import 'package:cpdl/features/requests/screens/service_request_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ServiceActionsGrid extends StatelessWidget {
  const ServiceActionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final items = const [
      _ServiceItem('Amenities', Iconsax.home),
      _ServiceItem('New Request', Iconsax.additem),
      _ServiceItem('Home care+', Iconsax.brush_1),
      _ServiceItem('Maintenance', Iconsax.setting_2),
    ];

    void _handleTap(_ServiceItem item) {
      if (item.title == 'New Request') {
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => const ServiceRequestScreen()));
        return;
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('${item.title} tapped')));
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 128, // a bit taller for breathing room
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (_, i) =>
          _ServiceTile(item: items[i], onTap: () => _handleTap(items[i])),
    );
  }
}

class _ServiceItem {
  final String title;
  final IconData icon;
  const _ServiceItem(this.title, this.icon);
}

class _ServiceTile extends StatelessWidget {
  const _ServiceTile({required this.item, required this.onTap});
  final _ServiceItem item;
  final VoidCallback onTap;

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
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Teal icon chip (calm, rounded)
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: scheme.primary.withOpacity(.10),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(item.icon, size: 22, color: scheme.primary),
              ),
              const Spacer(),
              Text(
                item.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: t.titleSmall?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 2),
              Text(
                'Tap to continue',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: t.labelSmall?.copyWith(
                  color: scheme.onSurface.withOpacity(.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
