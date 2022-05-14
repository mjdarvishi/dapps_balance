import 'package:dapps_voting/home/bloc/home_bloc.dart';
import 'package:dapps_voting/services/home.service.dart';
import 'package:dapps_voting/widget/outline_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:dapps_voting/utils/home.validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dapp Example'),
      ),
      body: Center(
        child: RepositoryProvider(
          create: (context) => HomeService(),
          child: BlocProvider(
            create: (context) => HomeBloc(homeService: context.read<HomeService>())..add(GetBalanceEvent()),
            child: BlocConsumer<HomeBloc, HomeState>(
              listener: (context, state) {},
              builder: (context, state) => Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Balance",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  () {
                    switch (state.status) {
                      case HomePageStatus.err:
                        return const Text(
                          'Err!',
                          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                        );
                      case HomePageStatus.loading:
                        return const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: SizedBox(height: 20,width: 20,child: CircularProgressIndicator(strokeWidth: 2,)),
                        );
                      case HomePageStatus.balance:
                        return Text(
                         state.balance.toString(),
                          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                        );
                    }
                  }(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:20,vertical: 20),
                    child: TextFormField(
                      onChanged: (value) => context.read<HomeBloc>().add(OnChangeAmountEvent(amount: value)),
                      initialValue:state.amount?.value,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        errorText: state.amount?.error?.getDesErr,
                        labelText: 'Amount',
                        labelStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                        hintText: 'input your amount',
                        hintStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey,
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                        filled: true,
                        enabledBorder: inputBorder,
                        focusedBorder: inputBorder,
                        errorBorder: inputBordererr,
                        focusedErrorBorder: inputBordererr,
                        errorStyle: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 12),
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal:30),
                    child: Text(
                      "For Deposit and Withdraw input your amount in the box ",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500,color: Colors.blueGrey),
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                        child: IconButton(
                          onPressed:  () => context.read<HomeBloc>().add(GetBalanceEvent()),
                          icon: const Icon(Icons.refresh),
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        decoration:  BoxDecoration(
                          shape: BoxShape.circle,
                          color: state.amount?.valid??false?Colors.green:Colors.grey[300],
                        ),
                        child: IconButton(
                          onPressed: () =>  context.read<HomeBloc>().add(DepositEvent()),
                          icon: const Icon(Icons.upload),
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        decoration:  BoxDecoration(
                          shape: BoxShape.circle,
                          color:  state.amount?.valid??false?Colors.red:Colors.grey[300],
                        ),
                        child: IconButton(
                          onPressed: () => context.read<HomeBloc>().add(WithdrawEvent()),
                          icon: const Icon(Icons.download),
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
