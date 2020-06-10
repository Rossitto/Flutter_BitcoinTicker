import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'AUD';
  String cryptoPrice1 = '...';
  String cryptoPrice2 = '...';
  String cryptoPrice3 = '...';
  String cryptoCurrency1 = cryptoList[0];
  String cryptoCurrency2 = cryptoList[1];
  String cryptoCurrency3 = cryptoList[2];
  Map<String, dynamic> receivedData;

  @override
  void initState() {
    super.initState();
    getData(cryptoFullURL);
  }

  void getData(url) async {
    receivedData = await CoinData().getCoinData(url);
    print(receivedData);
    updateUI();
  }

  void updateUI() {
    setState(() {
      if (receivedData == null) {
        cryptoPrice1 = 'ERROR';
        cryptoPrice2 = 'ERROR';
        cryptoPrice3 = 'ERROR';
      }
      cryptoPrice1 = receivedData[cryptoCurrency1][selectedCurrency].toString();
      cryptoPrice2 = receivedData[cryptoCurrency2][selectedCurrency].toString();
      cryptoPrice3 = receivedData[cryptoCurrency3][selectedCurrency].toString();
    });
  }

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(child: Text(currency), value: currency);
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        selectedCurrency = value;
        updateUI();
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerList = [];
    for (String currency in currenciesList) {
      pickerList.add(Text(currency));
    }
    return CupertinoPicker(
        itemExtent: 32.0,
        onSelectedItemChanged: (selectedIndex) {
          selectedCurrency = currenciesList[selectedIndex];
          updateUI();
        },
        children: pickerList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: CryptoCard(
                cryptoCurrency: cryptoCurrency1,
                cryptoPrice: cryptoPrice1,
                selectedCurrency: selectedCurrency),
          ),
          Expanded(
            child: CryptoCard(
                cryptoCurrency: cryptoCurrency2,
                cryptoPrice: cryptoPrice2,
                selectedCurrency: selectedCurrency),
          ),
          Expanded(
            child: CryptoCard(
                cryptoCurrency: cryptoCurrency3,
                cryptoPrice: cryptoPrice3,
                selectedCurrency: selectedCurrency),
          ),
          Expanded(
            flex: 5,
            child: Container(),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}

class CryptoCard extends StatelessWidget {
  const CryptoCard({
    @required this.cryptoCurrency,
    @required this.cryptoPrice,
    @required this.selectedCurrency,
  });

  final String cryptoCurrency;
  final String cryptoPrice;
  final String selectedCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
            child: Text(
              '1 $cryptoCurrency = $cryptoPrice $selectedCurrency',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
