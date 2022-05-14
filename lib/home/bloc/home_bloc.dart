import 'package:dapps_voting/services/home.service.dart';
import 'package:dapps_voting/utils/home.validation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';

part 'home_state.dart';


class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeService homeService;
  HomeBloc({required this.homeService}) : super(HomeState()) {
    on<GetBalanceEvent>(_getHome);
    on<OnChangeAmountEvent>(_onAmountChange);
    on<DepositEvent>(_deposit);
    on<WithdrawEvent>(_withdraw);
  }

  Future<void> _getHome(GetBalanceEvent event, Emitter<HomeState> emit) async {
    try {
      emit(state.copyWith(status: HomePageStatus.loading));
      int balance=await homeService.getBalance();
      emit(state.copyWith(status: HomePageStatus.balance,balance: balance));
    } catch (e) {
      emit(state.copyWith(status: HomePageStatus.err));
    }
  }

  Future<void> _onAmountChange(OnChangeAmountEvent event, Emitter<HomeState> emit) async {
    final amount = Amount.dirty(value: event.amount);
    emit(state.copyWith(
      amount:amount,
    ));
  }

  Future<void> _deposit(DepositEvent event, Emitter<HomeState> emit) async {
    try {
      if (state.amount?.valid ?? false) {
        await homeService.deposit(int.parse(state.amount?.value??'0'));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<void> _withdraw(WithdrawEvent event, Emitter<HomeState> emit) async {
    try {
      if (state.amount?.valid ?? false) {
        await homeService.deposit(int.parse(state.amount?.value??'0'));
      }
    } catch (e) {
    }
  }
}
