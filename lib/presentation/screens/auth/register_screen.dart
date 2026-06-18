import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../presentation/blocs/auth/auth_bloc.dart';
import '../../../core/theme/app_theme.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _obscurePass = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _passCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(AuthRegisterRequested(
        name: _nameCtrl.text.trim(),
        email: _emailCtrl.text.trim(),
        password: _passCtrl.text,
        phone: _phoneCtrl.text.trim().isNotEmpty ? _phoneCtrl.text.trim() : null,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ott = theme.extension<OttColors>()!;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthOtpRequired) {
          context.go('/auth/otp', extra: {'email': state.email});
        } else if (state is AuthAuthenticated) {
          context.go('/profiles');
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message), backgroundColor: theme.colorScheme.error));
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Create Account'), backgroundColor: Colors.transparent, elevation: 0),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 440),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('Join StreamVault', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text('Create your account to get started', style: theme.textTheme.bodyMedium?.copyWith(color: ott.textSecondary)),
                      const SizedBox(height: 32),
                      TextFormField(
                        controller: _nameCtrl,
                        decoration: const InputDecoration(labelText: 'Full Name', prefixIcon: Icon(Icons.person_outline)),
                        validator: (v) => (v?.trim().length ?? 0) >= 2 ? null : 'Enter your name',
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.email_outlined)),
                        validator: (v) => v?.contains('@') == true ? null : 'Enter a valid email',
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _phoneCtrl,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(labelText: 'Phone (optional)', prefixIcon: Icon(Icons.phone_outlined)),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _passCtrl,
                        obscureText: _obscurePass,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(_obscurePass ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                            onPressed: () => setState(() => _obscurePass = !_obscurePass),
                          ),
                        ),
                        validator: (v) => (v?.length ?? 0) >= 8 ? null : 'Password must be 8+ characters',
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _confirmCtrl,
                        obscureText: _obscureConfirm,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(_obscureConfirm ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                            onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm),
                          ),
                        ),
                        validator: (v) => v == _passCtrl.text ? null : 'Passwords do not match',
                      ),
                      const SizedBox(height: 24),
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (ctx, state) => SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: state is AuthLoading ? null : _submit,
                            child: state is AuthLoading
                                ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                                : const Text('Create Account', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Text('Already have an account?', style: TextStyle(color: ott.textSecondary)),
                        TextButton(onPressed: () => context.go('/auth/login'), child: const Text('Sign In')),
                      ]),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
