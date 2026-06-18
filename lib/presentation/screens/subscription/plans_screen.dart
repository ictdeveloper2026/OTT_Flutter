import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../presentation/blocs/subscription/subscription_bloc.dart';
import '../../../data/models/content.dart';
import '../../../core/theme/app_theme.dart';

class PlansScreen extends StatefulWidget {
  const PlansScreen({super.key});
  @override
  State<PlansScreen> createState() => _PlansScreenState();
}

class _PlansScreenState extends State<PlansScreen> {
  String? _selectedPlanId;

  @override
  void initState() {
    super.initState();
    context.read<SubscriptionBloc>().add(SubscriptionPlansLoaded());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ott = theme.extension<OttColors>()!;
    return Scaffold(
      appBar: AppBar(title: const Text('Choose a Plan'), backgroundColor: Colors.transparent, elevation: 0),
      body: BlocConsumer<SubscriptionBloc, SubscriptionState>(
        listener: (context, state) {
          if (state is SubscriptionPaymentReady) {
            context.go('/checkout/${state.planId}', extra: state.order);
          } else if (state is SubscriptionError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message), backgroundColor: theme.colorScheme.error));
          }
        },
        builder: (context, state) {
          if (state is SubscriptionLoading) return const Center(child: CircularProgressIndicator());
          if (state is SubscriptionPlansReady) return _buildPlans(context, state.plans, state.current, theme, ott);
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildPlans(BuildContext context, List<SubscriptionPlan> plans, UserSubscription? current, ThemeData theme, OttColors ott) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Hero section
          Text('Unlimited entertainment\nstarts here', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
          const SizedBox(height: 8),
          Text('HD, 4K Ultra HD, Dolby Audio', textAlign: TextAlign.center, style: TextStyle(color: ott.textSecondary)),
          const SizedBox(height: 32),
          // Feature comparison row
          _FeatureRow(features: const ['HD Video', '4K Ultra HD', 'Downloads', 'Screens']),
          const SizedBox(height: 16),
          ...plans.map((plan) => _PlanCard(
            plan: plan,
            isSelected: _selectedPlanId == plan.id,
            isCurrent: current?.planId == plan.id,
            onTap: () => setState(() => _selectedPlanId = plan.id),
          )),
          const SizedBox(height: 32),
          if (_selectedPlanId != null) ...[
            ElevatedButton(
              onPressed: () => context.read<SubscriptionBloc>().add(SubscriptionInitiated(planId: _selectedPlanId!)),
              style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(52)),
              child: const Text('Continue', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            ),
            const SizedBox(height: 12),
            Text('Cancel anytime. No commitment.', textAlign: TextAlign.center, style: TextStyle(color: ott.textSecondary, fontSize: 12)),
          ],
        ],
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  final List<String> features;
  const _FeatureRow({required this.features});

  @override
  Widget build(BuildContext context) {
    final ott = Theme.of(context).extension<OttColors>()!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: features.map((f) => Column(
        children: [
          Icon(Icons.check_circle, color: Theme.of(context).colorScheme.primary, size: 20),
          const SizedBox(height: 4),
          Text(f, style: TextStyle(fontSize: 11, color: ott.textSecondary)),
        ],
      )).toList(),
    );
  }
}

class _PlanCard extends StatelessWidget {
  final SubscriptionPlan plan;
  final bool isSelected;
  final bool isCurrent;
  final VoidCallback onTap;

  const _PlanCard({required this.plan, required this.isSelected, required this.isCurrent, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ott = theme.extension<OttColors>()!;
    final isRecommended = plan.name.toLowerCase().contains('premium') || plan.isPopular == true;
    return GestureDetector(
      onTap: isCurrent ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: isSelected ? theme.colorScheme.primary.withOpacity(0.1) : ott.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? theme.colorScheme.primary : ott.surface,
            width: 2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Text(plan.name, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              const Spacer(),
              if (isRecommended)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(color: theme.colorScheme.primary, borderRadius: BorderRadius.circular(20)),
                  child: const Text('POPULAR', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                ),
              if (isCurrent)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(20)),
                  child: const Text('ACTIVE', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                ),
            ]),
            const SizedBox(height: 8),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: '₹${plan.price.toStringAsFixed(0)}', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: theme.colorScheme.primary)),
                  TextSpan(text: ' / ${plan.intervalMonths == 1 ? 'month' : '${plan.intervalMonths}mo'}', style: TextStyle(color: ott.textSecondary)),
                ],
              ),
            ),
            if (plan.description != null) ...[
              const SizedBox(height: 6),
              Text(plan.description!, style: TextStyle(color: ott.textSecondary, fontSize: 13)),
            ],
            if (plan.features != null && plan.features!.isNotEmpty) ...[
              const SizedBox(height: 10),
              ...plan.features!.take(3).map((f) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(children: [
                  Icon(Icons.check, size: 16, color: theme.colorScheme.primary),
                  const SizedBox(width: 6),
                  Text(f, style: const TextStyle(fontSize: 13)),
                ]),
              )),
            ],
          ],
        ),
      ),
    );
  }
}
