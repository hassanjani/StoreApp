import 'package:flutter/material.dart';
import 'package:user_app/data/datasource/remote/dio/dio_client.dart';
import 'package:user_app/data/datasource/remote/exception/api_error_handler.dart';
import 'package:user_app/data/model/response/base/api_response.dart';
import 'package:user_app/utill/Constrant.dart';
import 'package:user_app/utill/Lat_Long.dart';
import 'package:user_app/utill/app_constants.dart';

class ProductRepo {
  final DioClient dioClient;

  ProductRepo({@required this.dioClient});

  Future<ApiResponse> getLatestProductList(String offset) async {
    print("Ok 11");
    try {
      print("Ok 12");
      String puri = await determinePosition();
      print("puri");
      print(puri);
      final response = await dioClient.get(puri + offset);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      print("Ok 13");
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getSellerProductList(
      String sellerId, String offset) async {
    try {
      final response = await dioClient.get(AppConstants.SELLER_PRODUCT_URI +
          sellerId +
          '/products?limit=10&&offset=' +
          offset);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getBrandOrCategoryProductList(
      bool isBrand, String id) async {
    try {
      String uri = await determinePositionBrand();
      uri = '${uri}$id';
      // if (isBrand) {
      //   uri = '${BRAND_PRODUCT_URI}$id';
      //   // print(id);
      // } else {
      //   uri = '${BRAND_PRODUCT_URI}$id';
      //   print(id);
      // }
      final response = await dioClient.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getRelatedProductList(String id) async {
    try {
      final response =
          await dioClient.get(AppConstants.RELATED_PRODUCT_URI + id);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
