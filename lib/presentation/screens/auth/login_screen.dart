import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../presentation/blocs/auth/auth_bloc.dart';
import '../../../core/theme/app_theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(AuthLoginRequested(email: _emailCtrl.text.trim(), password: _passCtrl.text));
    }
  }

  Future<void> _googleSignIn() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      final auth = await googleUser?.authentication;
      if (auth?.idToken != null) {
        if (mounted) {
          context.read<AuthBloc>().add(AuthSocialLoginRequested(provider: 'google', token: auth!.idToken!));
        }
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ott = theme.extension<OttColors>()!;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          context.go('/profiles');
        } else if (state is AuthOtpRequired) {
          context.go('/auth/otp', extra: {'email': state.email});
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message), backgroundColor: theme.colorScheme.error));
        }
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [ott.surface, theme.scaffoldBackgroundColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 440),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 32),
                      // Logo
                      Center(
                        child: Container(
                          width: 72,
                          height: 72,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            gradient: LinearGradient(colors: [theme.colorScheme.primary, theme.colorScheme.secondary]),
                          ),
                          child: const Icon(Icons.play_circle_fill, color: Colors.white, size: 40),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Text('Welcome back', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text('Sign in to continue watching', style: theme.textTheme.bodyMedium?.copyWith(color: ott.textSecondary)),
                      const SizedBox(height: 32),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _emailCtrl,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.email_outlined)),
                              validator: (v) => v?.contains('@') == true ? null : 'Enter a valid email',
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _passCtrl,
                              obscureText: _obscure,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                prefixIcon: const Icon(Icons.lock_outline),
                                suffixIcon: IconButton(
                                  icon: Icon(_obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                                  onPressed: () => setState(() => _obscure = !_obscure),
                                ),
                              ),
                              validator: (v) => (v?.length ?? 0) >= 6 ? null : 'Password must be 6+ characters',
                            ),
                            const SizedBox(height: 8),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () => context.go('/auth/forgot-password'),
                                child: const Text('Forgot password?'),
                              ),
                            ),
                            const SizedBox(height: 16),
                            BlocBuilder<AuthBloc, AuthState>(
                              builder: (ctx, state) => SizedBox(
                                width: double.infinity,
                                height: 52,
                                child: ElevatedButton(
                                  onPressed: state is AuthLoading ? null : _submit,
                                  child: state is AuthLoading
                                      ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                                      : const Text('Sign In', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(children: [
                        Expanded(child: Divider(color: ott.textSecondary.withOpacity(0.3))),
                        Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: Text('or', style: TextStyle(color: ott.textSecondary))),
                        Expanded(child: Divider(color: ott.textSecondary.withOpacity(0.3))),
                      ]),
                      const SizedBox(height: 24),
                      // Social login
                      OutlinedButton.icon(
                        onPressed: _googleSignIn,
                        icon: Image.network('https://www.gstatic.com/firebasejs/ui/2.0.0/images/auth/google.svg', width: 20, height: 20),
                        label: const Text('Continue with Google'),
                        style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(52)),
                      ),
                      const SizedBox(height: 12),
                      OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.apple, size: 22),
                        label: const Text('Continue with Apple'),
                        style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(52)),
                      ),
                      const SizedBox(height: 32),
                      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Text("Don't have an account?", style: TextStyle(color: ott.textSecondary)),
                        TextButton(
                          onPressed: () => context.go('/auth/register'),
                          child: const Text('Sign Up'),
                        ),
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
