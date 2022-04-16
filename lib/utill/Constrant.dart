import 'package:location/location.dart';

double lat = 0;
double lan = 0;
String LATEST_PRODUCTS_URI =
    // 'api/v1/products/latest/1/$lat/$lan?limit=10&&offset=';
    'api/v1/products/latest/1/34.00029228659783/71.48496111784907?limit=10&&offset='; // Lat long default

Location _locationTracker = Location();
LocationData locationData;
Future<String> determinePosition() async {
  locationData = await _locationTracker.getLocation();
  lat = locationData.latitude;
  lan = locationData.longitude;
  LATEST_PRODUCTS_URI = 'api/v1/products/latest/1/$lat/$lan?limit=10&&offset=';
  print(lat);
  print(lan);
  return 'api/v1/products/latest/1/$lat/$lan?limit=10&&offset=';
}
