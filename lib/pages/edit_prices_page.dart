// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:pennyless/data/price_data.dart';
import 'package:pennyless/ext/utils/constants.dart';

class EditPricePage extends StatefulWidget {
  final PriceData current_prices;
  const EditPricePage({required this.current_prices, Key? key})
      : super(key: key);

  @override
  State<EditPricePage> createState() => _EditPricePageState(current_prices);
}

class _EditPricePageState extends State<EditPricePage> {
  final TextEditingController _ONPriceController;
  final TextEditingController _PB98PriceController;
  final TextEditingController _PB95PriceController;
  final TextEditingController _LPGPriceController;

  _EditPricePageState(PriceData current)
      : _ONPriceController = TextEditingController(text: current.ON.toString()),
        _PB98PriceController =
            TextEditingController(text: current.PB98.toString()),
        _PB95PriceController =
            TextEditingController(text: current.PB95.toString()),
        _LPGPriceController =
            TextEditingController(text: current.LPG.toString());

  Future<void> _submit() async {
    var prices = {
      "ON": double.tryParse(_ONPriceController.text),
      "PB98": double.tryParse(_PB98PriceController.text),
      "PB95": double.tryParse(_PB95PriceController.text),
      "LPG": double.tryParse(_LPGPriceController.text),
    };
    var result = await supabase.from('prices').upsert(prices).execute();
    if (mounted && result.error != null) {
      context.showErrorSnackBar(message: "Cannot set prices");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
          minWidth: 200.0, maxWidth: 400.0, minHeight: 200.0, maxHeight: 500.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: _ONPriceController,
                decoration: const InputDecoration(labelText: 'ON price'),
              ),
              TextFormField(
                controller: _PB98PriceController,
                decoration: const InputDecoration(labelText: 'Pb 98 price'),
              ),
              TextFormField(
                controller: _PB95PriceController,
                decoration: const InputDecoration(labelText: 'Pb 95 price'),
              ),
              TextFormField(
                controller: _LPGPriceController,
                decoration: const InputDecoration(labelText: 'LPG price'),
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
              ElevatedButton(
                  onPressed: _submit,
                  child: const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text("Submit"),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
