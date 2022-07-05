import 'package:latlong2/latlong.dart';
import 'package:pennyless/ext/utils/constants.dart';

import 'data/prices.dart';
import 'data/station.dart';

class Database {
  static final Database _instance = Database._init();

  Map<String, Station> stations = {};
  Map<String, Prices> prices = {};

  Database._init();

  factory Database() => _instance;

  Future<void> fetch() async {
    stations.addEntries(
      (await _getStationData())
          .map((prices) => MapEntry(prices.id, prices))
          .toList(),
    );
    prices.addEntries(
      (await _getPricesData())
          .map((prices) => MapEntry(prices.station_id, prices))
          .toList(),
    );
  }

  Future<List<Station>> _getStationData() async {
    final response = await supabase.from('stations').select().execute();
    if (response.error != null) {
      print("Cannot get stations' data.");
      return [];
    }

    final data = response.data as List<dynamic>;
    final stations = data
        .map(
          (station) => Station(
            station['id'],
            station['name'],
            LatLng(station['latitude'], station['longitude']),
          ),
        )
        .toList();

    return stations;
  }

  Future<List<Prices>> _getPricesData() async {
    final response = await supabase.from('prices').select().execute();
    if (response.error != null) {
      print("Cannot get prices' data.");
      return [];
    }

    final data = response.data as List<dynamic>;
    final prices = data
        .map(
          (prices) => Prices(
            prices['id'],
            double.tryParse(prices['ON'].toString()) ?? 0.0,
            double.tryParse(prices['PB98'].toString()) ?? 0.0,
            double.tryParse(prices['PB95'].toString()) ?? 0.0,
            double.tryParse(prices['LPG'].toString()) ?? 0.0,
          ),
        )
        .toList();

    return prices;
  }
}
