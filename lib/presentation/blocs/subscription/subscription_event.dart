part of 'subscription_bloc.dart';

// EVENTS
abstract class SubscriptionEvent extends Equatable {
  const SubscriptionEvent();
  @override
  List<Object?> get props => [];
}

class SubscriptionPlansLoaded extends SubscriptionEvent {}
class SubscriptionCurrentLoaded extends SubscriptionEvent {}

class SubscriptionInitiated extends SubscriptionEvent {
  final String planId;
  final String? promoCode;
  const SubscriptionInitiated({required this.planId, this.promoCode});
  @override
  List<Object?> get props => [planId, promoCode];
}

class SubscriptionConfirmed extends SubscriptionEvent {
  final String orderId;
  final String paymentId;
  final String signature;
  const SubscriptionConfirmed({required this.orderId, required this.paymentId, required this.signature});
  @override
  List<Object?> get props => [orderId, paymentId, signature];
}

class SubscriptionIapCompleted extends SubscriptionEvent {
  final String productId;
  final String purchaseToken;
  final String platform;
  const SubscriptionIapCompleted({required this.productId, required this.purchaseToken, required this.platform});
  @override
  List<Object?> get props => [productId, purchaseToken, platform];
}

class SubscriptionCancelled extends SubscriptionEvent {}

class SubscriptionPromoApplied extends SubscriptionEvent {
  final String code;
  final String planId;
  const SubscriptionPromoApplied({required this.code, required this.planId});
  @override
  List<Object?> get props => [code, planId];
}

// STATES
abstract class SubscriptionState extends Equatable {
  const SubscriptionState();
  @override
  List<Object?> get props => [];
}

class SubscriptionInitial extends SubscriptionState {}
class SubscriptionLoading extends SubscriptionState {}
class SubscriptionCancelledState extends SubscriptionState {}

class SubscriptionError extends SubscriptionState {
  final String message;
  const SubscriptionError({required this.message});
  @override
  List<Object?> get props => [message];
}

class SubscriptionPlansReady extends SubscriptionState {
  final List<SubscriptionPlan> plans;
  final UserSubscription? current;
  const SubscriptionPlansReady({required this.plans, this.current});
  @override
  List<Object?> get props => [plans, current];
}

class SubscriptionPaymentReady extends SubscriptionState {
  final Map<String, dynamic> order;
  final String planId;
  const SubscriptionPaymentReady({required this.order, required this.planId});
  @override
  List<Object?> get props => [order, planId];
}

class SubscriptionActivated extends SubscriptionState {
  final UserSubscription subscription;
  const SubscriptionActivated({required this.subscription});
  @override
  List<Object?> get props => [subscription];
}

class SubscriptionCurrentReady extends SubscriptionState {
  final UserSubscription? subscription;
  const SubscriptionCurrentReady({this.subscription});
  @override
  List<Object?> get props => [subscription];
}

class SubscriptionPromoValid extends SubscriptionState {
  final double discount;
  final double finalAmount;
  const SubscriptionPromoValid({required this.discount, required this.finalAmount});
  @override
  List<Object?> get props => [discount, finalAmount];
}
