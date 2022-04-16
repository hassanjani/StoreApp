import 'package:location/location.dart';

double lat = 0;
double lan = 0;
int id;
String BRAND_PRODUCT_URI =
// 'api/v1/products/latest/1/$lat/$lan?limit=10&&offset=';
    'api/v1/brands/products/1/34.00029228659783/71.48496111784907/'; // Lat long default

Location _locationTracker = Location();
LocationData locationData;
Future<String> determinePositionBrand() async {
  locationData = await _locationTracker.getLocation();
  lat = locationData.latitude;
  lan = locationData.longitude;
  BRAND_PRODUCT_URI = 'api/v1/brands/products/1/$lat/$lan/';
  print(lat);
  print(lan);
  return 'api/v1/brands/products/1/$lat/$lan/';
}
