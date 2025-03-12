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
      'name': 'Andijon Shahri, Bobur shohko‘chasi, 22-uy, Bobur Parki',
      'point': const Point(latitude: 41.2825974, longitude: 69.2793667),
    },
    {
      'name': 'Samarqand Shahri, Registon maydoni, 1-uy, Registon',
      'point': const Point(latitude: 41.311397, longitude: 69.279512),
    },
    {
      'name': 'Buxoro Shahri, Po‘lat Darvoza ko‘chasi, 9-uy, Lyabi Hovuz',
      'point': const Point(latitude: 41.326673, longitude: 69.236774),
    },
    {
      'name': 'Namangan Shahri, Istiqlol ko‘chasi, 14-uy, Afsonalar vodiysi',
      'point': const Point(latitude: 41.285529, longitude: 69.204201),
    },
    {
      'name': 'Navoiy Shahri, Mustaqillik ko‘chasi, 5-uy, Navoiy teatri',
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
          target:
              Point(latitude: 41.2995, longitude: 69.2401), // Toshkent markazi
          zoom: 12,
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
          opacity: 1,
          mapId: MapObjectId(point['name']),
          onTap: (PlacemarkMapObject self, Point point) {
            _showLocationDetails(self.mapId.value);
          },
          point: point['point'],
          text: PlacemarkText(
            text: '',
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

  void _showLocationDetails(String locationName) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              locationName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(255, 223, 2, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Bu yerdan olaman',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return YandexMap(
      mapObjects: mapObjects,
      onMapCreated: onMapCreated,
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
