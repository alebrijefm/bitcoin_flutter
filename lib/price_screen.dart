import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'reusable_card.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  String exchangeRateBTC = '?';
  String exchangeRateETH = '?';
  String exchangeRateLTC = '?';

  void getExchangeRate(String currency) async {
    CoinData coinData = CoinData();
    Map<String, String> rates = {};
    for (String crypto in cryptoList) {
      rates[crypto] = await coinData.getCoinData(currency, crypto);
    }

    setState(() {
      selectedCurrency = currency;
      exchangeRateBTC = rates['BTC'];
      exchangeRateETH = rates['ETH'];
      exchangeRateLTC = rates['LTC'];
    });
  }

  DropdownButton androidDropDownButton() {
    List<DropdownMenuItem<String>> dropDwonItems = [];

    for (String currency in currenciesList) {
      dropDwonItems.add(
        DropdownMenuItem(
          child: Text(currency),
          value: currency,
        ),
      );
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropDwonItems,
      onChanged: (value) {
        getExchangeRate(value);
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<DropdownMenuItem<String>> dropDwonItems = [];

    for (String currency in currenciesList) {
      dropDwonItems.add(
        DropdownMenuItem(
          child: Text(currency),
          value: currency,
        ),
      );
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32,
      onSelectedItemChanged: (indexSelected) {
        getExchangeRate(currenciesList[indexSelected]);
      },
      children: dropDwonItems,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ReusableCard(
                  rate: exchangeRateBTC,
                  currency: selectedCurrency,
                  coin: cryptoList[0],
                ),
                ReusableCard(
                  rate: exchangeRateETH,
                  currency: selectedCurrency,
                  coin: cryptoList[1],
                ),
                ReusableCard(
                  rate: exchangeRateLTC,
                  currency: selectedCurrency,
                  coin: cryptoList[2],
                ),
              ],
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropDownButton(),
          ),
        ],
      ),
    );
  }
}
