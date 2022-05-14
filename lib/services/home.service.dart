import 'package:dapps_voting/config.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class HomeService{
  late Client httpClient;
  late Web3Client ethereumClient;

  HomeService(){
    httpClient = Client();
    ethereumClient = Web3Client(ethereumClientUrl, httpClient);
  }

  Future<int> getBalance() async {
    List<dynamic> result = await _query('getBalance', []);
    int balance = int.parse(result[0].toString());
   return balance;
  }

  Future<void> deposit(int amount) async {
    BigInt parsedAmount = BigInt.from(amount);
    await _transaction("deposit", [parsedAmount]);
  }

  Future<void> withdraw(int amount) async {
    BigInt parsedAmount = BigInt.from(amount);
    await _transaction("withdraw", [parsedAmount]);
  }



  Future<List<dynamic>> _query(String functionName, List<dynamic> args) async {
    DeployedContract contract = await _getContract();
    ContractFunction function = contract.function(functionName);
    List<dynamic> result = await ethereumClient.call(
        contract: contract, function: function, params: args);
    return result;
  }

  Future<DeployedContract> _getContract() async {
    String abi = await rootBundle.loadString("assets/abi.json");

    DeployedContract contract = DeployedContract(
      ContractAbi.fromJson(abi, contractName),
      EthereumAddress.fromHex(contractAddress),
    );
    return contract;
  }

  Future<String> _transaction(String functionName, List<dynamic> args) async {
    EthPrivateKey credential = EthPrivateKey.fromHex(private_key);
    DeployedContract contract = await _getContract();
    ContractFunction function = contract.function(functionName);
    dynamic result = await ethereumClient.sendTransaction(
      credential,
      Transaction.callContract(
        contract: contract,
        function: function,
        parameters: args,
      ),
      fetchChainIdFromNetworkId: true,
      chainId: null,
    );

    return result;
  }


}