part of'home_bloc.dart';

abstract class HomeEvent extends Equatable{
  @override
  List<Object?> get props =>[];
}
class GetBalanceEvent extends HomeEvent{}
class OnChangeAmountEvent extends HomeEvent{
  final String amount;

  OnChangeAmountEvent({required this.amount});
}
class DepositEvent extends HomeEvent{}
class WithdrawEvent extends HomeEvent{}
