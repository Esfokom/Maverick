import 'package:flutter/material.dart';
import 'package:maverick/features/auth/widgets/auth_header.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _passwordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final form = _formKey.currentState;
    if (form == null) return;
    if (!form.validate()) return;

    setState(() => _isLoading = true);

    try {
      // Simulate network request
      await Future.delayed(const Duration(seconds: 2));

      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not sign in. Please try again.'),
          backgroundColor: Colors.red.shade600,
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  InputDecoration _decoration({
    required String label,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: label,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const AuthHeader(subtitle: 'Welcome back'),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: _emailController,
                        enabled: !_isLoading,
                        keyboardType: TextInputType.emailAddress,
                        autofillHints: const [
                          AutofillHints.username,
                          AutofillHints.email,
                        ],
                        validator: (value) {
                          final v = value?.trim() ?? '';
                          if (v.isEmpty) return 'Email is required';
                          final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                          if (!emailRegex.hasMatch(v))
                            return 'Enter a valid email address';
                          return null;
                        },
                        decoration: _decoration(
                          label: 'Email address',
                          prefixIcon: const Icon(Icons.email_outlined),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _passwordController,
                        enabled: !_isLoading,
                        obscureText: !_passwordVisible,
                        autofillHints: const [AutofillHints.password],
                        validator: (value) {
                          final v = value ?? '';
                          if (v.isEmpty) return 'Password is required';
                          if (v.length < 6)
                            return 'Password must be at least 6 characters';
                          return null;
                        },
                        decoration: _decoration(
                          label: 'Password',
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            onPressed: () => setState(
                              () => _passwordVisible = !_passwordVisible,
                            ),
                            icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            tooltip: _passwordVisible
                                ? 'Hide password'
                                : 'Show password',
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: _isLoading
                              ? null
                              : () => Navigator.pushNamed(
                                  context,
                                  '/forgot-password',
                                ),
                          child: const Text('Forgot password?'),
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _login,
                          child: _isLoading
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.4,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    Text('Signing in...'),
                                  ],
                                )
                              : const Text('Sign In'),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(child: Divider(color: theme.dividerColor)),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text('OR'),
                          ),
                          Expanded(child: Divider(color: theme.dividerColor)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 48,
                        child: OutlinedButton.icon(
                          icon: const Image(
                            image: AssetImage('images/Google_Icon.png'),
                            height: 20,
                          ),
                          label: const Text('Sign in with Google'),
                          onPressed: _isLoading ? null : () {},
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account? "),
                          TextButton(
                            onPressed: _isLoading
                                ? null
                                : () => Navigator.pushNamed(context, '/signup'),
                            child: const Text('Sign Up'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (_isLoading)
              Positioned.fill(
                child: IgnorePointer(
                  ignoring: true,
                  child: Container(color: Colors.black.withOpacity(0.04)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
