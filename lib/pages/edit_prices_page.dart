// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pennyless/data/prices.dart';
import 'package:pennyless/database.dart';
import 'package:pennyless/ext/utils/constants.dart';

class EditPricePage extends StatefulWidget {
  const EditPricePage({Key? key}) : super(key: key);

  @override
  State<EditPricePage> createState() => _EditPricePageState();
}

class _EditPricePageState extends State<EditPricePage> {
  final controllers = {
    'ON': TextEditingController(),
    'PB98': TextEditingController(),
    'PB95': TextEditingController(),
    'LPG': TextEditingController(),
  };

  late String id;

  Future<void> _submit() async {
    var prices = {
      "id": id,
      "ON": double.tryParse(controllers['ON']!.text),
      "PB98": double.tryParse(controllers['PB98']!.text),
      "PB95": double.tryParse(controllers['PB95']!.text),
      "LPG": double.tryParse(controllers['LPG']!.text),
    };
    var result = await supabase.from('prices').upsert(prices).execute();
    await Database().fetch();

    if (mounted) {
      if (result.error != null) {
        context.showErrorSnackBar(message: "Cannot set prices");
      } else {
        Navigator.of(context).popAndPushNamed('/prices', arguments: id);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final prices = ModalRoute.of(context)?.settings.arguments as Prices;
    id = prices.station_id;

    controllers['ON']!.text = prices.ON.toString();
    controllers['PB98']!.text = prices.PB98.toString();
    controllers['PB95']!.text = prices.PB95.toString();
    controllers['LPG']!.text = prices.LPG.toString();

    return Scaffold(
      appBar: AppBar(title: const Text('Edit prices')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: 200.0,
            maxWidth: 400.0,
            minHeight: 200.0,
            maxHeight: 500.0,
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Form(
              child: Column(
                children: [
                  EditPriceField(
                    controller: controllers['ON']!,
                    label: "ON price",
                  ),
                  EditPriceField(
                    controller: controllers['PB98']!,
                    label: 'Pb 98 price',
                  ),
                  EditPriceField(
                    controller: controllers['PB95']!,
                    label: 'Pb 95 price',
                  ),
                  EditPriceField(
                    controller: controllers['LPG']!,
                    label: 'LPG price',
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
                  ElevatedButton(
                    onPressed: _submit,
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text("Submit"),
                    ),
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

class EditPriceField extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  const EditPriceField({
    Key? key,
    required this.controller,
    required this.label,
  }) : super(key: key);

  double value() => double.tryParse(controller.text) ?? 0.0;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          RegExp(r'[0-9.]'),
        )
      ],
    );
  }
}
