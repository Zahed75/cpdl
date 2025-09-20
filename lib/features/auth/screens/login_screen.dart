// lib/features/authentication/screens/login/login.dart
import 'package:cpdl/features/auth/widgets/login_form.dart';
import 'package:cpdl/features/auth/widgets/login_header.dart';
import 'package:cpdl/features/auth/widgets/remember_me.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // 👈 using go_router

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtrl = TextEditingController();
  final _pwdCtrl = TextEditingController();
  final _dbPwdCtrl = TextEditingController(text: 'CPDL-123');

  bool _rememberMe = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _pwdCtrl.dispose();
    _dbPwdCtrl.dispose();
    super.dispose();
  }

  Future<void> _tryLogin() async {
    setState(() => _isLoading = true);

    // Simulate login delay
    await Future.delayed(const Duration(milliseconds: 500));

    if (!mounted) return;
    setState(() => _isLoading = false);

    // ✅ Navigate directly to home (replace with your route)
    context.go('/home');
  }

  void _onForgotPassword() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Forgot Password tapped (UI only)')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  Center(
                    child: Image.asset(
                      'assets/logo/cpdl_logo.png',
                      height: 80,
                      width: 80,
                    ),
                  ),
                  const SizedBox(height: 28),

                  const ULoginHeader(),
                  const SizedBox(height: 28),

                  ULoginForm(
                    emailController: _emailCtrl,
                    passwordController: _pwdCtrl,
                    dbPasswordController: _dbPwdCtrl,
                    isLoading: _isLoading,
                    onSubmit: () {},
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [
                      URememberMeCheckbox(
                        value: _rememberMe,
                        onChanged: (val) =>
                            setState(() => _rememberMe = val ?? false),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: _isLoading ? null : _onForgotPassword,
                        child: const Text('Forgot Password'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Primary CTA
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _tryLogin,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(56),
                        shape: const StadiumBorder(),
                        elevation: 2,
                        shadowColor: theme.colorScheme.primary.withValues(
                          alpha: 0.35,
                        ),
                        textStyle: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation(
                                  Colors.white,
                                ),
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Text('Sign In'),
                                SizedBox(width: 8),
                                Icon(Icons.arrow_forward_rounded, size: 22),
                              ],
                            ),
                    ),
                  ),

                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      'v1.0.0 • Build 1',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.5,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
