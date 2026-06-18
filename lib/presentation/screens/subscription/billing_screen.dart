import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../blocs/subscription/subscription_bloc.dart';
import '../../blocs/subscription/subscription_event.dart';
import '../../blocs/subscription/subscription_state.dart';

class BillingScreen extends StatefulWidget {
  const BillingScreen({super.key});

  @override
  State<BillingScreen> createState() => _BillingScreenState();
}

class _BillingScreenState extends State<BillingScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SubscriptionBloc>().add(LoadPaymentHistoryEvent());
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OttColors>()!;
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.surface,
        title: Text('Billing & Payments', style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.bold)),
        leading: IconButton(icon: Icon(Icons.arrow_back, color: colors.textPrimary), onPressed: () => context.pop()),
        elevation: 0,
      ),
      body: BlocBuilder<SubscriptionBloc, SubscriptionState>(
        builder: (context, state) {
          if (state is SubscriptionLoading) {
            return Center(child: CircularProgressIndicator(color: colors.primary));
          }
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _buildActiveSubCard(colors, state)),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
                  child: Text('Payment History',
                      style: TextStyle(color: colors.textPrimary, fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
              _buildPaymentList(colors, state),
            ],
          );
        },
      ),
    );
  }

  Widget _buildActiveSubCard(OttColors colors, SubscriptionState state) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colors.primary, colors.primary.withRed(160)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.verified, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              const Text('Active Subscription', style: TextStyle(color: Colors.white70, fontSize: 13)),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text('ACTIVE', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text('Premium Plan', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          const Text('₹499/month · Auto-renews on Jul 12, 2026',
              style: TextStyle(color: Colors.white70, fontSize: 13)),
          const SizedBox(height: 16),
          Row(
            children: [
              _whiteChip(Icons.hd, '4K UHD'),
              const SizedBox(width: 8),
              _whiteChip(Icons.group, '5 Profiles'),
              const SizedBox(width: 8),
              _whiteChip(Icons.download, 'Downloads'),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text('Change Plan', style: TextStyle(color: Colors.white, fontSize: 13)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _confirmCancel(context),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.white.withOpacity(0.5)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text('Cancel', style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 13)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _whiteChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, color: Colors.white, size: 12),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 11)),
      ]),
    );
  }

  Widget _buildPaymentList(OttColors colors, SubscriptionState state) {
    final payments = state is PaymentHistoryLoaded ? state.payments : _mockPayments;

    if (payments.isEmpty) {
      return SliverFillRemaining(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(Icons.receipt_long_outlined, size: 64, color: colors.textSecondary),
            const SizedBox(height: 12),
            Text('No payment history', style: TextStyle(color: colors.textSecondary)),
          ]),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, i) => _buildPaymentTile(payments[i], colors),
        childCount: payments.length,
      ),
    );
  }

  Widget _buildPaymentTile(Map<String, dynamic> payment, OttColors colors) {
    final isSuccess = payment['status'] == 'success';
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: colors.surface, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isSuccess ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isSuccess ? Icons.check : Icons.close,
              color: isSuccess ? Colors.green : Colors.red,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(payment['description'] ?? 'Subscription', style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.w500, fontSize: 14)),
              Text('${payment['gateway']} · ${payment['date']}', style: TextStyle(color: colors.textSecondary, fontSize: 12)),
            ]),
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text('₹${payment['amount']}',
                style: TextStyle(color: isSuccess ? Colors.green : Colors.red, fontWeight: FontWeight.bold)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: isSuccess ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                isSuccess ? 'Success' : 'Failed',
                style: TextStyle(color: isSuccess ? Colors.green : Colors.red, fontSize: 10),
              ),
            ),
          ]),
        ],
      ),
    );
  }

  void _confirmCancel(BuildContext context) {
    final colors = Theme.of(context).extension<OttColors>()!;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: colors.surface,
        title: Text('Cancel Subscription?', style: TextStyle(color: colors.textPrimary)),
        content: Text('You will continue to have access until your billing period ends.',
            style: TextStyle(color: colors.textSecondary)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Keep Plan', style: TextStyle(color: colors.primary))),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<SubscriptionBloc>().add(CancelSubscriptionEvent());
            },
            child: const Text('Cancel Plan', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  final List<Map<String, dynamic>> _mockPayments = [
    {'amount': 499, 'status': 'success', 'description': 'Premium Plan - Monthly', 'gateway': 'Razorpay', 'date': 'Jun 12, 2026'},
    {'amount': 499, 'status': 'success', 'description': 'Premium Plan - Monthly', 'gateway': 'Razorpay', 'date': 'May 12, 2026'},
    {'amount': 499, 'status': 'success', 'description': 'Premium Plan - Monthly', 'gateway': 'Razorpay', 'date': 'Apr 12, 2026'},
    {'amount': 499, 'status': 'failed', 'description': 'Premium Plan - Monthly', 'gateway': 'Razorpay', 'date': 'Mar 12, 2026'},
    {'amount': 249, 'status': 'success', 'description': 'Standard Plan - Monthly', 'gateway': 'Razorpay', 'date': 'Feb 12, 2026'},
  ];
}
