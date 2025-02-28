import 'package:flutter/material.dart';
import 'package:stroy_baza/app_constats/assets_model.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';


class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  late YandexMapController _mapController;
  final List<MapObject> mapObjects = [];

  final List<Map<String, dynamic>> bazarPoints = [
    {
      'name': 'Tashkent City Park',
      'point': const Point(latitude: 41.2825974, longitude: 69.2793667),
    },
    {
      'name': 'Amir Temur Square',
      'point': const Point(latitude: 41.311397, longitude: 69.279512),
    },
    {
      'name': 'Chorsu Bazaar',
      'point': const Point(latitude: 41.326673, longitude: 69.236774),
    },
    {
      'name': 'Tashkent Mall',
      'point': const Point(latitude: 41.285529, longitude: 69.204201),
    },
    {
      'name': 'Next Mall',
      'point': const Point(latitude: 41.325906, longitude: 69.268741),
    },
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      moveToDefaultLocation();
    });
    initMapPoints();
  }

  void moveToDefaultLocation() {
    _mapController.moveCamera(
      CameraUpdate.newCameraPosition(
        const CameraPosition(
          target: Point(latitude: 41.2995, longitude: 69.2401), // Toshkent markazi
          zoom:12,
        ),
      ),
      animation: const MapAnimation(
        type: MapAnimationType.smooth,
        duration: 1.5, // Animatsiya vaqti
      ),
    );
  }

  void initMapPoints() {
    for (var point in bazarPoints) {
      mapObjects.add(
        PlacemarkMapObject(
          mapId: MapObjectId(point['name']),
          point: point['point'],
          text: PlacemarkText(
            text: point['name'],
            style: PlacemarkTextStyle(
              color: Colors.black,
              placement: TextStylePlacement.bottom,
            ),
          ),
          icon: PlacemarkIcon.single(
            PlacemarkIconStyle(
              image: BitmapDescriptor.fromAssetImage(AssetsModel.location),
              scale: 1,
            ),
          ),
        ),
      );
    }
    setState(() {});
  }

  void onMapCreated(YandexMapController controller) {
    _mapController = controller;
    moveToDefaultLocation();
  }

  @override
  Widget build(BuildContext context) {
    return YandexMap(
      mapObjects: mapObjects,
      onMapCreated:onMapCreated,
      nightModeEnabled: false,
      tiltGesturesEnabled: true,
      zoomGesturesEnabled: true,
      rotateGesturesEnabled: true,
      scrollGesturesEnabled: true,
      logoAlignment: const MapAlignment(
        horizontal: HorizontalAlignment.right,
        vertical: VerticalAlignment.bottom,
      ),
      fastTapEnabled: true,
    );
  }
}
