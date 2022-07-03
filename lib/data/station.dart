import 'package:latlong2/latlong.dart';
import 'package:uuid/uuid.dart';

class Station {
  final Uuid id;
  final String name;
  final LatLng coords;

  Station(this.id, this.name, this.coords);
  Station.empty()
      : id = const Uuid(),
        name = "",
        coords = LatLng(0.0, 0.0);
}
