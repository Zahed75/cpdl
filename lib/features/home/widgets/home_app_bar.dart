// lib/features/home/widgets/home_header_card.dart
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class HomeHeaderCard extends StatelessWidget {
  const HomeHeaderCard({
    super.key,
    required this.title,
    required this.userName,
    required this.supportInitials,
  });

  final String title;
  final String userName;
  final String supportInitials;

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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Brand tile
            Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                color: scheme.primary.withOpacity(.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Iconsax.buildings, color: scheme.primary, size: 22),
            ),
            const SizedBox(width: 12),

            // Texts (fully flexible => no overflow)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // CPDL chip
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: scheme.primary.withOpacity(.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Iconsax.building_4,
                          size: 14,
                          color: scheme.primary,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'CPDL',
                          style: t.labelSmall?.copyWith(
                            color: scheme.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Title
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: t.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: scheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Subtitle
                  Text(
                    userName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: t.bodyMedium?.copyWith(
                      color: scheme.onSurface.withOpacity(.75),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Quick actions (wrap to avoid overflow on tiny screens)
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: const [
                      _QuickActionChip(
                        icon: Iconsax.ticket,
                        label: 'My Tickets',
                      ),
                      _QuickActionChip(
                        icon: Iconsax.message_question,
                        label: 'Help Center',
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            // Support chip (kept compact; never overflows due to Row spacing)
            _SupportChip(initials: supportInitials),
          ],
        ),
      ),
    );
  }
}

class _QuickActionChip extends StatelessWidget {
  const _QuickActionChip({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final t = Theme.of(context).textTheme;

    return Material(
      color: scheme.surface,
      shape: StadiumBorder(side: BorderSide(color: scheme.outlineVariant)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: scheme.primary),
            const SizedBox(width: 6),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: t.labelMedium?.copyWith(
                color: scheme.onSurface.withOpacity(.9),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SupportChip extends StatelessWidget {
  const _SupportChip({required this.initials});
  final String initials;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final t = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: scheme.primary.withOpacity(.10),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: scheme.primary.withOpacity(.22)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 12,
            backgroundColor: scheme.primary,
            child: Text(
              initials,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'Support',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: t.labelMedium?.copyWith(
              color: scheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
