import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class LocationMapView extends StatefulWidget {
  const LocationMapView({Key? key});
  @override
  _LocationMapViewState createState() => _LocationMapViewState();
}




class _LocationMapViewState extends State<LocationMapView> {
  LatLng _center = LatLng(0, 0); // Inicialmente el mapa se centra en el punto (0, 0)
  
  Future<void> _getDeviceLocation() async {
    try {
      // Obtener la ubicación actual del dispositivo
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      // Actualizar el centro del mapa con la ubicación actual
      setState(() {
        _center = LatLng(position.latitude, position.longitude);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _getDeviceLocation(); // Obtener la ubicación actual al inicializar el widget
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location Map View"),
        centerTitle: true,
      ),
      body: Center(
        child: FlutterMap(
          options: MapOptions(
            center: _center, // Centrar el mapa en la ubicación actual del usuario
            zoom: 10.0,
          ),
          layers: [
            TileLayerOptions(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: ['a', 'b', 'c'],
            ),
            MarkerLayerOptions(
              markers: [
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: _center,
                  builder: (ctx) => Container(
                    child: Icon(
                      Icons.location_pin,
                      color: Colors.red,
                      size: 50.0,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}