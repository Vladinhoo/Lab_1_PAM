import 'package:flutter/material.dart';

void main() {
  runApp(CurrencyConverterApp());
}

class CurrencyConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CurrencyConverterScreen(),
    );
  }
}

class CurrencyConverterScreen extends StatefulWidget {
  @override
  _CurrencyConverterScreenState createState() =>
      _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();

  bool _isFromMDLtoUSD = true;
  double _convertedAmount = 0.0;

  void _convertCurrency() {
    double amount = double.tryParse(_amountController.text) ?? 0.0;
    double exchangeRate = double.tryParse(_rateController.text) ?? 1.0;

    setState(() {
      if (_isFromMDLtoUSD) {
        _convertedAmount = amount / exchangeRate;
      } else {
        _convertedAmount = amount * exchangeRate;
      }
    });
  }

  void _swapCurrencies() {
    setState(() {
      _isFromMDLtoUSD = !_isFromMDLtoUSD;
      _convertCurrency(); // Recalculăm suma după schimbarea direcției.
    });
  }

  @override
  Widget build(BuildContext context) {
    String fromCurrency = _isFromMDLtoUSD ? 'MDL' : 'USD';
    String toCurrency = _isFromMDLtoUSD ? 'USD' : 'MDL';

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Currency Converter',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildCurrencyField('Amount ($fromCurrency)', _amountController),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: _swapCurrencies,
                      child: CircleAvatar(
                        backgroundColor: Colors.indigo,
                        child: Icon(Icons.swap_vert, color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 20),
                    _buildConvertedField('Converted Amount ($toCurrency)', _convertedAmount),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Exchange Rate',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              SizedBox(height: 10),
              Container(
                width: 150,
                child: TextField(
                  controller: _rateController,
                  decoration: InputDecoration(
                    labelText: 'Rate',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) => _convertCurrency(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _convertCurrency,
                child: Text('Convert'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCurrencyField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      keyboardType: TextInputType.number,
      onChanged: (value) => _convertCurrency(),
    );
  }

  Widget _buildConvertedField(String label, double convertedAmount) {
    return Container(
      height: 60,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey),
      ),
      child: Text(
        convertedAmount.toStringAsFixed(2),
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
