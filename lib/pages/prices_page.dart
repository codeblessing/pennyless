import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pennyless/data/price_data.dart';
import 'package:pennyless/data/prices.dart';
import 'package:pennyless/database.dart';
import 'package:sprintf/sprintf.dart';

class PricesPage extends StatelessWidget {
  const PricesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String;
    // Station with given id must exist, because we get this from map.
    final name = Database().stations[id]!.name;
    final prices = Database().prices[id] ?? Prices(id, 0.0, 0.0, 0.0, 0.0);

    return Scaffold(
      appBar: AppBar(title: Text(name), actions: [
        GestureDetector(
            onTap: () => Navigator.of(context).pushNamed('/'),
            child: const Icon(Icons.map))
      ]),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: 200.0,
            maxWidth: 300.0,
          ),
          child: ListView(
            children: [
              Row(
                children: [
                  const Spacer(),
                  OutlinedButton.icon(
                      onPressed: () => Navigator.of(context)
                          .popAndPushNamed('/edit_prices', arguments: prices),
                      icon: const Icon(Icons.edit),
                      label: const Text('Edit'))
                ],
              ),
              FuelCard(icon: 'res/images/on_icon.svg', price: prices.ON),
              FuelCard(icon: 'res/images/pb98_icon.svg', price: prices.PB98),
              FuelCard(icon: 'res/images/pb95_icon.svg', price: prices.PB95),
              FuelCard(icon: 'res/images/lpg_icon.svg', price: prices.LPG),
            ],
          ),
        ),
      ),
    );
  }
}

class FuelCard extends StatelessWidget {
  final String icon;
  final double price;

  const FuelCard({
    required this.icon,
    required this.price,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: 100.0,
          maxHeight: 100.0,
          minWidth: 200.0,
          maxWidth: 300.0,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              const Spacer(),
              ConstrainedBox(
                constraints: const BoxConstraints(
                    minWidth: 40.0,
                    maxWidth: 60.0,
                    minHeight: 40.0,
                    maxHeight: 60.0),
                child: SvgPicture.asset(
                  icon,
                  fit: BoxFit.contain,
                ),
              ),
              const Spacer(flex: 40),
              Text(sprintf('%.2f PLN', [price])),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
