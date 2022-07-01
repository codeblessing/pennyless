import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class StationMap extends StatelessWidget {
  final List<LatLng> markers;
  final LatLng? center;

  const StationMap({required this.markers, this.center, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: center ?? LatLng(52.4006553, 16.7615825),
        zoom: 10,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: ['a', 'b', 'c'],
        ),
        MarkerLayerOptions(
            markers: markers
                .map((point) => Marker(
                    point: point,
                    builder: (_) => const Icon(CupertinoIcons.map_pin)))
                .toList()),
      ],
      nonRotatedChildren: [
        AttributionWidget(
          attributionBuilder: _buildAttributionWidget,
          alignment: Alignment.bottomRight,
        ),
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
