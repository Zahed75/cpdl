// lib/features/requests/widgets/service_request_form.dart
import 'dart:io';
import 'package:cpdl/utils/theme/widgets_theme/button_theme.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

class ServiceRequestForm extends StatefulWidget {
  const ServiceRequestForm({super.key});

  @override
  State<ServiceRequestForm> createState() => _ServiceRequestFormState();
}

class _ServiceRequestFormState extends State<ServiceRequestForm> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _descriptionCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController(text: '01XXXXXXXXX');

  // Selections
  String? _property;
  String? _category;
  String? _priority = 'Normal';
  DateTime? _preferredDate;
  TimeOfDay? _preferredTime;
  bool _allowCall = true;

  // Attachments
  final ImagePicker _picker = ImagePicker();
  final List<XFile> _images = [];

  @override
  void dispose() {
    _descriptionCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final file = await _picker.pickImage(source: source, imageQuality: 75);
    if (file != null) {
      setState(() => _images.add(file));
    }
  }

  Future<void> _pickDate() async {
    final today = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: today.add(const Duration(days: 1)),
      firstDate: today,
      lastDate: today.add(const Duration(days: 60)),
    );
    if (picked != null) setState(() => _preferredDate = picked);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 10, minute: 0),
    );
    if (picked != null) setState(() => _preferredTime = picked);
  }

  void _submit() {
    // Light validation: ensure key fields present
    if (_property == null ||
        _category == null ||
        _descriptionCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill property, category, and description'),
        ),
      );
      return;
    }

    // You can replace this with Riverpod + Dio later.
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Request submitted!')));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final pad = const EdgeInsets.symmetric(horizontal: 16, vertical: 12);
    final scheme = Theme.of(context).colorScheme;
    final t = Theme.of(context).textTheme;

    final properties = const [
      'Lake View Apartment — P-1001',
      'Green Residency — P-1002',
      'City Breeze — P-1003',
    ];
    final categories = const [
      'Plumbing',
      'Electrical',
      'Appliances',
      'HVAC',
      'Water Heater / Geyser',
      'Carpentry',
      'Cleaning',
      'Other',
    ];
    final priorities = const ['Low', 'Normal', 'High', 'Emergency'];

    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        // Card: What & Where
        Padding(
          padding: pad,
          child: _SectionCard(
            title: 'Request details',
            child: Column(
              children: [
                _DropdownField<String>(
                  label: 'Select Property',
                  value: _property,
                  items: properties,
                  icon: Iconsax.buildings,
                  onChanged: (v) => setState(() => _property = v),
                ),
                const SizedBox(height: 12),
                _DropdownField<String>(
                  label: 'Category',
                  value: _category,
                  items: categories,
                  icon: Iconsax.setting_4,
                  onChanged: (v) => setState(() => _category = v),
                ),
                const SizedBox(height: 12),
                _DropdownField<String>(
                  label: 'Priority',
                  value: _priority,
                  items: priorities,
                  icon: Iconsax.flash_15,
                  onChanged: (v) => setState(() => _priority = v),
                ),
                const SizedBox(height: 12),
                _MultilineField(
                  controller: _descriptionCtrl,
                  label: 'Describe the issue',
                  hint:
                      'e.g., Geyser not heating since last night. Water pressure seems low.',
                ),
              ],
            ),
          ),
        ),

        // Card: Schedule & Contact
        Padding(
          padding: pad,
          child: _SectionCard(
            title: 'Schedule & contact',
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _PickerField(
                        label: 'Preferred Date',
                        icon: Iconsax.calendar_1,
                        valueText: _preferredDate == null
                            ? 'Select'
                            : '${_preferredDate!.year}-${_preferredDate!.month.toString().padLeft(2, '0')}-${_preferredDate!.day.toString().padLeft(2, '0')}',
                        onTap: _pickDate,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _PickerField(
                        label: 'Preferred Time',
                        icon: Iconsax.clock,
                        valueText: _preferredTime == null
                            ? 'Select'
                            : '${_preferredTime!.hour.toString().padLeft(2, '0')}:${_preferredTime!.minute.toString().padLeft(2, '0')}',
                        onTap: _pickTime,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _TextField(
                  controller: _phoneCtrl,
                  label: 'Contact Number',
                  keyboardType: TextInputType.phone,
                  icon: Iconsax.call,
                ),
                const SizedBox(height: 8),
                SwitchListTile.adaptive(
                  contentPadding: EdgeInsets.zero,
                  value: _allowCall,
                  onChanged: (v) => setState(() => _allowCall = v),
                  title: const Text('Allow technician to call me'),
                ),
              ],
            ),
          ),
        ),

        // Card: Photos
        Padding(
          padding: pad,
          child: _SectionCard(
            title: 'Photos (optional)',
            trailing: Text('${_images.length}/4', style: t.labelMedium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final img in _images)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          File(img.path),
                          width: 76,
                          height: 76,
                          fit: BoxFit.cover,
                        ),
                      ),
                    if (_images.length < 4)
                      _AddPhotoTile(
                        onCamera: () => _pickImage(ImageSource.camera),
                        onGallery: () => _pickImage(ImageSource.gallery),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: PrimaryButton(
            label: 'Submit Request',
            icon: Iconsax.send_2,
            onPressed: _submit,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

/// ---------- Little building blocks (Airbnb-like solids, no glass) ----------
class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.child, this.trailing});

  final String title;
  final Widget child;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final t = Theme.of(context).textTheme;

    return Material(
      color: scheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: scheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: t.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                if (trailing != null) trailing!,
              ],
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}

class _DropdownField<T> extends StatelessWidget {
  const _DropdownField({
    required this.label,
    required this.value,
    required this.items,
    required this.icon,
    required this.onChanged,
  });

  final String label;
  final T? value;
  final List<T> items;
  final IconData icon;
  final ValueChanged<T?> onChanged;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return DropdownButtonFormField<T>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: scheme.primary),
        border: const OutlineInputBorder(),
      ),
      items: items
          .map((e) => DropdownMenuItem<T>(value: e, child: Text(e.toString())))
          .toList(),
      onChanged: onChanged,
    );
  }
}

class _TextField extends StatelessWidget {
  const _TextField({
    required this.controller,
    required this.label,
    this.icon,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String label;
  final IconData? icon;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: icon != null ? Icon(icon) : null,
        border: const OutlineInputBorder(),
      ),
    );
  }
}

class _MultilineField extends StatelessWidget {
  const _MultilineField({
    required this.controller,
    required this.label,
    required this.hint,
  });

  final TextEditingController controller;
  final String label;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      minLines: 3,
      maxLines: 6,
      decoration: InputDecoration(
        labelText: label,
        alignLabelWithHint: true,
        hintText: hint,
        border: const OutlineInputBorder(),
      ),
    );
  }
}

class _PickerField extends StatelessWidget {
  const _PickerField({
    required this.label,
    required this.icon,
    required this.valueText,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final String valueText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: scheme.primary),
          border: const OutlineInputBorder(),
        ),
        child: Text(valueText),
      ),
    );
  }
}

class _AddPhotoTile extends StatelessWidget {
  const _AddPhotoTile({required this.onCamera, required this.onGallery});
  final VoidCallback onCamera;
  final VoidCallback onGallery;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      width: 76,
      height: 76,
      decoration: BoxDecoration(
        color: scheme.surface,
        border: Border.all(color: scheme.outlineVariant),
        borderRadius: BorderRadius.circular(10),
      ),
      child: PopupMenuButton<String>(
        tooltip: 'Add photo',
        onSelected: (v) {
          if (v == 'camera') onCamera();
          if (v == 'gallery') onGallery();
        },
        itemBuilder: (_) => const [
          PopupMenuItem(value: 'camera', child: Text('Take photo')),
          PopupMenuItem(value: 'gallery', child: Text('Choose from gallery')),
        ],
        child: Icon(Iconsax.image, color: scheme.primary),
      ),
    );
  }
}
