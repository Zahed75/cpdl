// lib/features/auth/widgets/login_form.dart
import 'package:flutter/material.dart';

class ULoginForm extends StatefulWidget {
  const ULoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.dbPasswordController,
    required this.isLoading,
    required this.onSubmit,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController dbPasswordController;
  final bool isLoading;
  final VoidCallback onSubmit;

  @override
  State<ULoginForm> createState() => _ULoginFormState();
}

class _ULoginFormState extends State<ULoginForm> {
  bool _obscurePwd = true;
  bool _obscureDb = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Email
        TextFormField(
          controller: widget.emailController,
          enabled: !widget.isLoading,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
            labelText: 'Email',
            hintText: 'you@example.com',
            prefixIcon: Icon(Icons.alternate_email),
          ),
          validator: (v) {
            final value = (v ?? '').trim();
            if (value.isEmpty) return 'Email is required';
            final emailReg = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
            if (!emailReg.hasMatch(value)) return 'Enter a valid email';
            return null;
          },
        ),
        const SizedBox(height: 14),

        // Password
        TextFormField(
          controller: widget.passwordController,
          enabled: !widget.isLoading,
          obscureText: _obscurePwd,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            labelText: 'Password',
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              onPressed: () => setState(() => _obscurePwd = !_obscurePwd),
              icon: Icon(_obscurePwd ? Icons.visibility : Icons.visibility_off),
            ),
          ),
          validator: (v) {
            if ((v ?? '').isEmpty) return 'Password is required';
            if ((v ?? '').length < 6) return 'Minimum 6 characters';
            return null;
          },
        ),
        const SizedBox(height: 14),

        // DB Password (fixed CPDL-123)
        TextFormField(
          controller: widget.dbPasswordController,
          enabled: !widget.isLoading,
          readOnly: true, // fixed as requested
          obscureText: _obscureDb,
          decoration: InputDecoration(
            labelText: 'DB Password',
            helperText: 'Fixed for this build',
            prefixIcon: const Icon(Icons.dangerous),
            suffixIcon: IconButton(
              onPressed: () => setState(() => _obscureDb = !_obscureDb),
              icon: Icon(_obscureDb ? Icons.visibility : Icons.visibility_off),
            ),
          ),
          // No validator needed since it's fixed via controller
          onTap: () {}, // prevents keyboard for some devices when readOnly
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
