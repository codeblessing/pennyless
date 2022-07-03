// ignore_for_file: non_constant_identifier_names
import 'package:pennyless/data/station.dart';

class PriceData {
  final Station station;
  final double ON;
  final double PB98;
  final double PB95;
  final double LPG;

  const PriceData(this.station, this.ON, this.PB98, this.PB95, this.LPG);
  PriceData.empty()
      : station = Station.empty(),
        ON = 0.0,
        PB98 = 0.0,
        PB95 = 0.0,
        LPG = 0.0;
}
