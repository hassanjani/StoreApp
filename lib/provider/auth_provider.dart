import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:location/location.dart';
import 'package:user_app/data/datasource/remote/dio/dio_client.dart';
import 'package:user_app/data/model/body/login_model.dart';
import 'package:user_app/data/model/body/register_model.dart';
import 'package:user_app/data/model/response/base/api_response.dart';
import 'package:user_app/data/model/response/base/error_response.dart';
import 'package:user_app/data/model/response/response_model.dart';
import 'package:user_app/data/repository/auth_repo.dart';
import 'package:user_app/notification/PushNotifications.dart';
import 'package:user_app/utill/app_constants.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepo authRepo;
  AuthProvider({this.authRepo});

  double lat = 0;
  double lng = 0;

  bool _isLoading = false;
  bool _isRemember = false;
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  updateSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  bool get isLoading => _isLoading;
  bool get isRemember => _isRemember;

  void updateRemember(bool value) {
    _isRemember = value;
    notifyListeners();
  }

  changelatlng(double latitude, double longitude) {
    lat = latitude;
    lng = longitude;
    notifyListeners();
  }

  Future registration(RegisterModel register, Function callback) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await authRepo.registration(register);
    _isLoading = false;
    if (apiResponse.response != null &&
        apiResponse.response.statusCode == 200) {
      Map map = apiResponse.response.data;
      var token = await getToken();

      // var token = map["token"];
      authRepo.saveUserToken(token);
      // await authRepo.updateToken();
      callback(true, token);
      notifyListeners();
    } else {
      String errorMessage;
      if (apiResponse.error is String) {
        print(apiResponse.error.toString());
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        print(errorResponse.errors[0].message);
        errorMessage = errorResponse.errors[0].message;
      }
      callback(false, errorMessage);
      notifyListeners();
    }
  }

  Future login(LoginModel loginBody, Function callback) async {
    _isLoading = true;
    await getLocation();
    notifyListeners();
    ApiResponse apiResponse = await authRepo.login(loginBody);
    _isLoading = false;
    if (apiResponse.response != null &&
        apiResponse.response.statusCode == 200) {
      Map map = apiResponse.response.data;
      String token = map["token"];
      authRepo.saveUserToken(token);
      FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
      await updateLatlng();
      PushNotificationService(firebaseMessaging).updateDeviceToken();

      // await authRepo.updateToken();
      callback(true, token);
      notifyListeners();
    } else {
      String errorMessage;
      if (apiResponse.error is String) {
        print(apiResponse.error.toString());
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        print(errorResponse.errors[0].message);
        errorMessage = errorResponse.errors[0].message;
      }
      callback(false, errorMessage);
      notifyListeners();
    }
  }

  Future getLocation() async {
    Location location = new Location();
    LocationData _pos = await location.getLocation();
    lat = _pos.latitude;
    lng = _pos.longitude;
    notifyListeners();
  }

  updateLatlng() async {
    print("latlng");
    print(lat);
    print(lng);
    if (lat != 0 || lng != 0) {
      DioClient dioClient;
      final sl = GetIt.instance;
      dioClient = sl();
      var map = {
        "lt": lat,
        "lg": lng,
      };
      print(map);
      print("map....................");
      final response =
          await dioClient.post(AppConstants.UPDATELATLNG, data: map);
      print(response.data.toString());
      if (response != null && response.statusCode == 200) {
        print(response.data.toString());
        print("latlng updated");
      } else {
        // ApiChecker.checkApi(context, apiResponse);
      }
    }
  }

  // Future<void> updateToken(BuildContext context) async {
  //   // ApiResponse apiResponse = await authRepo.updateToken();
  //   if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
  //
  //   } else {
  //     ApiChecker.checkApi(context, apiResponse);
  //   }
  // }

  // for user Section
  String getUserToken() {
    return authRepo.getUserToken();
  }

  bool isLoggedIn() {
    return authRepo.isLoggedIn();
  }

  Future<bool> clearSharedData() async {
    return await authRepo.clearSharedData();
  }

  // for  Remember Email
  void saveUserEmail(String email, String password) {
    authRepo.saveUserEmailAndPassword(email, password);
  }

  String getUserEmail() {
    return authRepo.getUserEmail() ?? "";
  }

  Future<bool> clearUserEmailAndPassword() async {
    return authRepo.clearUserEmailAndPassword();
  }

  String getUserPassword() {
    return authRepo.getUserPassword() ?? "";
  }

  Future<ResponseModel> forgetPassword(String email) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await authRepo.forgetPassword(email);
    _isLoading = false;
    notifyListeners();
    ResponseModel responseModel;
    if (apiResponse.response != null &&
        apiResponse.response.statusCode == 200) {
      responseModel = ResponseModel(apiResponse.response.data["message"], true);
    } else {
      String errorMessage;
      if (apiResponse.error is String) {
        print(apiResponse.error.toString());
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        print(errorResponse.errors[0].message);
        errorMessage = errorResponse.errors[0].message;
      }
      responseModel = ResponseModel(errorMessage, false);
    }
    return responseModel;
  }

  dynamic getToken() async {
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

    var fcmToken = await _firebaseMessaging.getToken();
    print(fcmToken);

    return fcmToken;
  }
}
