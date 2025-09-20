// lib/app/navigation/tab_nav.dart
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../features/home/screens/home_screen.dart';
import '../../features/requests/screens/requests_screen.dart';
import '../../features/community/screens/community_screen.dart';
import '../../features/notifications/screens/notifications_screen.dart';

class TabNav extends StatefulWidget {
  const TabNav({super.key});

  @override
  State<TabNav> createState() => _TabNavState();
}

class _TabNavState extends State<TabNav> {
  int _index = 0;

  final _pages = const [
    HomeScreen(),
    RequestsScreen(),
    CommunityScreen(),
    NotificationsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final media = MediaQuery.of(context);

    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          IndexedStack(index: _index, children: _pages),

          // Floating frosted nav
          Positioned(
            left: 12,
            right: 12,
            bottom: media.padding.bottom + 12,
            child: LayoutBuilder(
              builder: (context, constraints) {
                // Switch to compact (icons-only) if width is tight
                final isCompact = constraints.maxWidth < 360;

                return _FrostedNavBar(
                  height: isCompact ? 62 : 70,
                  blurSigma: 18,
                  background: scheme.surface.withOpacity(0.5),
                  borderColor: scheme.outlineVariant.withOpacity(0.55),
                  items: const [
                    _NavItem('Home', Iconsax.home, Iconsax.home_15),
                    _NavItem(
                      'Request',
                      Iconsax.task_square,
                      Iconsax.task_square5,
                    ),
                    _NavItem(
                      'Community',
                      Iconsax.profile_2user,
                      Iconsax.profile_2user5,
                    ),
                    _NavItem(
                      'Notification',
                      Iconsax.notification,
                      Iconsax.notification5,
                    ),
                  ],
                  currentIndex: _index,
                  isCompact: isCompact,
                  onChanged: (i) => setState(() => _index = i),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _FrostedNavBar extends StatelessWidget {
  const _FrostedNavBar({
    required this.items,
    required this.currentIndex,
    required this.onChanged,
    required this.height,
    required this.background,
    required this.borderColor,
    required this.isCompact,
    this.blurSigma = 14,
  });

  final List<_NavItem> items;
  final int currentIndex;
  final ValueChanged<int> onChanged;
  final double height;
  final Color background;
  final Color borderColor;
  final double blurSigma;
  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
        child: Container(
          height: height,
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: borderColor, width: 1),
            boxShadow: [
              BoxShadow(
                color: scheme.shadow.withOpacity(0.06),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Row(
            children: List.generate(items.length, (i) {
              final selected = i == currentIndex;
              return Expanded(
                child: _FrostedNavButton(
                  item: items[i],
                  selected: selected,
                  isCompact: isCompact,
                  onTap: () => onChanged(i),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _FrostedNavButton extends StatelessWidget {
  const _FrostedNavButton({
    required this.item,
    required this.selected,
    required this.onTap,
    required this.isCompact,
  });

  final _NavItem item;
  final bool selected;
  final bool isCompact;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final labelStyle = Theme.of(context).textTheme.labelMedium;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        height: 46,
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        padding: EdgeInsets.symmetric(horizontal: isCompact ? 0 : 10),
        decoration: BoxDecoration(
          color: selected
              ? scheme.primary.withOpacity(0.12)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              selected ? item.selectedIcon : item.icon,
              size: 22,
              color: selected
                  ? scheme.primary
                  : scheme.onSurface.withOpacity(.75),
            ),
            if (!isCompact) ...[
              const SizedBox(width: 6),
              // Constrain text so it never overflows
              Flexible(
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 180),
                  style:
                      (labelStyle ??
                              const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ))
                          .copyWith(
                            color: selected
                                ? scheme.primary
                                : scheme.onSurface.withOpacity(.8),
                            fontWeight: selected
                                ? FontWeight.w700
                                : FontWeight.w600,
                          ),
                  child: Text(
                    item.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _NavItem {
  final String label;
  final IconData icon;
  final IconData selectedIcon;
  const _NavItem(this.label, this.icon, this.selectedIcon);
}
