import 'package:latlong2/latlong.dart';
import 'package:uuid/uuid.dart';

class Station {
  final String id;
  final String name;
  final LatLng coords;

  Station(this.id, this.name, this.coords);
  Station.empty()
      : id = const Uuid().v4(),
        name = "",
        coords = LatLng(0.0, 0.0);
}
