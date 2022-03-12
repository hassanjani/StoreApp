import 'dart:convert';

import 'package:user_app/data/model/response/banner_model.dart';
import 'package:http/http.dart' as http;

import 'banner_model22.dart';

class ApiServicesClass {
  var url = Uri.parse('https://alhafizcloth.com/100min/api/v1/brands/1');
  //get requests
  Future<List<BannerModel22>> getData(List list) async {
    print('starting');
    http.Response response = await http.get(url);
    print(response.statusCode);
    print('enter into if');
    if (response.statusCode == 200) {
      print('get data');
      print('get dataaaaaaaaaaaaaaaaaaaa');
      var data = response.body;
      var decodedData = jsonDecode(data);
      List<BannerModel22> dataList = [];
      for (var item in decodedData) {
        print('inside if');
        final BannerModel22 model = BannerModel22(
          // id: item['id'],
          price: item['id'],
          // discount: item['discount'],
        );
        dataList.add(model);
      }
      print(dataList[0].price);
      print(dataList[1].discount);
      return dataList;
    }
  }
}
//
// import 'dart:async';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:user_app/banner_model22.dart';
//
// final _base = "https://home-hub-app.herokuapp.com";
// final _tokenEndpoint = "/api-token-auth/";
// final _tokenURL = _base + _tokenEndpoint;
//
// Future<Token> getToken(UserLogin userLogin) async {
//   print(_tokenURL);
//   final http.Response response = await http.post(
//     _tokenURL,
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(userLogin.toDatabaseJson()),
//   );
//   if (response.statusCode == 200) {
//     return Token.fromJson(json.decode(response.body));
//   } else {
//     print(json.decode(response.body).toString());
//     throw Exception(json.decode(response.body));
//   }
// }
