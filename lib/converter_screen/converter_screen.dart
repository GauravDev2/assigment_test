import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ConverterScreen extends StatefulWidget {
  @override
  _ConverterScreenState createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  final fromTextController = TextEditingController();
  List currencies = [];
  String fromCurrency = "USD";
  String toCurrency = "GBP";
  String? result;

  @override
  void initState() {
    super.initState();
    _loadCurrencies();
  }

  Future<String> _loadCurrencies() async {
    String uri = 'https://v6.exchangerate-api.com/v6/cd2455b9f4dc32c07184fbc4/latest/USD';
    var response = await http
        .get(Uri.parse(uri), headers: {"Accept": "application/json"});
    var responseBody = json.decode(response.body);
    Map curMap = responseBody['conversion_rates'];
    currencies = curMap.entries.map((e) => e.key).toList();
    setState(() {});
    return "Success";
  }

  Future<String> _doConversion() async {
    String uri = "https://v6.exchangerate-api.com/v6/cd2455b9f4dc32c07184fbc4/latest/USD?base_code=$fromCurrency&symbols=$toCurrency";
    var response = await http
        .get(Uri.parse(uri),
        headers: {"Accept": "application/json"});
    var responseBody = json.decode(response.body);
    setState(() {
      result = (double.parse(fromTextController.text) * (responseBody["conversion_rates"][toCurrency])).toString();
    });
    return "Success";
  }

  _onFromChanged(String value) {
    setState(() {
      fromCurrency = value;
    });
  }

  _onToChanged(String value) {
    setState(() {
      toCurrency = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currencies == null
          ? Center(child: CircularProgressIndicator())
          : Container(
        height: MediaQuery.of(context).size.height / 2,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 3.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ListTile(
                  title: TextField(
                    controller: fromTextController,
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                    keyboardType:
                    TextInputType.numberWithOptions(decimal: true),
                  ),
                  trailing: _buildDropDownButton(fromCurrency),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_downward),
                  onPressed: _doConversion,
                ),
                ListTile(
                  title: Chip(
                    label: result != null ?
                    Text(
                      result ?? '',
                      // style: Theme.of(context).textTheme.display1,
                    ) : Text(""),
                  ),
                  trailing: _buildDropDownButton(toCurrency),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropDownButton(String currencyCategory) {
    return DropdownButton(
      value: currencyCategory,
      items: currencies
          .map((value) => DropdownMenuItem(
        value: value,
        child: Row(
          children: <Widget>[
            Text(value.toString()),
          ],
        ),
      ))
          .toList(),
      onChanged: (value) {
        if(currencyCategory == fromCurrency){
          _onFromChanged(value.toString());
        }else {
          _onToChanged(value.toString());
        }
      },
    );
  }
}
