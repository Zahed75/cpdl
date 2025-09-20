// lib/features/requests/screens/service_request_screen.dart
import 'package:cpdl/features/requests/widgets/service_request_form.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:cpdl/common_ui/widgets/appBar/appbar.dart';

class ServiceRequestScreen extends StatelessWidget {
  const ServiceRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UPrimaryAppBar(
        title: 'New Request',
        subtitle: 'Tell us what’s wrong',
        showSupport: false,
        toolbarHeight: 88,
      ),
      body: const SafeArea(child: ServiceRequestForm()),
    );
  }
}
