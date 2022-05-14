part of'home_bloc.dart';
enum HomePageStatus{err,loading,balance}
class HomeState extends Equatable{
  Amount ?amount;
  int balance;
  HomePageStatus status;

  @override
  List<Object?> get props => [status,amount,balance];
  HomeState({this.amount,this.status=HomePageStatus.loading,this.balance=0});

  HomeState copyWith({Amount? amount, HomePageStatus? status,int ?balance}){
    return HomeState(status: status??this.status,amount:amount??this.amount,balance: balance??this.balance);
  }
}