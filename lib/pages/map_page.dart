import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:pennyless/data/price_data.dart';
import 'package:pennyless/database.dart';

import '../data/station.dart';

class MapPage extends StatelessWidget {
  final List<Station> markers = Database().stations.values.toList();
  final LatLng? center;

  MapPage({
    this.center,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: center ?? LatLng(52.3962703, 16.9530903),
        zoom: 13.5,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: ['a', 'b', 'c'],
        ),
        MarkerLayerOptions(
            markers: markers
                .map((station) => Marker(
                    point: station.coords,
                    builder: (_) => GestureDetector(
                          child: const Icon(Icons.local_gas_station),
                          // When user taps pin on map we navigate to price view and pass station id.
                          onTap: () => Navigator.of(context)
                              .pushNamed('/prices', arguments: station.id),
                        )))
                .toList()),
      ],
      nonRotatedChildren: [
        AttributionWidget(
          attributionBuilder: _buildAttributionWidget,
          alignment: Alignment.bottomRight,
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: 80.0,
                height: 80.0,
                child: FittedBox(
                  child: FloatingActionButton(
                    onPressed: () => Navigator.of(context).pushNamed('/add'),
                    child: const Icon(Icons.add),
                  ),
                ),
              )),
        )
      ],
    );
  }

  Widget _buildAttributionWidget(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: ColoredBox(
        color: const Color(0xCCFFFFFF),
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                "© OpenStreetMaps contributors",
                style: TextStyle(color: Color(0xFF000000), fontSize: 18.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
