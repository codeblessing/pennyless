import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pennyless/data/price_data.dart';
import 'package:sprintf/sprintf.dart';

class PriceScreen extends StatelessWidget {
  final PriceData _data;
  final TextStyle _style;
  const PriceScreen(
      {required PriceData prices,
      TextStyle style = const TextStyle(
        color: Color(0xff000000),
        fontSize: 17.0,
        fontFamily: "Roboto Mono",
      ),
      Key? key})
      : _data = prices,
        _style = style,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Center(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                  child: const Icon(CupertinoIcons.pencil),
                  onPressed: () =>
                      Navigator.of(context).pushNamed('/edit_prices'),
                ),
              ),
              Column(
                children: [
                  Text(sprintf("% -8s: %6.2f", ["ON", _data.ON]),
                      style: _style),
                  Text(sprintf("% -8s: %6.2f", ["Pb 98", _data.PB98]),
                      style: _style),
                  Text(sprintf("% -8s: %6.2f", ["Pb 95", _data.PB95]),
                      style: _style),
                  Text(sprintf("% -8s: %6.2f", ["LPG", _data.LPG]),
                      style: _style),
                ],
              )
            ],
          ),
        ));
  }
}
