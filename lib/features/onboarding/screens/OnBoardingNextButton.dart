// lib/features/onBoarding/widgets/onboarding_next_button.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/constants/sizes.dart';
import '../notifier/onboarding_notifier.dart';

class OnBoardingNextButton extends ConsumerWidget {
  const OnBoardingNextButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboardingState = ref.watch(onboardingNotifierProvider);

    return Positioned(
      bottom: USizes.spaceBtwItems * 4,
      right: 16, // move it to the right side
      child: IconButton(
        style: IconButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(12),
        ),
        icon: Icon(
          onboardingState.isLastPage
              ? Icons
                    .check // show ✔ when last page
              : Icons.arrow_forward, // arrow otherwise
        ),
        onPressed: () {
          ref.read(onboardingNotifierProvider.notifier).nextPage(context);
        },
      ),
    );
  }
}
