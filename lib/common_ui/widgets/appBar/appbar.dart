// lib/common_ui/appbar/u_primary_app_bar.dart
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

/// A reusable CPDL app bar with a teal background, rounded bottom,
/// optional subtitle, and an optional trailing support chip.
/// Use on any screen via `appBar: UPrimaryAppBar(...)`.
class UPrimaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  const UPrimaryAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.showSupport = true,
    this.onSupportTap,
    this.toolbarHeight = 96,
    this.bottom,
  });

  final String title;
  final String? subtitle;
  final bool showSupport;
  final VoidCallback? onSupportTap;
  final double toolbarHeight;
  final PreferredSizeWidget? bottom;

  @override
  Size get preferredSize =>
      Size.fromHeight(toolbarHeight + (bottom?.preferredSize.height ?? 0));

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final t = Theme.of(context).textTheme;
    final onPrimary = scheme.onPrimary; // ensures readable text on teal

    return AppBar(
      elevation: 0,
      backgroundColor: scheme.primary,
      surfaceTintColor: Colors.transparent,
      toolbarHeight: toolbarHeight,
      centerTitle: false,
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      titleSpacing: 16,
      title: Row(
        children: [
          // Brand icon tile
          Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              color: onPrimary.withOpacity(.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Iconsax.buildings, color: onPrimary, size: 22),
          ),
          const SizedBox(width: 12),

          // Title + subtitle (expand to avoid overflow)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: t.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: onPrimary,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: t.bodyMedium?.copyWith(
                      color: onPrimary.withOpacity(.9),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Support chip (optional)
          if (showSupport) ...[
            const SizedBox(width: 8),
            _SupportChip(onPrimary: onPrimary, onTap: onSupportTap),
          ],
        ],
      ),
      bottom: bottom,
    );
  }
}

class _SupportChip extends StatelessWidget {
  const _SupportChip({required this.onPrimary, this.onTap});
  final Color onPrimary;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: onPrimary.withOpacity(.12),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: onPrimary.withOpacity(.25)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 12,
              backgroundColor: onPrimary,
              child: const Text(
                'WP',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'Support',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: onPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
