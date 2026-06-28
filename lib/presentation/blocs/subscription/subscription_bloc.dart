import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../core/error/failure.dart';
import '../../../data/repositories/subscription_repository.dart';
import '../../../data/models/content.dart';

part 'subscription_event.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  final SubscriptionRepository _repository;

  SubscriptionBloc(this._repository) : super(SubscriptionInitial()) {
    on<SubscriptionPlansLoaded>(_onPlansLoaded);
    on<SubscriptionInitiated>(_onInitiated);
    on<SubscriptionConfirmed>(_onConfirmed);
    on<SubscriptionIapCompleted>(_onIapCompleted);
    on<SubscriptionCancelled>(_onCancelled);
    on<SubscriptionCurrentLoaded>(_onCurrentLoaded);
    on<SubscriptionPromoApplied>(_onPromoApplied);
  }

  Future<void> _onPlansLoaded(SubscriptionPlansLoaded event, Emitter<SubscriptionState> emit) async {
    emit(SubscriptionLoading());
    try {
      final plans = await _repository.getPlans();
      final current = await _repository.getCurrentSubscription();
      emit(SubscriptionPlansReady(plans: plans, current: current));
    } catch (e) {
      emit(SubscriptionError(message: friendlyError(e)));
    }
  }

  Future<void> _onInitiated(SubscriptionInitiated event, Emitter<SubscriptionState> emit) async {
    emit(SubscriptionLoading());
    try {
      final order = await _repository.initiateSubscription(
        planId: event.planId,
        promoCode: event.promoCode,
      );
      emit(SubscriptionPaymentReady(order: order, planId: event.planId));
    } catch (e) {
      emit(SubscriptionError(message: friendlyError(e)));
    }
  }

  Future<void> _onConfirmed(SubscriptionConfirmed event, Emitter<SubscriptionState> emit) async {
    emit(SubscriptionLoading());
    try {
      final subscription = await _repository.confirmPayment(
        orderId: event.orderId,
        paymentId: event.paymentId,
        signature: event.signature,
      );
      emit(SubscriptionActivated(subscription: subscription));
    } catch (e) {
      emit(SubscriptionError(message: friendlyError(e)));
    }
  }

  Future<void> _onIapCompleted(SubscriptionIapCompleted event, Emitter<SubscriptionState> emit) async {
    emit(SubscriptionLoading());
    try {
      final subscription = await _repository.verifyIap(
        productId: event.productId,
        purchaseToken: event.purchaseToken,
        platform: event.platform,
      );
      emit(SubscriptionActivated(subscription: subscription));
    } catch (e) {
      emit(SubscriptionError(message: friendlyError(e)));
    }
  }

  Future<void> _onCancelled(SubscriptionCancelled event, Emitter<SubscriptionState> emit) async {
    try {
      await _repository.cancelSubscription();
      emit(SubscriptionCancelledState());
    } catch (e) {
      emit(SubscriptionError(message: friendlyError(e)));
    }
  }

  Future<void> _onCurrentLoaded(SubscriptionCurrentLoaded event, Emitter<SubscriptionState> emit) async {
    emit(SubscriptionLoading());
    try {
      final current = await _repository.getCurrentSubscription();
      emit(SubscriptionCurrentReady(subscription: current));
    } catch (e) {
      emit(SubscriptionError(message: friendlyError(e)));
    }
  }

  Future<void> _onPromoApplied(SubscriptionPromoApplied event, Emitter<SubscriptionState> emit) async {
    try {
      final result = await _repository.validatePromo(event.code, event.planId);
      emit(SubscriptionPromoValid(discount: result['discount'], finalAmount: result['finalAmount']));
    } catch (e) {
      emit(SubscriptionError(message: friendlyError(e)));
    }
  }
}
