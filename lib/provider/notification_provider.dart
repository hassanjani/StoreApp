import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:user_app/data/datasource/remote/dio/dio_client.dart';
import 'package:user_app/data/model/response/base/api_response.dart';
import 'package:user_app/data/model/response/notification_model.dart';
import 'package:user_app/data/repository/notification_repo.dart';
import 'package:user_app/helper/api_checker.dart';
import 'package:user_app/utill/app_constants.dart';

class NotificationProvider extends ChangeNotifier {
  final NotificationRepo notificationRepo;

  NotificationProvider({@required this.notificationRepo});

  List<NotificationDataModel> notificationList;

  int count = 0;

  // List<NotificationModel> get notificationList => _notificationList;

  DioClient dioClient;

  getCounts() async {
    final sl = GetIt.instance;
    dioClient = sl();
    Response response =
        await dioClient.get(AppConstants.NOTIFICATION_URI + "/count");
    print("counts: " + response.data.toString());
    count = response.data;
    notifyListeners();
  }

  Future<void> initNotificationList(BuildContext context) async {
    ApiResponse apiResponse = await notificationRepo.getNotificationList();
    if (apiResponse.response != null &&
        apiResponse.response.statusCode == 200) {
      notificationList = [];

      apiResponse.response.data.forEach((notification) =>
          notificationList.add(NotificationDataModel.fromJson(notification)));
      print(notificationList[0].data.letter.orderId);
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }
}
