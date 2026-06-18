import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/content.dart';
import '../../blocs/subscription/subscription_bloc.dart';
import '../../blocs/subscription/subscription_event.dart';

class CheckoutScreen extends StatefulWidget {
  final SubscriptionPlan plan;
  const CheckoutScreen({super.key, required this.plan});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  late Razorpay _razorpay;
  String? _promoCode;
  double? _discountAmount;
  bool _isLoading = false;
  final _promoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    _promoController.dispose();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    context.read<SubscriptionBloc>().add(VerifyPaymentEvent(
      orderId: response.orderId ?? '',
      paymentId: response.paymentId ?? '',
      signature: response.signature ?? '',
      gateway: 'razorpay',
    ));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    setState(() => _isLoading = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Payment failed: ${response.message}'), backgroundColor: Colors.red),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    setState(() => _isLoading = false);
  }

  void _openRazorpay(String orderId, String keyId) {
    final options = {
      'key': keyId,
      'order_id': orderId,
      'amount': ((widget.plan.price - (_discountAmount ?? 0)) * 100).toInt(),
      'currency': widget.plan.currency,
      'name': 'OTT Platform',
      'description': '${widget.plan.name} Subscription',
      'prefill': {'contact': '', 'email': ''},
      'theme': {'color': '#E50914'},
    };
    _razorpay.open(options);
  }

  double get _finalPrice => widget.plan.price - (_discountAmount ?? 0);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<OttColors>()!;
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.surface,
        title: Text('Checkout', style: TextStyle(color: colors.textPrimary)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
      ),
      body: BlocListener<SubscriptionBloc, dynamic>(
        listener: (context, state) {
          // Handle subscription bloc states
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPlanCard(colors),
              const SizedBox(height: 24),
              _buildPromoCodeSection(colors),
              const SizedBox(height: 24),
              _buildPriceSummary(colors),
              const SizedBox(height: 32),
              _buildPaymentMethods(colors),
              const SizedBox(height: 24),
              _buildTermsText(colors),
              const SizedBox(height: 32),
              _buildCheckoutButton(colors),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlanCard(OttColors colors) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colors.primary.withOpacity(0.2), colors.surface],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.primary.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: colors.primary, borderRadius: BorderRadius.circular(20)),
                child: Text(widget.plan.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              if (widget.plan.isPopular) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(20)),
                  child: const Text('POPULAR', style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold)),
                ),
              ],
            ],
          ),
          const SizedBox(height: 16),
          Text('${widget.plan.currency} ${widget.plan.price.toStringAsFixed(2)}',
              style: TextStyle(color: colors.textPrimary, fontSize: 28, fontWeight: FontWeight.bold)),
          Text('per ${widget.plan.billingCycle}', style: TextStyle(color: colors.textSecondary)),
          const SizedBox(height: 16),
          ...widget.plan.features.map((f) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: colors.primary, size: 16),
                const SizedBox(width: 8),
                Text(f, style: TextStyle(color: colors.textSecondary, fontSize: 13)),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildPromoCodeSection(OttColors colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Promo Code', style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _promoController,
                style: TextStyle(color: colors.textPrimary),
                textCapitalization: TextCapitalization.characters,
                decoration: InputDecoration(
                  hintText: 'Enter promo code',
                  hintStyle: TextStyle(color: colors.textSecondary),
                  filled: true,
                  fillColor: colors.surface,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: colors.divider)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: colors.divider)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: colors.primary)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),
            const SizedBox(width: 12),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _promoCode = _promoController.text.trim();
                  _discountAmount = 50.0; // TODO: validate via API
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: const Text('Promo applied! ₹50 off'), backgroundColor: Colors.green),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primary,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Apply', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
        if (_discountAmount != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 16),
                const SizedBox(width: 6),
                Text('Promo applied: -${widget.plan.currency} ${_discountAmount!.toStringAsFixed(2)}',
                    style: const TextStyle(color: Colors.green, fontSize: 13)),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildPriceSummary(OttColors colors) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: colors.surface, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          _summaryRow('Subscription (${widget.plan.name})', '${widget.plan.currency} ${widget.plan.price.toStringAsFixed(2)}', colors),
          if (_discountAmount != null) ...[
            const Divider(height: 16),
            _summaryRow('Promo Discount', '- ${widget.plan.currency} ${_discountAmount!.toStringAsFixed(2)}', colors, isDiscount: true),
          ],
          const Divider(),
          _summaryRow('Total', '${widget.plan.currency} ${_finalPrice.toStringAsFixed(2)}', colors, isBold: true),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value, OttColors colors, {bool isBold = false, bool isDiscount = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: colors.textSecondary, fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        Text(value, style: TextStyle(
          color: isDiscount ? Colors.green : (isBold ? colors.textPrimary : colors.textSecondary),
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          fontSize: isBold ? 16 : 14,
        )),
      ],
    );
  }

  Widget _buildPaymentMethods(OttColors colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Payment Methods', style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 8,
          children: [
            _paymentChip('UPI', Icons.phone_android, colors),
            _paymentChip('Cards', Icons.credit_card, colors),
            _paymentChip('Net Banking', Icons.account_balance, colors),
            _paymentChip('Wallets', Icons.account_balance_wallet, colors),
          ],
        ),
      ],
    );
  }

  Widget _paymentChip(String label, IconData icon, OttColors colors) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colors.divider),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: colors.textSecondary),
          const SizedBox(width: 6),
          Text(label, style: TextStyle(color: colors.textSecondary, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildTermsText(OttColors colors) {
    return Text(
      'By continuing, you agree to our Terms of Service and authorize us to charge your selected payment method. Subscriptions auto-renew unless cancelled.',
      style: TextStyle(color: colors.textSecondary, fontSize: 11),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildCheckoutButton(OttColors colors) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: _isLoading ? null : () async {
          setState(() => _isLoading = true);
          context.read<SubscriptionBloc>().add(CreateOrderEvent(
            planId: widget.plan.id,
            promoCode: _promoCode,
            gateway: 'razorpay',
          ));
          // The bloc listener will open Razorpay once order is created
          setState(() => _isLoading = false);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
          disabledBackgroundColor: colors.primary.withOpacity(0.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: _isLoading
            ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
            : Text('Pay ${widget.plan.currency} ${_finalPrice.toStringAsFixed(2)}',
                style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
