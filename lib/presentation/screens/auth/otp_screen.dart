import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../presentation/blocs/auth/auth_bloc.dart';
import '../../../core/theme/app_theme.dart';

class OtpScreen extends StatefulWidget {
  final String email;
  const OtpScreen({super.key, required this.email});
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String _otp = '';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ott = theme.extension<OttColors>()!;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          context.go('/profiles');
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message), backgroundColor: theme.colorScheme.error));
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Verify Email'), backgroundColor: Colors.transparent, elevation: 0),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 80, height: 80,
                      decoration: BoxDecoration(shape: BoxShape.circle, color: theme.colorScheme.primary.withOpacity(0.1)),
                      child: Icon(Icons.mark_email_read_outlined, size: 40, color: theme.colorScheme.primary),
                    ),
                    const SizedBox(height: 24),
                    Text('Check your email', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text('We sent a 6-digit code to\n${widget.email}', textAlign: TextAlign.center, style: TextStyle(color: ott.textSecondary)),
                    const SizedBox(height: 40),
                    PinCodeTextField(
                      appContext: context,
                      length: 6,
                      onChanged: (v) => _otp = v,
                      onCompleted: (v) {
                        _otp = v;
                        context.read<AuthBloc>().add(AuthOtpVerifyRequested(email: widget.email, otp: v));
                      },
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(12),
                        fieldHeight: 56,
                        fieldWidth: 48,
                        activeFillColor: ott.surface,
                        inactiveFillColor: ott.surface,
                        selectedFillColor: ott.surface,
                        activeColor: theme.colorScheme.primary,
                        inactiveColor: ott.textSecondary.withOpacity(0.3),
                        selectedColor: theme.colorScheme.primary,
                      ),
                      enableActiveFill: true,
                    ),
                    const SizedBox(height: 24),
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (ctx, state) => SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: state is AuthLoading || _otp.length < 6 ? null : () {
                            ctx.read<AuthBloc>().add(AuthOtpVerifyRequested(email: widget.email, otp: _otp));
                          },
                          child: state is AuthLoading
                              ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                              : const Text('Verify', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () => context.read<AuthBloc>().add(AuthLoginRequested(email: widget.email, password: '')),
                      child: const Text('Resend code'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});
  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() { _emailCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ott = theme.extension<OttColors>()!;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthPasswordResetSent) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text('Reset link sent! Check your email.'),
            backgroundColor: Colors.green,
          ));
          context.go('/auth/login');
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message), backgroundColor: theme.colorScheme.error));
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Reset Password'), backgroundColor: Colors.transparent, elevation: 0),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 32),
                      Text('Forgot Password?', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text("Enter your email and we'll send you a link", textAlign: TextAlign.center, style: TextStyle(color: ott.textSecondary)),
                      const SizedBox(height: 40),
                      TextFormField(
                        controller: _emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.email_outlined)),
                        validator: (v) => v?.contains('@') == true ? null : 'Enter a valid email',
                      ),
                      const SizedBox(height: 24),
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (ctx, state) => SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: state is AuthLoading ? null : () {
                              if (_formKey.currentState!.validate()) {
                                ctx.read<AuthBloc>().add(AuthForgotPasswordRequested(email: _emailCtrl.text.trim()));
                              }
                            },
                            child: state is AuthLoading
                                ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                                : const Text('Send Reset Link', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ),
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
